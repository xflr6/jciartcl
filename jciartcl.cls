%% jciartcl.cls - document class for the journal of constraint interaction
%% Version: 1.0
%% Author: Sebastian Bank <sebastian.bank@uni-leipzig.de>
%% Copyright 2016 Institut f\"ur Linguistik, Universit\"at Leipzig

% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Sebastian Bank.
%
% This work consists of the file jciartcl.cls.

% class metadata
\NeedsTeXFormat{LaTeX2e}[2001/06/01]
\ProvidesClass{jciartcl}[2016/04/21 v1.0 Journal of Constraint Interaction article class]

% class options
\RequirePackage{kvoptions}
\SetupKeyvalOptions{prefix=@}
	\DeclareStringOption[20XX]{year}
	\DeclareStringOption[X]{volume}
	\DeclareStringOption[X]{number}
	\DeclareStringOption[1]{startpage}
	\DeclareBoolOption{last}
	\DeclareBoolOption{prelims}
	\DeclareBoolOption{proofs}
	\DeclareStringOption[0mm]{binding}
	\DeclareStringOption{cclicense}[by]
	\DeclareStringOption{doi}
	\DeclareStringOption{urn}
\DeclareDefaultOption{\@unknownoptionerror}
\ProcessKeyvalOptions*\relax

% base upon koma article class
\PassOptionsToPackage{paper=a5}{typearea}
\LoadClass[%
	twoside,%
	headings=small,%
	fontsize=10pt,%
]{scrartcl}

% twoside
\if@last\else\AtEndDocument{\cleardoublepage}\fi

% language support
\RequirePackage[english]{babel}

\RequirePackage{ifxetex}
\ifxetex
	\RequirePackage{fontspec}
\else
	% input encoding
	\RequirePackage[utf8]{inputenc}

	% font encoding
	\RequirePackage[T1]{fontenc}

	% symbol fonts
	\RequirePackage{textcomp}
	\RequirePackage{pifont}
\fi

% serif font
\RequirePackage{lmodern}
\RequirePackage{libertine}

% micro typography
\RequirePackage{ifpdf}
\ifpdf\RequirePackage[%
	protrusion,%
	expansion,%
	auto,%
	stretch=35,%
	final,%
]{microtype}
\else\RequirePackage[%
	protrusion,%
	final,%
]{microtype}
\fi

% page layout
\RequirePackage[%
	centering,%
	total={318.67pt,495.93pt},%
	heightrounded,%
	headsep=10pt,%
	bindingoffset=\@binding,%
]{geometry}

% proofs
\if@proofs\RequirePackage[a4,center,cam]{crop}\else\fi

% sloppy layout
\tolerance 1414
\hbadness 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\vfuzz \hfuzz
\raggedbottom

