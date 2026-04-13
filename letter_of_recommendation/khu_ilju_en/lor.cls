%
% NJUletter.cls
% This class based on "brownletter.cls" Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
% New version modifications by MincooLee(mincoolee@gmail.com) based on NJU template, 18 December 2021

% Notes:
%
% 1. This class can be used for creating letters with NJU logo at the
%    header and  department address at the footer 
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If NJU logo is to be included in the head, then the file
%    NJUlogo.eps must be provided. Otherwise, the logo is omitted.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HITletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}
%\RequirePackage{fontspec}
\DeclareGraphicsExtensions {.png} %{.pdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newcommand{\@logofile}{}
\newcommand{\setlogo}[1]{%
    \renewcommand{\@logofile}{#1}%
    \HIT@makehead
}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.5in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{0.5in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newcommand{\HIT@makehead}{\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}           

% HELP FOR SETTING UP PARBOXES
% \parbox[position][height][inner-pos]{width}{text}
% The \parbox has two mandatory arguments:
%     width - specifies the width of the parbox, and
%     text - the text that goes inside the parbox. 
% LaTeX will position a parbox so its center lines up with the center of the text line. The optional position argument allows you to line up either the top or bottom line in the parbox (default is top).
% If the height argument is not given, the box will have the natural height of the text.
% The inner-pos argument controls the placement of the text inside the box. If it is not specified, position is used.
%     t -- text is placed at the top of the box.
%     c -- text is centred in the box.
%     b -- text is placed at the bottom of the box.
%LOGO
%
    \parbox{3.4in}
    {\center
        \ifthenelse{\equal{\@logofile}{}}
           {\parbox[t][1.0in][t]{2.0in}{\hfill}}
           {\IfFileExists{\@logofile}
               {\epsfig{file=\@logofile, height=1.1in}}
               {\parbox[t][1.0in][t]{2.0in}{\hfill}
                \ClassWarning{HITletter}{Logo file `\@logofile' could not be found.}}}
    } &
%DEPARTMENT OR SCHOOL
%  This just sets the size of the box to the right of the logo, and the size of the vertical line.  The vertical line is set by the size of the first numerical argument of the \parbox command.
%
% In the future, the "From" address might be better set using "tikz".
    \parbox[c][1.9in][c]{3in}{{~}\\
}\\
    \end{tabular*}
}}

\HIT@makehead

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\hfil-\thepage-\hfil}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\hfil-\thepage-\hfil}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\hfil-\thepage-\hfil}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\hfil-\thepage-\hfil}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{3\parskip}%
    \stopbreaks
    \noindent
    \parbox{0.45\textwidth}{\raggedright
    \ignorespaces #1\\[1.5cm]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}
