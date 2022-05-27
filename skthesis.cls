\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skthesis}[10/02/2018]

%\usepackage{indentfirst} % TODO

\def\mystretch{1.4}		% Double spacing hack
%% `vi' and `upcase' document style options.  Krishna Sethuraman (1990)
\DeclareOption{upcase}{\typeout{Uppercase cover page.}
	\gdef\choosecase#1{\uppercase\expandafter{#1}}}
\def\choosecase#1{#1}

%% leftblank option by Kevin Fu

%  Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

\usepackage[russian, english]{babel}
\usepackage[utf8]{inputenc}

\usepackage{fontspec}
\defaultfontfeatures[Times New Roman]{
	Extension = .ttf ,
	UprightFont = fonts/times,
	BoldFont = fonts/timesbd,
	ItalicFont = fonts/timesi,
	BoldItalicFont = fonts/timesbi
	}	
\setmainfont{Times New Roman}	
\newfontfamily\cyrillicfont{Times New Roman}

\usepackage{titlesec}
\titleformat{\chapter}[display]
  {\normalfont\Large\bfseries\centering}
  {\chaptertitlename\ \thechapter}{0pt}{\Huge}
% \titleformat{\section}
%   {\normalfont\large\bfseries\centering}
%   {\thesection}{1em}{}
\titlespacing*{\chapter}{0pt}{30pt}{20pt}



% If the user wants single spacing, set baselinestretch=1.

\usepackage{setspace}

% Note - doublespace.sty has some float-related troubles in
% combination with graphics or color, and is not officially compliant
% with 2e.  setspace is a replacement which is 2e-compliant.

% Read the doublespace style that we got from Rochester:
%\input setdoublespace.sty 		

\def\baselinestretch{\mystretch}	% Double spacing hack

\setlength{\parindent}{10mm}
\setlength{\parskip}{6pt}
%%%%%%%  Set up margins and formatting params %%%

% Margins.
%  Note we want 1in top margin assuming no header line, so push header
%	into 1in margin.
%  Draft mode brings the header back down.

\usepackage{geometry}
\geometry{left=3cm}
\geometry{right=1.5cm}
 \geometry{top=2cm}
 \geometry{bottom=2cm}

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.
    % If we have a header, it must be 1in from top of page.
\def\pulldownheader{			% Shift header down 1in from top
    \addtolength{\topmargin}{\headheight}	
    \addtolength{\topmargin}{\headsep}	
    \addtolength{\textheight}{-\headheight}
    \addtolength{\textheight}{-\headsep}
}
    % If we have a footer, put it 1in up from bottom
\def\pullupfooter{				% Shift footer up
    \addtolength{\textheight}{-\footskip}
%    \addtolength{\textheight}{-\footheight}  %footheight doesn't
%    						exist in 2e
}

%%%%%%%  End of margins and formatting params %%%

\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

\def\department#1{\gdef\@department{#1}}
\def\departmentrus#1{\gdef\@departmentrus{#1}}
% If you are getting two degrees, use \and between the names.
\def\degree#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degree{#1}}

\def\degreerus#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degreerus{#1}}

% \and is used inside the \degree argument to separate two degrees
\def\and{\gdef\@degreeword{degrees} \par and \par}
\def\@degreeword{degree}


\def\copyrightnotice#1{\copyrightnoticetext{\copyright\ #1.  All rights
reserved.}}
\def\copyrightnoticerus#1{\copyrightnoticetextrus{\copyright\ #1.  Все права защищены.}}
% Occacionally you will need to exactly specify the text of the 
% copyright notice.  The \copyrightnoticetext command is then useful.
\long\def\copyrightnoticetext#1{\gdef\@copyrightnotice{#1}}
\def\@copyrightnotice{All rights reserved.\copyright\\
The author hereby grants to Skoltech permission to reproduce and to distribute publicly paper and electronic copies
of this thesis document in whole and in part in any medium now known or hereafter created.}

\long\def\copyrightnoticetextrus#1{\gdef\@copyrightnoticerus{#1}}
\def\@copyrightnoticerus{Все права защищены.\copyright\\
Автор настоящим дает Сколковскому институту науки и технологий
разрешение на воспроизводство и свободное распространение бумажных и электронных копий настоящей
диссертации в целом или частично на любом ныне существующем или созданном в будущем носителе.
}


