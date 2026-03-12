"""
Claude Code 导出文本 → 可预览 HTML
解析 > ● ✻ ⎿ 等标记，生成带样式的对话页面
"""
import re
import html

def parse_conversation(text):
    """解析导出文本为消息列表"""
    lines = text.split('\n')
    messages = []
    current = None

    # 跳过头部 (Claude Code banner)
    start = 0
    for i, line in enumerate(lines):
        stripped = line.lstrip()
        if stripped.startswith('> ') or stripped.startswith('● '):
            start = i
            break

    for line in lines[start:]:
        stripped = line.lstrip()

        # 用户消息
        if stripped.startswith('> '):
            if current:
                messages.append(current)
            content = stripped[2:]
            current = {'role': 'user', 'lines': [content]}

        # AI 消息/操作
        elif stripped.startswith('● '):
            content = stripped[2:]
            # 工具调用行 (Write/Bash/Read等)
            is_tool = bool(re.match(
                r'^(Write|Bash|Read|Glob|Grep|Searched|Edit)\b', content))
            if is_tool:
                if current:
                    messages.append(current)
                current = {'role': 'tool', 'lines': [content]}
            else:
                if current and current['role'] == 'assistant':
                    current['lines'].append(content)
                else:
                    if current:
                        messages.append(current)
                    current = {'role': 'assistant', 'lines': [content]}

        # 思考时间
        elif stripped.startswith('✻ '):
            if current:
                messages.append(current)
            current = {'role': 'thinking', 'lines': [stripped[2:]]}

        # 工具输出
        elif stripped.startswith('⎿'):
            content = stripped[1:].lstrip()
            if current and current['role'] == 'tool':
                current['lines'].append(content)
            else:
                if current:
                    messages.append(current)
                current = {'role': 'tool_output', 'lines': [content]}

        # 续行
        elif stripped and current:
            # 带缩进的续行
            if line.startswith('  ') or line.startswith('\t'):
                current['lines'].append(stripped)
            elif current['role'] in ('tool', 'tool_output'):
                current['lines'].append(stripped)
            elif current['role'] in ('assistant', 'user'):
                current['lines'].append(stripped)

        # 空行
        elif not stripped and current:
            current['lines'].append('')

    if current:
        messages.append(current)

    return messages


def detect_code_blocks(text):
    """检测文本中的代码块和普通文本，返回HTML"""
    # 简单策略：连续的缩进行或包含代码特征的行视为代码
    lines = text.split('\n')
    result = []
    in_code = False
    code_buf = []

    for line in lines:
        is_code_line = (
            re.match(r'^  \S', line) and (
                re.search(r'[=\[\]{}<>|#%@\-]{3,}', line) or
                re.search(r'^\s*(def |class |import |from |print|for |if |#)',
                          line) or
                re.search(r'^\s*[\d.]+\s*\|', line) or
                re.search(r'^\s*[#.oOX@%*+=\-:]{4,}', line) or
                re.search(r'^\s*\[[\d, .]+\]', line)
            )
        )

        if is_code_line and not in_code:
            in_code = True
            code_buf = [line]
        elif is_code_line and in_code:
            code_buf.append(line)
        elif in_code and not line.strip():
            code_buf.append(line)
        else:
            if in_code:
                result.append(('code', '\n'.join(code_buf)))
                code_buf = []
                in_code = False
            result.append(('text', line))

    if in_code:
        result.append(('code', '\n'.join(code_buf)))

    return result


def format_text(text):
    """将文本转为HTML，处理加粗、代码等"""
    t = html.escape(text)
    # **bold**
    t = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', t)
    # `code`
    t = re.sub(r'`([^`]+)`', r'<code>\1</code>', t)
    return t


def msg_to_html(msg):
    """单条消息转HTML"""
    role = msg['role']
    text = '\n'.join(msg['lines']).strip()
    if not text:
        return ''

    if role == 'user':
        content = format_text(text)
        content = content.replace('\n', '<br>')
        return f'<div class="msg user"><div class="label">You</div>{content}</div>'

    elif role == 'assistant':
        parts = detect_code_blocks(text)
        inner = ''
        for kind, chunk in parts:
            if kind == 'code':
                inner += f'<pre><code>{html.escape(chunk)}</code></pre>'
            else:
                line = format_text(chunk)
                if line.strip():
                    inner += f'<p>{line}</p>'
                else:
                    inner += '<br>'
        return f'<div class="msg ai"><div class="label">Claude</div>{inner}</div>'

    elif role == 'tool':
        t = html.escape(text)
        return f'<div class="msg tool"><div class="label">Tool</div><pre>{t}</pre></div>'

    elif role == 'tool_output':
        t = html.escape(text)
        return f'<div class="msg tool-out"><pre>{t}</pre></div>'

    elif role == 'thinking':
        t = html.escape(text)
        return f'<div class="msg thinking">{t}</div>'

    return ''