% font styles
\addtokomafont{section}{\large}
\addtokomafont{subsection}{\mdseries}
\addtokomafont{subsubsection}{\mdseries\itshape}
\addtokomafont{pagehead}{\sffamily}
\addtokomafont{descriptionlabel}{\rmfamily}
\renewcommand*{\othersectionlevelsformat}[3]{#3\autodot\quad}

% page head
\RequirePackage{scrpage2}
	\pagestyle{scrheadings}
	\clearscrheadfoot
\RequirePackage{calc}
\AtBeginDocument{%
	\@ifundefined{@ceheading}{\let\@ceheading\@author}{}
	\@ifundefined{@coheading}{\let\@coheading\@shorttitle}{}
	\newlength{\@ceheadingw}\settowidth{\@ceheadingw}{\@ceheading}%
	\newlength{\@coheadingw}\settowidth{\@coheadingw}{\@coheading}%
	\newlength{\@ceheadingskip}\setlength{\@ceheadingskip}{\textwidth-\@ceheadingw-6em}%
	\newlength{\@coheadingskip}\setlength{\@coheadingskip}{\textwidth-\@coheadingw-6em}%
	\ohead{\pagemark}
	\cehead{\@ceheading\hspace{\@ceheadingskip}\mbox{}}
	\cohead{\mbox{}\hspace{\@coheadingskip}\@coheading}}

% title
\def\title{\@dblarg\title@}
\def\title@[#1]#2{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\newcommand{\@journal}{Journal of Constraint Interaction}
\newcommand{\acknowledgements}[1]{\newcommand{\@acknowledgements}{#1}}
\renewcommand{\maketitle}{
	\setcounter{page}{\@startpage}
	\thispagestyle{empty}
	\pdfbookmark[0]{\@shorttitle}{title}
	\@footer
	\newenvironment{@head}{\raggedleft}{}
	\begin{@head}
		{\Large\bfseries\sffamily\@title}\relax
		\bigskip\par
		\hfill\sffamily\@author\relax
		\ifdefined\@acknowledgements\@ackfootnote{\@acknowledgements}\else\fi
	\end{@head}}

% abstract
\renewenvironment{abstract}{\list{}{\rightmargin=0pt\leftmargin=0pt}%
	\item\relax{\large\sffamily\abstractname}\par\smallskip\itshape}{\endlist}

% acknowledgments footnote
\newcommand{\@ackfootnote}[1]{%
	\renewcommand{\thefootnote}{*}%
	\footnote{#1}%
	\addtocounter{footnote}{-1}}

% journal footer
\RequirePackage[absolute]{textpos}
\RequirePackage{lastpage}
\if\@cclicense\empty\else
	\RequirePackage[type={CC},modifier={\@cclicense},version={4.0}]{doclicense}
\fi
\newcommand{\@footer}{%
	\begin{textblock*}{\textwidth}(\paperwidth-\textwidth-\evensidemargin-1in,\paperheight-12ex)
	\noindent\sffamily\textsc{\@journal\ \@volume\ (\@year)}, \thepage--\pageref{LastPage}
	\if\@cclicense\empty\else\hfill\href{\doclicenseURL}{\doclicenseIcon}\fi%
	\if\@doi\empty\else\\\small\href{http://dx.doi.org/\@doi}{doi:\@doi}\fi%
	\if\@urn\empty\else\\\small\href{http://nbn-resolving.de/urn:\@urn}{urn:\@urn}\fi%
	\end{textblock*}}

% pdf settings
\RequirePackage[%
	breaklinks,%
	hidelinks,%
	bookmarks,%
	bookmarksnumbered,%
	bookmarksopen,%
	bookmarksopenlevel=2,%
	pdfpagelabels,%
	plainpages=false,%
	pdfdisplaydoctitle=true,%
	pdfstartview=FitH,%
	pdfpagemode=UseOutlines,%
	pdfprintscaling=None,%
]{hyperref}
\AtBeginDocument{\hypersetup{%
	pdfauthor={\@author},%
	pdftitle={\@title},%
	pdfsubject={\@journal\ \@volume\ (\@year)}}
\urlstyle{same}}

% footnotes
\deffootnote[1em]{0em}{1em}{\textsuperscript{\thefootnotemark}}
\renewcommand{\footnoterule}{}

% citations
\RequirePackage{natbib}
\setcitestyle{%
	authoryear,%
	round,%
	citesep={,},%
	aysep={},%
	yysep={,},%
	notesep={: },%
}

% references
\renewcommand{\bibsection}{\addsec{\refname}}
\renewcommand{\bibfont}{\small}
\setlength{\bibsep}{1pt plus 1pt}

% prelims
\if@prelims
	\author{}\title{Title page, table of contents}
	\newcommand{\@ceheading}{Contents}\newcommand{\@coheading}{Contents}
	\renewcommand{\maketitle}{
		\pagenumbering{roman}
		\setcounter{page}{\@startpage}
		\thispagestyle{empty}
		\sffamily\scshape\bfseries
		\noindent\hfill{\fontsize{20}{20}\selectfont\MakeLowercase{\@journal}}\par
		\large
		\noindent\hfill
		\@year\quad\textbullet\quad
		volume \@volume\quad\textbullet\quad
		number \@number\par
		\vspace{6ex}
		\noindent\textbf{edited by}\\
		{\normalfont Gereon M\"uller}\par
		\vspace{4ex}
		\noindent\textbf{associate editors}\\
		{\normalfont
		tba\\
		tba\\
		tba\\
		tba\\
		tba\\
		tba\\
		tba\\
		tba\\
		tba}\par
		\vfill
		\mdseries
		\noindent Institut f\"ur Linguistik\\
		Universit\"at Leipzig\\
		ISSN XXXX-XXXX
		\cleardoublepage\normalfont}
	\newcommand{\makecontents}{
		\pagenumbering{roman}
		\setcounter{page}{\@startpage}
		\thispagestyle{empty}
		\noindent{\Large\bfseries\sffamily Contents}\bigskip}
	\newenvironment{contents}%
		{\list{}{\leftmargin=1em\rightmargin=0pt\itemindent=-1em}{}}
		{\endlist}
\fi

\endinput