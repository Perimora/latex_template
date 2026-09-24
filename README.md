# LaTeX / Overleaf Template

Reusable modular template for LaTeX and Overleaf projects.

## Design goals

- one small `main.tex` as the document entry point;
- reusable visual/package setup in `include/theme.tex`;
- project-specific values in `include/metadata.tex`;
- modular front matter and content in `content/`;
- project-support material grouped under `doc/` (`doc/img`, `doc/img/diagrams/views`, `doc/img/layouts`, `doc/specifications`);
- native LaTeX/TikZ title page — no rendered PDF background;
- directly importable into Overleaf as a ZIP.

## Start a new project

1. Edit `include/metadata.tex`.
2. Replace the scaffold text in `content/`.
3. Add references to `bibliography.bib`.
4. Put document assets under `doc/`: figures/layout assets in `doc/img/`, diagram sources in `doc/img/diagrams/views/`, and project notes/specifications in `doc/specifications/`.
5. Compile `main.tex` with pdfLaTeX/BibTeX (Overleaf's default PDFLaTeX workflow works).

## Title-page graphics

The default mark is defined as the `\TemplateLogo` TikZ macro in `include/theme.tex`.
There is intentionally no `frontpage.pdf`, no PDF-page background, and no dependency on a pre-rendered title page.
For a project-specific native logo, redefine `\TemplateLogo` with TikZ/vector primitives.

## Language

The default language is English. For a German document, change
`\usepackage[english]{babel}` to `\usepackage[ngerman]{babel}` in `include/theme.tex`.

## Project support structure

```text
doc/
├── img/
│   ├── diagrams/
│   │   └── views/
│   └── layouts/
└── specifications/
```

`doc/img/layouts/` is intentionally only a source/assets location. The template title page itself remains fully native LaTeX/TikZ and does not depend on a rendered PDF background.
