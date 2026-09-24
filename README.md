# LaTeX / Overleaf Template

Reusable modular template for LaTeX and Overleaf projects.

## Start a new project

1. Edit [`include/metadata.tex`](include/metadata.tex).
2. Replace the scaffold text in [`content/`](content/).
3. Add references to [`bibliography.bib`](bibliography.bib).
4. Put document assets under [`img/`](img/).
5. Compile [`main.tex`](main.tex) with pdfLaTeX/BibTeX (Overleaf's default PDFLaTeX workflow works).

## Automated rendering

After a push to `main`, the GitHub Actions workflow in [`.github/workflows/render-latex.yml`](.github/workflows/render-latex.yml) detects whether relevant LaTeX sources have changed.

If changes affecting the document are detected, [`main.tex`](main.tex) is compiled automatically. The rendered PDF is written to [`out/main.pdf`](out/main.pdf) and committed back to the repository.

Changes inside [`out/`](out/) do not trigger another build, preventing recursive render commits.

The compiled PDF is also available as a GitHub Actions artifact for the corresponding workflow run.

## Language

The default language is English. To use a different language, adjust the language option in `\usepackage[<language>]{babel}` within [`include/theme.tex`](include/theme.tex) (e.g., replace `english` with `ngerman` for German, `french` for French, etc.).

