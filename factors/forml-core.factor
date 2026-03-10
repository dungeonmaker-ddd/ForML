# use-this-graph-to-build: ForML system root — every agent starts here
# confirm-sufficiency-before-start: this graph is the single source of truth for all ForML builds
# scope: forml-system-root
# status: updated

governance: [this-factor-is-authoritative-source, CLAUDE.md-is-human-readable-mirror, on-conflict:factor-wins, scopes-entire-project, scopes-factor-spec, critical]
governance.hierarchy: [forml-core.factor:defines-truth, CLAUDE.md:renders-for-humans, on-factor-change:sync-CLAUDE.md, on-CLAUDE.md-only-change:backport-to-factor-first, guards-single-source-of-truth, critical]
governance.agent-entry: [any-agent-reads-this-file-first, sufficient-to-build-without-CLAUDE.md, enables-autonomous-agent-operation, critical]
governance.chapter-factor-language: [all-chapter-factors:chinese-factor-words-permitted, reason:content-drives-chinese-html-pages, only-root-uses-english-factor-words, constrains-language-boundary, important]

project: [ForML, ml-intro-study-notes, flip-book-experience, deployed-on-github-pages, serves-knowledge-through-content, encodes-knowledge-via-factor-spec, presents-knowledge-via-visual, enables-all-downstream-builds, critical]
project.dual-output: [each-chapter-produces-two-artifacts, factor:knowledge-graph-agent-protocol, html:flip-book-human-readable, constrains-pipeline, critical]
project.language-rule: [content-body:chinese-only, decorative-labels:english-only, pattern:Chapter-NN-dot-Page-N|Key|Machine-Learning-Notes, guards-visual-consistency, critical]

structure: [index.html:site-entry-day-nav, dayNN-book.html:per-day-aggregated-flip-book, chN-book.html:legacy-per-chapter-books, factors/:all-factor-graphs, enables-file-discovery, critical]
structure.naming: [day-book:dayNN-book.html, chapter-factor:chN-topic-slug.factor, day-outline:ch00-is-day01-outline, root:forml-core.factor, constrains-file-creation, critical]
structure.aggregation: [day-book-is-primary-artifact:aggregates-multiple-chapter-factors, individual-chN-book.html:retained-as-legacy-not-primary, day-outline-factor:defines-page-structure-for-day-book, prevents-content-fragmentation, critical]
structure.no-extra-files: [no-standalone-css, no-standalone-js, each-html-is-self-contained:style-and-script-inline, prevents-dependency-fragmentation, critical]

content: [course-knowledge-entry-point, organized-by-day, each-day-has-outline-factor-and-aggregated-html, feeds-build-order, maps-to-curriculum, critical]
content.registry: [ch01:ai-ml-dl-concepts, ch02:ml-terminology, ch03:algorithm-classification, ch04:modeling-pipeline, ch05:feature-engineering, ch06:model-fitting, ch07:homework, ch08:knn-intro, ch09:knn-practice, feeds-navigation-and-linking, critical]
content.day01-outline: [@factors/ch00-ml-intro-index.factor, serves-as-day01-toc-and-page-plan, aggregates:ch01+ch02+ch03+ch04+ch05+ch06+ch07+ch08, builds:day01-book.html, critical]
content.insight: [data-and-features-set-ml-ceiling, train-test-must-separate, model-complexity-needs-balance, fit_transform-on-train-only:prevents-data-leakage, feeds-cross-chapter-coherence, critical]

curriculum: [day-based-organization, each-day-groups-related-chapters, day-is-learning-unit:one-sitting-of-study, constrains-learning-path, constrains-pipeline-build-order, critical]

curriculum.day01: [ML入门基础, ch01-ch08, goal:from-zero-to-first-algorithm, covers:concepts->terminology->algorithm-types->pipeline->feature-engineering->fitting->homework->knn-intro, feeds-day02, critical]
curriculum.day01.unit-concepts: [ch01+ch02, what-is-ml:AI>ML>DL-nesting|data-driven-not-rules|y=wx+b, data-vocabulary:sample|feature|label|dataset|train-test-split, enables-terminology-grounding, critical]
curriculum.day01.unit-methodology: [ch03+ch04, algorithm-taxonomy:supervised|unsupervised|semi-supervised|reinforcement, pipeline:5-steps-with-feedback-loop, insight:data-ceiling, enables-structured-thinking, critical]
curriculum.day01.unit-engineering: [ch05+ch06, feature-engineering:5-sub-domains, preprocessing:normalization-vs-standardization, fitting:underfitting|overfitting|just-right, loss-curve-diagnosis, occam-razor, enables-quality-control, critical]
curriculum.day01.unit-integration: [ch07+ch08, homework:cross-chapter-synthesis-Q2-to-Q5, knn-intro:K-nearest-neighbors-concept|classification-vs-regression|distance-metric|hyperparameter, validates-day01-comprehension, critical]

