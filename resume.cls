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

\nofiles                            % .aux files are not needed for resumes

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
\linenumbers

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BETTER FONTS
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{textcomp}
\RequirePackage{lmodern}

\RequirePackage{needspace}
\renewcommand*\familydefault{\sfdefault}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADINGS: Commands for printing name and address

\def \name#1{\def\@name{#1}}        % \name command can be used to set name
\def \@name {}                      % Set \@name to empty by default

\def \addressSep {$\diamond$}         % Set default address seperator

% One or two address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax

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
  \def \\ {\addressSep\ }
  \centerline{#1}
  \endgroup
  \par
  \addressskip
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
  \centerline{\textbf{\MakeUppercase{\namesize\@name}}}
  \endgroup
  \par
  \nameskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HEADERS AND FOOTERS

\newif\ifshowfooter
\showfootertrue% Show footer

\ifshowfooter
  \usepackage{graphicx}
  \usepackage{fancyhdr}

  \pagestyle{fancy}
  \fancyhf{} % clear all header and footer fields
  \renewcommand{\footrulewidth}{0.4pt} % Adds a line above the footer

  % Setting the footer
  \cfoot{\footnotesize Bytelope AB is dedicated to providing expert software development consulting, tailored to meet unique client needs.}
  \rfoot{\thepage}

  \renewcommand{\headrulewidth}{0pt} % remove the header line
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOCUMENT: Create the head of the document

\AtBeginDocument{                     % Begin document
  \printname                        % Print the name specified with \name
  \@ifundefined{@addressone}{}{     % Print the first address if specified
    \printaddress{\@addressone}}
  \@ifundefined{@addresstwo}{}{     % Print the second address if specified
    \printaddress{\@addresstwo}}
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

% Used to format job listing
\newenvironment{rSubsection}[4]{
%%%%%%%%%%%%%%%%%%%%%% Default Layout: %%%%%%%%%%%%%%%%%%%%%%%%
%%    Employer (bold)                     Dates (regular)    %%
%%    Title (emphasis)                Location (emphasis)    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  \textbf{#1}                 \hfill                  {    #2}% Stop a space
  \ifthenelse{\equal{#3}{}}{}{
    \\
    \emph{#3}                \hfill                  \emph{#4}% Stop a space
  }\smallskip
% \cdot used for bullets, indented to avoid overlap with line numbers
  \begin{list}{$\cdot$}{\leftmargin=1.5em}
    \itemsep -0.5em \vspace{-0.5em}
    }{
  \end{list}
  \hspace{2em}
}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiple Columns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlist[itemize]{noitemsep, topsep=0pt, partopsep=0pt, parsep=0pt, left=0pt, labelsep=0.5em, labelwidth=0.5em, leftmargin=1.5em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ensure space before subsection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ensurespace}[1]{\needspace{#1\baselineskip}}