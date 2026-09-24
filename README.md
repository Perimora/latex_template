# LaTeX / Overleaf Template

Reusable modular template for LaTeX and Overleaf projects.

## Start a new project

1. Edit [`include/metadata.tex`](include/metadata.tex).
2. Replace the scaffold text in [`content/`](content/).
3. Add references to [`bibliography.bib`](bibliography.bib).
4. Put document assets under [`assets/img/`](assets/img/).
5. Compile [`main.tex`](main.tex) with pdfLaTeX/BibTeX (Overleaf's default PDFLaTeX workflow works).

## Rendering

The actual rendering logic lives in [`.github/workflows/render-main.yml`](.github/workflows/render-main.yml).

This workflow compiles [`main.tex`](main.tex), writes the result to [`out/main.pdf`](out/main.pdf), uploads the PDF as a GitHub Actions artifact, and commits the rendered PDF back to the repository.

It can be started manually from the GitHub Actions UI via `workflow_dispatch` and can also be reused by other workflows via `workflow_call`.

For automatic rendering, [`.github/workflows/render-on-push.yml`](.github/workflows/render-on-push.yml) runs after pushes to `main` when relevant document sources change, including [`main.tex`](main.tex), files below [`content/`](content/), [`include/`](include/), [`assets/img/`](assets/img/), [`bibliography.bib`](bibliography.bib), and LaTeX class/style files.

The push workflow delegates to the same reusable renderer, so manual and automatic builds use the identical render path.

Changes to [`out/`](out/) do not match the push workflow and therefore do not cause recursive render commits.

## Language

The default language is English. To use a different language, adjust the language option in `\usepackage[<language>]{babel}` within [`include/theme.tex`](include/theme.tex) (e.g., replace `english` with `ngerman` for German, `french` for French, etc.).

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](https://github.com/Perimora/faible_thesis/blob/main/LICENSE) for details.