curriculum.day02: [KNN实战深化, ch09+, goal:from-algorithm-concept-to-production-pipeline, requires-day01, covers:distance-metrics-deep-dive->preprocessing-iron-law->iris-pipeline->cross-validation->grid-search->MNIST, critical]
curriculum.day02.ch09: [knn-practice, @factors/ch09-knn-practice.factor, 7-content-pages, covers:knn-flow-detail|k-value-tradeoff|distance-metrics-4-types|preprocessing-iron-law-data-leakage|iris-full-pipeline|cross-validation-vs-holdout|grid-search-MNIST, enables-first-complete-algorithm-mastery, critical]

factor-spec: [suffix:.factor, plain-text, one-file-per-knowledge-unit, constrains-all-graph-authoring, constrains-pipeline, every-chapter-graph-obeys-this, critical]
factor-spec.header: [required-directives:use-this-graph-to-build|scope|status, status-enum:pending|built|updated, guards-graph-identity, critical]
factor-spec.node-format: [pattern:topic.facet:[factor-words], left-side:implementation-detail, right-side:intent-and-weight, enables-machine-parsing, critical]
factor-spec.edge-format: [pattern:A->B:[relation-type-weight], expresses:dependency|causation|sequence, enables-graph-traversal, critical]
factor-spec.weight-system: [critical:core-must-have, important:significant-but-not-blocking, low-priority:supplementary, constrains-density-budget, critical]
factor-spec.completeness: [tail-score:#~N%, threshold:80%-permits-delivery, below-80%:self-strengthen-before-emit, guards-output-quality, critical]
factor-spec.density-rule: [hyphen-connects-multi-word, forbid-natural-sentences, core-nodes-embed-concrete-values-and-constraints, enables-act-without-lookup, critical]
factor-spec.bracket-layout: [left:implementation-how-what, right:intent-why-weight, position-carries-meaning, critical]
factor-spec.ratio: [core-content:>70%, auxiliary-content:<30%, forbid-auxiliary-self-description, prevents-bloat, critical]
factor-spec.homework-pattern: [organize-by:phenomenon->cause->countermeasure, constrains-answer-structure, important]
factor-spec.cross-ref: [@path/to/file:links-subgraph, arrow-in-edge:learning-sequence, insight.*:cross-chapter-truth, enables-graph-navigation, important]
factor-spec.comment-rule: [only-hash-comments, permitted:header-directives|section-labels|tail-score, forbid:decorative-separators|ascii-art|inline-prose, guards-signal-to-noise, important]

visual: [scholars-desk-aesthetic, xuan-paper-warm-base, ink-wash-palette, calligraphy-titles, 3d-page-flip, defines-entire-visual-identity, materializes-as-page, decomposes-into-component, includes-emphasis, critical]

visual.palette: [css-custom-property-system, 8-named-colors, agents-must-use-var(--name)-never-raw-hex-in-markup, feeds-emphasis-colors, feeds-component-styles, enables-theme-consistency, critical]
visual.palette.surface: [--paper:#f5f0e8:xuan-paper-page-bg, --paper-dark:#e8e0d0:deeper-paper-alt-sections, grounds-reading-surface, critical]
visual.palette.ink: [--ink:#2c1810:primary-body-text, --ink-light:#5a4a3a:secondary-body-text, --ink-faint:#9a8a7a:annotations|page-markers, establishes-typographic-hierarchy, critical]
visual.palette.semantic: [--vermillion:#c41e3a:emphasis|labels|key-points, --blue-ink:#2a4a6b:features|param-w|terminology, --green-ink:#2a6b4a:param-b|positive-concepts, --gold:#b8943e:decorative-lines|predictions, drives-meaning-through-color, critical]

visual.typography: [three-font-stack, critical]
visual.typography.heading: [font-family:ZCOOL-XiaoWei-serif, role:chinese-chapter-and-section-titles, imports-from-google-fonts, establishes-calligraphy-feel, critical]
visual.typography.body: [font-family:Noto-Serif-SC-serif, role:chinese-body-text, weight:400|700, imports-from-google-fonts, ensures-readability, critical]
visual.typography.label: [font-family:Crimson-Pro-serif, role:english-text|numbers|page-indicators, weight:400|600, imports-from-google-fonts, bridges-east-west-typesetting, critical]

visual.desktop: [body-bg:#1a1612:dark-desk-surface, body::before:radial-gradient(ellipse-at-50%-40%-#2a2320-0%-#1a1612-70%), creates-ambient-depth-around-book, critical]

page: [content-driven-page-count, page-0:prologue-cover-always, page-1-to-N:content-pages, page-last:chapter-summary-always, N-determined-by-factor-graph-critical-node-count, hosts-interaction, constrains-chapter-layout, critical]
page.count-rule: [count-critical-nodes-in-chapter-factor, group-related-nodes:max-5-knowledge-points-per-page, N=ceil(critical-nodes/density-per-page), no-artificial-cap:7-pages-was-old-constraint, content-must-not-be-dropped-to-fit-page-limit, prevents-information-loss, critical]
page.cover: [shows:chapter-number|title|english-subtitle|section-toc, establishes-chapter-identity, critical]
page.cover.format: [number-format:Chapter-NN, subtitle:english-short-phrase, toc:ordered-list-of-section-titles, enables-reader-orientation, critical]
page.content: [one-section-per-page, derive-from-factor-graph-nodes, page-count-scales-with-content-not-arbitrary-limit, bridges-factor-to-visual, critical]
page.summary: [uses:.summary-list-component, includes:next-chapter-preview-in-insight-box, closes-learning-loop, critical]

density: [maximize-information-per-page, no-visual-wasteland, every-page-must-feel-full, constrains-page-content-volume, requires-minimum-component-usage, gates-pipeline-step-2-quality, critical]
density.knowledge-floor: [minimum:5-distinct-knowledge-points-per-content-page, merge-thin-sections-if-needed:two-related-topics-share-one-page, prevents-sparse-pages, critical]
density.component-floor: [minimum:3-components-per-content-page, counting:note-box|insight-box|compare-row|data-table|formula-block|param-cards|flow-steps|svg-diagram, prevents-text-wall-pages, critical]
density.no-bottom-void: [visible-content-must-fill-page-viewport, if-whitespace-remains:add-insight-box|cross-chapter-link|supplementary-example, prevents-dead-space, critical]
density.factor-node-packing: [all-critical-nodes:must-get-dedicated-component-not-just-prose, important-nodes:must-appear-as-structured-content-not-only-mention, low-priority:prose-or-glossary-acceptable, ensures-factor-fidelity-in-html, critical]
density.multi-topic-page: [when-single-topic-too-thin-for-full-page:group-related-nodes-into-composite-pages, use-compare-row-to-juxtapose|use-flow-steps-to-serialize|use-param-cards-to-parallelize, prevents-sparse-pages-not-content-dropping, critical]
density.glossary: [every-content-page-must-have-glossary-at-bottom, higher-density-demands-stronger-glossary, dense-page-introduces-many-terms:glossary-is-safety-net, without-glossary:density-overwhelms|with-glossary:density-becomes-learnable, materializes-as-component-glossary, serves-as-decompression-anchor, critical]
density.glossary.floor: [minimum:4-terms-per-content-page, scale-with-density:5+knowledge-points-demands-4+terms, prevents-undefined-jargon-accumulation, critical]
density.glossary.format: [each-term:english-name-in-blue-emphasis|chinese-name|one-line-definition, emit:<div-class="glossary"><div-class="glossary-item"><span-class="blue">English</span>-中文名:定义</div>...</div>, enables-bilingual-lookup, critical]
density.glossary.source: [terms-extracted-from:page-content-factor-nodes, prioritize:first-appearance-terms|easily-confused-pairs|abbreviated-forms, cover-every-highlighted-or-blue-span-term-on-page, guards-no-term-left-undefined, critical]
density.anti-pattern: [forbid:single-paragraph-then-single-note-box-then-empty, forbid:concept-mentioned-only-in-text-without-visual-anchor, forbid:page-with-fewer-than-3-components, these-are-red-flags-for-sparse-build, critical]

component: [html-css-class-system, reusable-across-all-chapters, uses-emphasis-spans-internally, enables-visual-consistency, critical]
component.note-box: [css:.note-box, border-left:3px-solid-var(--vermillion), bg:rgba(196-30-58-0.05), role:key-points|warnings, emit:<div-class="note-box"><strong>label</strong>content</div>, guards-reader-attention, critical]
component.insight-box: [css:.insight-box, border-left:3px-solid-var(--blue-ink), bg:rgba(42-74-107-0.05), role:preview|deep-understanding, emit:<div-class="insight-box"><strong>label</strong>content</div>, feeds-curiosity, critical]
component.compare: [css:.compare-row>.compare-card, display:flex-gap, emit:<div-class="compare-row"><div-class="compare-card"><h4>A</h4>content</div><div-class="compare-card"><h4>B</h4>content</div></div>, enables-contrast-learning, important]
component.table: [css:.data-table, full-width-border-collapse, emit:<table-class="data-table"><thead>...</thead><tbody>...</tbody></table>, important]
component.formula: [css:.formula-block>.formula, centered-large-font, emit:<div-class="formula-block"><div-class="formula">y=wx+b</div></div>, important]
component.param-cards: [css:.param-cards>.param-card, side-by-side-colored-cards, w-card:blue-ink|b-card:green-ink, emit:<div-class="param-cards"><div-class="param-card">...</div><div-class="param-card">...</div></div>, important]
component.flow: [css:.flow-steps>.flow-step, numbered-circle-steps, step-number-in-::before, emit:<div-class="flow-steps"><div-class="flow-step"><h4>title</h4><p>desc</p></div>...</div>, visualizes-process, important]
component.summary: [css:.summary-list, counter-reset-auto-number, emit:<div-class="summary-list"><div-class="summary-item"><h4>title</h4><p>desc</p></div>...</div>, important]
component.venn: [css:.venn-container, nested-circles-absolute-positioned, low-priority]
component.glossary: [css:.glossary>.glossary-item, bottom-of-every-content-page, border-top:1px-solid-var(--gold), emit:<div-class="glossary"><div-class="glossary-item"><span-class="blue">Term</span>-术语:one-line-definition</div>...</div>, anchors-terminology-for-dense-pages, critical]

emphasis: [four-semantic-colors-plus-bold, inline-markup-patterns, drives-meaning-at-word-level, critical]
emphasis.vermillion: [emit:<span-class="highlight">text</span>, color:var(--vermillion), marks:key-concept|critical-term|definition, critical]
emphasis.blue: [emit:<span-class="blue">text</span>, color:var(--blue-ink), marks:terminology|feature-name|param-w, critical]
emphasis.green: [emit:<span-class="green">text</span>, color:var(--green-ink), marks:positive-concept|param-b|correct-answer, important]
emphasis.gold: [emit:<span-class="gold">text</span>, color:var(--gold), marks:prediction-value|decoration, important]
emphasis.bold: [emit:<strong>text</strong>, weight-only-no-color, marks:structural-emphasis|sub-heading-inline, important]

interaction: [css-3d-flip-book, perspective:1200px, transition:transform-0.8s, delivers-physical-book-feel, critical]
interaction.flip: [transform-origin:left-center, active-page:rotateY(0deg), flipped-page:rotateY(-180deg), backface-visibility:hidden, enables-page-turn, critical]
interaction.navigation: [bottom-bar:prev-next-buttons+dot-indicators, dot-active-class:marks-current-page, enables-page-traversal, critical]
interaction.keyboard: [addEventListener-keydown, ArrowLeft:prev-page, ArrowRight:next-page, enables-desktop-navigation, important]
interaction.touch: [touchstart-touchend-delta, swipe-left:next-page, swipe-right:prev-page, threshold:50px, enables-mobile-navigation, important]
interaction.animation: [fadeUp-keyframe:opacity-0-to-1+translateY-20px-to-0, staggered-delay:each-child-+0.1s, triggers-on-page-become-active, polishes-page-reveal, important]

pipeline: [day-aggregation-build, must-follow-in-order, constrained-by-factor-spec, constrained-by-curriculum-sequence, registers-into-content, critical]
pipeline.step-1: [author-chapter-factors:factors/chN-topic.factor, one-per-knowledge-unit, factor-graph-is-single-source-of-truth, enforced-by-iron-law, critical]
pipeline.step-2: [author-day-outline:ch00-serves-as-day01-outline, defines-page-grouping:which-chapter-nodes-go-on-which-page, gates-step-3, critical]
pipeline.step-3: [build:dayNN-book.html, aggregate-multiple-chapter-factors-into-one-book, derive-page-structure-from-day-outline, reuse-full-css-js-framework, self-contained:inline-style-and-script, gated-by-density-policy, bridges-factor-to-reader, critical]
pipeline.step-4: [register-in:index.html, add-day-nav-link, enables-site-discovery, important]
pipeline.iron-law: [factor-is-upstream:html-derives-from-factor, never-reverse:html-must-not-define-truth, on-content-change:update-factor-first-then-rebuild-html, enforces-step-1-primacy, guards-system-integrity, critical]

# ~97%
