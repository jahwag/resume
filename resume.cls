% resume.cls

% \documentstyle{resume}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved.  This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{resume}[2010/07/10 v0.9 Resume class]

\LoadClass[11pt,letterpaper]{article}

\RequirePackage[parfill]{parskip}       % Do not indent paragraphs
\RequirePackage{ifthen}
\RequirePackage{lineno}                % Line numbers for IDE-style look

% Note: .aux files are needed for lastpage package to work correctly

\RequirePackage[left=0.75in,top=0.4in,right=0.75in,bottom=2cm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IDE-STYLE LINE NUMBERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xcolor}

% Configure line numbers to look like an IDE
\renewcommand\linenumberfont{\normalfont\scriptsize\ttfamily\color{gray}}
\setlength\linenumbersep{10pt}
\renewcommand\thelinenumber{\arabic{linenumber}}

% Enable line numbers
% \linenumbers  % Disabled - line numbers removed for cleaner appearance

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BETTER FONTS
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{textcomp}
\RequirePackage[sfdefault]{inter}  % Modern Inter font

\RequirePackage{needspace}
\RequirePackage{tikz}
\usetikzlibrary{calc}

% Counter for client subsections
\newcounter{clientsubsec}
% Counter for client groups
\newcounter{clientgroup}
% Flag to track if we're in a client group
\newif\ifinclientgroup
\inclientgroupfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADINGS: Commands for printing name and address (modern two-column layout)

\def \name#1{\def\@name{#1}}        % \name command can be used to set name
\def \@name {}                      % Set \@name to empty by default

\def \subtitle#1{\def\@subtitle{#1}}  % Role/company subtitle
\let \@subtitle \relax

% Contact info for right column
\let \@addressone \relax  % Physical address
\let \@addresstwo \relax  % Contact details

% \address command can be used to set first and second address (optional)
\def \address #1{
  \@ifundefined{@addresstwo}{
    \def \@addresstwo {#1}
  }{
    \def \@addressone {#1}
  }
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
  \def \\ {\quad}
  #1
  \endgroup
}

% \printname is used to print the name as a page header (centered layout)
\def \printname {
  \begingroup
  \centering
  {\textbf{\MakeUppercase{\namesize\@name}}}%
  \@ifundefined{@subtitle}{}{\\[2pt]{\large\@subtitle}}%
  \par\vspace{4pt}
  \@ifundefined{@addresstwo}{}{{\footnotesize\def\\{\quad$\cdot$\quad}\@addresstwo}}
  \par
  \endgroup
  \vspace{0.5em}
  \hrule height 0.5pt
  \nameskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADERS AND FOOTERS

\newif\ifshowfooter
\showfootertrue% Show footer

\ifshowfooter
  \usepackage{graphicx}
  \usepackage{fancyhdr}
  \usepackage{lastpage}

  \pagestyle{fancy}
  \fancyhf{} % clear all header and footer fields
  \renewcommand{\footrulewidth}{0.4pt} % Adds a line above the footer

  % Setting the footer
  \cfoot{\footnotesize \href{https://www.bytelope.com}{Bytelope AB}}
  \rfoot{\footnotesize Page \thepage\ of \pageref{LastPage}}

  \renewcommand{\headrulewidth}{0pt} % remove the header line
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOCUMENT: Create the head of the document

\AtBeginDocument{                     % Begin document
  \printname                        % Print name and contact in two-column layout
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTIONS: Create section headings

% Used to create large resume section
\newenvironment{rSection}[1]{
  \sectionskip
  \textbf{\MakeUppercase{#1}}
  \sectionlineskip
  \hrule
  \begin{list}{}{
    \setlength{\leftmargin}{1.5em}
  }
    \item[]
    }{
  \end{list}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SEMANTIC POSITION ENVIRONMENTS
% Domain-specific commands for consulting business structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Colors for visual hierarchy
\definecolor{accentcolor}{HTML}{2c3e50}  % Dark blue accent
\definecolor{employerline}{gray}{0.3}
\definecolor{assignmentborder}{gray}{0.75}
\definecolor{assignmenttag}{gray}{0.5}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rEmployer - For any employer (direct or consulting company)
% Use for: Bytelope AB, Combitech AB, Saab AB, Banky AB, etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{rEmployer}[4]{
  \vspace{0.8em}
  \noindent\textbf{\MakeUppercase{#1}}%
  \hfill{#2}%
  \ifthenelse{\equal{#3}{}}{}{%
    \\
    \emph{#3}\hfill\emph{#4}%
  }%
  \smallskip
  \begin{list}{-}{\leftmargin=1.5em\itemsep=-0.3em}
}{
  \end{list}
  \vspace{0.3em}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rAssignment - For client assignments under a consultancy
% Use for: Client work via Bytelope, Combitech, etc.
% Subtle left border style (like a blockquote) to show hierarchy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{rAssignment}[4]{
  \vspace{0.1em}
  \noindent\hspace{0.8em}%
  \begin{tikzpicture}
    \node[
      inner sep=8pt,
      text width=\dimexpr\linewidth-4.2em\relax,
      anchor=north west
    ] (box) \bgroup
      \begin{minipage}[t]{\dimexpr\linewidth-4.2em-16pt\relax}
        % Client name and dates
        \textbf{#1}\hfill{#2}%
        \ifthenelse{\equal{#3}{}}{}{%
          \\
          \emph{#3}\hfill\emph{#4}%
        }%
        \smallskip
        \begin{list}{-}{\leftmargin=1.2em\itemsep=0.15em\topsep=0.2em}
}{
        \end{list}
      \end{minipage}
    \egroup;
    % Left border with vertical "CLIENT" text
    \draw[assignmentborder, line width=1pt] (box.north west) -- (box.south west);
    \node[rotate=90, anchor=south, font=\scriptsize\color{assignmenttag}]
      at ($(box.north west)!0.5!(box.south west) - (0.4em,0)$) {CLIENT};
    % Dashed bottom separator for consecutive clients
    \draw[assignmentborder, line width=0.5pt, dashed]
      ($(box.south west) + (0,-0.3em)$) -- ($(box.south east) + (0,-0.3em)$);
  \end{tikzpicture}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BACKWARD COMPATIBILITY - Keep old commands working
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rSubsection maps to rEmployer
\newenvironment{rSubsection}[4]{%
  \begin{rEmployer}{#1}{#2}{#3}{#4}%
}{%
  \end{rEmployer}%
}

% rClientSubsection maps to rAssignment
\newenvironment{rClientSubsection}[4]{%
  \begin{rAssignment}{#1}{#2}{#3}{#4}%
}{%
  \end{rAssignment}%
}

% Legacy group commands (no longer needed but kept for compatibility)
\newcommand{\startClientGroup}{}
\newcommand{\finishClientGroup}{}

\def\namesize{\huge}
\def\nameskip{\medskip}
\def\addressskip{\smallskip}
\def\sectionskip{\bigskip}
\def\sectionlineskip{\medskip}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bullets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{enumitem}

\newcommand{\techItem}{\item[$*$]}
\newcommand{\bItem}{\item[-]}

% Fine print for tech/infrastructure/methodology lines
\definecolor{techgray}{gray}{0.35}
\newcommand{\techLine}[2]{\item[-] {\small\color{techgray}\textbf{#1}: #2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiple Columns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlist[itemize]{noitemsep, topsep=0pt, partopsep=0pt, parsep=0pt, left=0pt, labelsep=0.5em, labelwidth=0.5em, leftmargin=1.5em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ensure space before subsection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ensurespace}[1]{\needspace{#1\baselineskip}}