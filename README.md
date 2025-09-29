jciartcl
========

[![Build](https://github.com/xflr6/jciartcl/actions/workflows/build.yaml/badge.svg?branch=master)](https://github.com/xflr6/jciartcl/actions/workflows/build.yaml?query=branch%3Amaster)

LaTeX document class and issue skeleton for typesetting articles for the
Journal of Constraint Interaction.


Links
-----

- GitHub: https://github.com/xflr6/jciartcl
- Download: https://github.com/xflr6/jciartcl/releases
- Issue Tracker: https://github.com/xflr6/jciartcl/issues


Quickstart
----------

Copy the class file `jciartcl.cls` and the bibstyle `unified.bst`
into your document directory.
Create your (UTF-8 encoded) `<articlename>.tex` LaTeX-file using
the following basic skeleton:

```latex
\documentclass{jciartcl}

\author{}
\title{}
%\acknowledgements{}

\begin{document}

\maketitle

%\begin{abstract}
%\end{abstract}

\bibliographystyle{unified}
%\bibliography{}

\end{document}
```

To include an asterisk-marked special footnote on the first page,
uncomment and fill the `\acknowledgements{}` command.

To include an abstract, uncomment and fill the `abstract`-enviroment.

See the `knuth_lamport/` [directory] for a mininal example.


Options
-------

To output **proofs** with crop marks instead of a plain article,
add the `proofs` class option:

```latex
% create A4 output with centered article pages
\documentclass[proofs]{jciartcl}
(...)
```

`jciartcl` provides the following class options for setting
the **meta data** (filled by the editors):

option |description          |default
-------|---------------------|-------
year   |journal issue year   |20XX
volume |jourmal issue volume |X
number |journal issue number |X

The following options are used for combining
a collection of articles into an issue:

option    |description                           |default
----------|--------------------------------------|-------
startpage |first page number of the article      |1
last      |omit \cleardoublepage at article end  |*unset*
prelims   |typeset title/toc instead of article  |*unset*
binding   |add bindingoffset for booklet version |0mm

The following options can be used to add information to
the journal footline on the first page of each article:

option    |description    |default
----------|---------------|-------
cclicense |add CC BY 4.0  |*unset*
doi       |add DOI field  |*unset*
urn       |add URN field  |*unset*


Issue preparation
-----------------

Table of contents creation, setting of page numbers, and compiling and
combining the individual articles of an issue can be automatized with
`latexpages`.

**Requirements**:

- [Python] 3.10+
- [latexpages] 0.6 or later (installable via `pip install latexpages`)
- either [TeX Live] and [latexmk] or [MikTeX]
- either `pdfinfo` ([poppler]-utils, [miktex-poppler-bin], [xpdf]) or [pdftk][]
  (for page number computations)

On Ubuntu, for example, the following should suffice:

```sh
$ sudo apt install python python-pip
$ sudo -H pip install latexpages
$ sudo apt install texlive texlive-fonts-extra texlive-humanities latexmk poppler-utils
```

Download the ZIP-file or tarball of the latest [jciartcl release], extract it,
rename and enter the main directory.

Put all articles into subdirectories named after the contained `.tex` file, e.g.:

```
jci42/
    jciartcl.cls
    latexpages.ini
    unified.bst
    article1/
        article1.tex
        references.bib
    article2/
        article2.tex
        ...
```

Edit the articles so that they all use the central `jciartcl.cls` and
`unified.bst` from their parent directory.
Add a dummy start page with the `startpage` class option to be updated by
`latexpages-paginate`:

```latex
\documentclass[startpage=1]{../jciartcl}
...
\bibliographystyle{../unified}
...
```

For the last article, append the `last` option:

```latex
\documentclass[startpage=1,last]{../jciartcl}
...
```

Edit `latexpagex.ini`. In the `[parts]` section, `mainmatter` defines the
article directories for compilation and combination (and their order):

```ini
[parts]
mainmatter =
  article1
  article2
```

On the command line, enter the main directory and execute `latexpages`. This
will compile all articles. In case of errors, try to disable parallel
compillation first by executing `latexpages --processes 1` instead.

Execute `latexpages-paginate` to determine the number of pages of each article
and update their start pages and the table of contents accordingly. Rerun
`latexpages` once again to update the result, which is written to the `_output`
directory.

See the [latexpages] documentation for more details on the `latexpagex.ini`
settings and the command line interface.


Bundled files
-------------

This bundle contains the following third-party files:

- http://celxj.org/downloads/unified.bst (CELxJ Unified Style Sheet for Linguistics)


Further reading
---------------

- https://www.ctan.org/pkg/koma-script
- https://www.ctan.org/pkg/geometry
- https://www.ctan.org/pkg/pdfpages
- https://www.ctan.org/pkg/crop
- https://www.ctan.org/pkg/libertine
- https://www.ctan.org/pkg/microtype
- https://www.ctan.org/pkg/hyperref
- https://www.ctan.org/pkg/textpos
- https://www.ctan.org/pkg/lastpage
- https://www.ctan.org/pkg/doclicense
- https://www.ctan.org/pkg/natbib
- https://www.ctan.org/pkg/linguex


See also
--------

- https://www.ctan.org/topic/journalpub
- https://www.ctan.org/topic/compilation


Changelog
---------

Version 1.1: Bump `latexpages` dependency to 0.6 favoring poppler over ptftk.

Version 1.0: Initial release.


License
-------

Jciartcl is distributed under the [LaTeX Project Public License].


[Python]: https://www.python.org
[latexpages]: https://pypi.python.org/pypi/latexpages
[TeX Live]: https://www.tug.org/texlive/
[MikTeX]: https://miktex.org
[latexmk]: http://personal.psu.edu/jcc8/software/latexmk-jcc/
[poppler]: https://poppler.freedesktop.org
[miktex-poppler-bin]: https://www.ctan.org/search/?phrase=miktex-poppler-bin&ext=true&FILES=on
[xpdf]: http://www.foolabs.com/xpdf/
[pdftk]: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
[jciartcl release]: https://github.com/xflr6/jciartcl/releases
[directory]: https://github.com/xflr6/jciartcl/tree/master/knuth_lamport
[LaTeX Project Public License]: https://www.latex-project.org/lppl.txt