\def\thesisdate#1{\gdef\@thesisdate{#1}}

\def\thesisdaterus#1{\gdef\@thesisdaterus{#1}}

% authors's name and title in russian
\def\authorrus#1{\gdef\@authorrus{#1}}
\def\titlerus#1{\gdef\@titlerus{#1}}


% typically just a month and year
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreemonthrus#1{\gdef\@degreemonthrus{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}
% Usage: \supervisor{name}{title}
%        \chairman{name}{title}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor \newbox\@titlecovisor	\newbox\@abstractsupervisor

\newbox\@titlerussupervisor \newbox\@titleruscovisor \newbox\@abstractrussupervisor


\def\supervisor#1#2#3{\setbox\@titlesupervisor\vbox
  {\unvbox\@titlesupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Research Advisor:}{#1 \\ #2}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Research Advisor: \\ Name: #1 \\ Degree: #3 \\ Title: #2}}

\def\supervisorrus#1#2#3{\setbox\@titlerussupervisor\vbox
  {\unvbox\@titlerussupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Научный руководитель:}{#1 \\ #2}}
  \setbox\@abstractrussupervisor\vbox{\unvbox\@abstractrussupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Научный руководитель: \\ Имя: #1 \\ Ученое звание, степень: #3 \\ Должность: #2}}


\def\cosupervisor#1#2#3{\setbox\@titlecovisor\vbox
  {\unvbox\@titlecovisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Co-Advisor:}{#1 \\ #2}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Co-Advisor: \\ Name: #1 \\ Degree: #3 \\ Title: #2}}

\def\cosupervisorrus#1#2#3{\setbox\@titleruscovisor\vbox
  {\unvbox\@titleruscovisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Со-руководитель:}{#1 \\ #2}}
  \setbox\@abstractrussupervisor\vbox{\unvbox\@abstractrussupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Со-руководитель: \\ Имя: #1 \\ Ученое звание, степень: #3 \\ Должность: #2}}

% department chairman, not thesis committee chairman
\def\chairman#1#2{\gdef\@chairmanname{#1}\gdef\@chairmantitle{#2}}

%% `upcase' documentclass option: \choosecase is defined either as a dummy or
%% a macro to change the (expanded) argument to uppercase.
\usepackage{graphicx}
\def\engmaketitle{\begin{titlepage}
\centering{\includegraphics[scale=0.15]{images/sklogo}}
\par
MASTER\/'S THESIS\\
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@title} \par}
\par
\choosecase{Master\/'s Educational Program:} \choosecase{\@department}
\par
%\skip 5\baselineskip
\vfill
\signature{Student}{\@author \\ \@department \\ \@thesisdate}
\par
\vfill
\unvbox\@titlesupervisor
\par
\vfill
\unvbox\@titlecovisor
%\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\small{Moscow \@degreeyear \\ \@copyrightnotice}
\end{titlepage}}

\def\rusmaketitle{\begin{titlepage}
\centering{\includegraphics[scale=0.15]{images/sklogo}}
\par
МАГИСТЕРСКАЯ ДИССЕРТАЦИЯ\\
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@titlerus} \par}
\par
\choosecase{Магистерская образовательная программа:} \choosecase{\@departmentrus}
\par
%\skip 5\baselineskip
\vfill
\signature{Студент}{\@authorrus \\ \@departmentrus \\ \@thesisdaterus}
\par
\vfill
\unvbox\@titlerussupervisor
\par
\vfill
\unvbox\@titleruscovisor
%\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
\vfill
\small{Москва \@degreeyear \\ \@copyrightnoticerus}
\end{titlepage}}


% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\abstractpage{\cleardoublepage
\begin{center}{\large{\bf \@title} \\
\@author \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Submitted to the Skolkovo Institute of Science and Technology \\
on \@thesisdate
\end{center}
\par
\begin{abstract}}


\def\endabstractpage{\end{abstract}\noindent
 \unvcopy\@abstractsupervisor \newpage}


\def\abstractpagerus{\cleardoublepage
\begin{center}{\large{\bf \@titlerus} \\
\@authorrus \\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
Представлено в Сколковский институт науки и технологий \\
\@thesisdaterus
\end{center}
\par
\begin{abstractrus}}


\def\endabstractpagerus{\end{abstractrus}\noindent
 \unvcopy\@abstractrussupervisor \newpage}


%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\def\titlepage{\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}

\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\signature#1#2{\par\hfill#1\hrulefill\null\\*
  {\raggedleft #2\par}}

\def\abstract{\subsection*{\centering Abstract}\small\def\baselinestretch{1}\@normalsize}
\def\endabstract{\par}

\def\abstractrus{\subsection*{\centering Реферат}\small\def\baselinestretch{1}\@normalsize}
\def\endabstractrus{\par}

\usepackage{kantlipsum}

%%%% A.LARIONOV's code
\usepackage{color, colortbl}
\widowpenalty100000
\clubpenalty100000
\usepackage{changepage}
\usepackage{bm}
\usepackage{tabularx}
\usepackage{algorithm}
\usepackage{multirow}
\usepackage{multicol}
\usepackage{makecell}
\usepackage{booktabs}
%\usepackage{algpseudocode}
\usepackage{setspace} % override spacing in some block
\usepackage{caption}
\usepackage{subcaption}
\usepackage[dvipsnames,table]{xcolor}
\newcommand{\cfbox}[2]{%
	\colorlet{currentcolor}{.}%
	{\color{#1}%
		\fbox{\color{currentcolor}#2}}%
}

\newcommand{\bmr}[1]{\bm{\mathrm{#1}}}

\newenvironment{changemargin}[2]{%
\begin{list}{}{%
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{#1}%
\setlength{\rightmargin}{#2}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{\parskip}%
}%
\item[]}{\end{list}}

%\renewcommand{\cite}[1]{\hypersetup{citecolor=red}\cite{#1}}

\usepackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=10mm}
\setlist[enumerate]{noitemsep, topsep=0pt, leftmargin=10mm}

\usepackage{listings} % программный код
\usepackage{amsmath}  % for \hookrightarrow
\usepackage{amsfonts}

%\makeatletter
\DeclareRobustCommand{\getlstname}{%
	\begingroup
	% \lstname seems to change hyphens into \textendash
	\def\textendash{-}%
	\filename@parse{\lstname}%
	\filename@base.\filename@ext%
	\endgroup
}

\newcommand*{\keywordstyle}{\color{NavyBlue}\textbf}

\lstdefinelanguage{GLSL}{
	%alsolanguage=C,
	morekeywords=[1]{vec2,vec3,vec4,precision,highp,uniform,mat2,mat3,mat4,uvec2,uvec3,uvec4,ivec2,ivec3,ivec4,layout,location,mediump,sampler2DArray,out,in,uint}, 
	alsoletter={\#},
	morekeywords=[2]{,\#if,\#version,\#define,\#error,\#ifdef,\#ifndef,\#else,\#endif,}
	keywordstyle = [1]\keywordstyle,
	keywordstyle = [2]\color{magenta}\textbf,
	sensitive = true,
	morecomment = [l]{//},
	morecomment = [s]{/*}{*/},
	morecomment = [s]{/**}{*/},
	commentstyle = \color[rgb]{0.0,0.4,0.0}\footnotesize,
	morestring = [b]",
	morestring = [b]',
}

\lstdefinestyle{myCode}{
	columns=fullflexible,
	caption=\getlstname,
	%basicstyle=\linespread{0.7}\footnotesize\selectfont\ttfamily,
	basicstyle=\footnotesize\ttfamily,
	lineskip=-0.8ex,
	frame=single,
	resetmargins=true,
	commentstyle=\color[rgb]{0.0,0.4,0.0}\footnotesize,
	breaklines=true,
	stepnumber=5,
	numberstyle=\tiny\color{black},
	numbers=left,
	keywordstyle=\keywordstyle,
	keepspaces=true, 
	extendedchars=true,
	breakautoindent=true,
	prebreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow}},
	breakindent=100pt,
	breakatwhitespace=true,
	xleftmargin=1em,
	%xrightmargin=1em,
	rulecolor=\color{black!30},
	tabsize=2,
	firstnumber=1,
	columns=[l]{fullflexible},
}

\usepackage{xargs}
\usepackage{xparse}
\usepackage{xifthen}% provides \isempty test
\usepackage{setspace}
\usepackage[bottom]{footmisc}

% \myfilelisting[<\lstset arguments, e.g. language=XML>]{<fp>}[<\label value>]
\NewDocumentCommand{\myfilelisting}{D[]{} m d[] d<>}{%
	\lstinputlisting[
	#1,
	style=myCode,
	caption=\getlstname\IfValueT{#3}{\label{#3}}
	\IfValueT{#4}{\hspace{\textwidth}\centering\setstretch{1.0}Comment: #4},
	%title=\getlstname\IfValueT{#3}{\label{#3}},
	]{#2}
}

\makeatletter
\def\blfootnote{\gdef\@thefnmark{}\@footnotetext}
\makeatother

\usepackage{tabularray}
\usepackage{svg}
\usepackage{pdfpages}

%\usepackage{pdfpages} % insert pdf documents
%\usepackage{titlepages}

%% override footnotes
%\let\oldfootnote\footnote 
%\renewcommand\oldfootnote[2][]{\relax}

% show unused bibliorgraphy
%\usepackage{refcheck}

% allows to forbid images on another page from reference
\usepackage{float} 

% special column type in a table
% С - centering with given width
% Q - with width coefficient relative to \textwidth
% Z - centering with width coefficient relative to \textwidth
\usepackage{array}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}} 
\newcolumntype{Q}[1]{p{#1\textwidth}}
\newcolumntype{Z}[1]{C{#1\textwidth}}

% \appendixexperiment[counter]{folder_root}{filename}{description}<label>
\NewDocumentCommand{\appendixexperiment}{d[] m m m d<>}{
	\clearpage
	\newpage
	\renewcommand{\arraystretch}{0.25}
	\linespread{0.25}\selectfont\centering
	%\noindent\IfValueT{#1}{\arabic{#1}\stepcounter{#1}. }{#4} % description
	\begin{figure}[!h]
		\centering
		\caption{#4} % description}
		\IfValueT{#5}{\label{#5}}
		\begin{minipage}[b]{.72\textwidth}
		\IfFileExists{#2/legend/#3}{\includegraphics[height=2cm,width=\textwidth,keepaspectratio]{#2/legend/#3}}{}
		\IfFileExists{#2/train/#3}{\includegraphics[height=10cm,width=\textwidth,keepaspectratio]{#2/train/#3}}{}
		\end{minipage}
		\hfill
		\IfFileExists{#2/plot_train/#3}{\includegraphics[height=12cm,width=0.25\textwidth,keepaspectratio]{#2/plot_train/#3}}{}
		\\
		\IfFileExists{#2/test/#3}{\includegraphics[height=12cm,width=0.72\textwidth,keepaspectratio]{#2/test/#3}}{}
		\hfill
		\IfFileExists{#2/plot_val/#3}{\includegraphics[height=12cm,width=0.25\textwidth,keepaspectratio]{#2/plot_val/#3}}{}
	\end{figure}
%		}}
%		\makebox[\textwidth]{\makebox[1.1\textwidth]{
%				\begin{minipage}[b]{.59\textwidth}
	%					\centering%
	%					\setlength\abovedisplayskip{0pt}%
	%					\centerline{\includegraphics[width=\textwidth]{#2/train/#3}}%
	%					\caption{Fit to ground truth}
	%					\setlength\belowdisplayskip{0pt}%
	%				\end{minipage}
%				\\
%				\hfill
%				\begin{minipage}[b]{.50\textwidth}
	%					\centering%
	%					\setlength\abovedisplayskip{0pt}%
	%					\centerline{\includegraphics[width=\textwidth]{#2/test/#3}}%
	%					\caption{Test images}
	%					\setlength\belowdisplayskip{0pt}%
	%				\end{minipage}
%		}}
%		\centering%
%		%\hspace{.1\textwidth}%
%		\setlength\abovedisplayskip{0pt}%
%		\centerline{\includegraphics[width=0.7\linewidth]{#2/plot_train/#3}}%
%		\hspace{.1\textwidth}
%		\centerline{\includegraphics[width=0.7\linewidth]{#2/plot_val/#3}}%
%		\setlength\belowdisplayskip{0pt}%
%\caption{Training losses and validation metrics}
}
 	