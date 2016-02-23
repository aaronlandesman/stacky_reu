%% Format latex public pour les AIF
\NeedsTeXFormat{LaTeX2e}% LaTeX 2.09 can't be used (nor non-LaTeX)
[1995/06/01]% LaTeX date must be June 1995 or later
\ProvidesClass{cedram-aif}[2010/11/01 v0.3]
%% 2010/11/01 : introduit les options 
%%%  NoEqCountersInSection compteurs d'équations courent sur tout l'article
%%%  NoFloatCountersInSection compteurs table, figure courent sur tout l'article
%%%  OneCounterForEverything théorèmes, équations et soussections partagent le même compteur
%%%  SubsectAsParagraph sous-sections compatibles amsart (=\paragraph)
%%% AmsartStyle NoEqCountersInSection+NoFloatCountersInSection+OneCounterForEverything+SubsectAsParagraph
%% Option langue
\newif\if@francais\@francaisfalse
\DeclareOption{francais}{\@francaistrue}
\DeclareOption{anglais}{\@francaisfalse}
\newif\ifcdr@eqcountersinsections\cdr@eqcountersinsectionstrue
\DeclareOption{NoEqCountersInSection}{\global\let\ifcdr@eqcountersinsections\iffalse}
\newif\ifcdr@flcountersinsections\cdr@flcountersinsectionstrue
\DeclareOption{NoFloatCountersInSection}{\global\let\ifcdr@flcountersinsections\iffalse}
\newif\ifcdr@onecountereverything\cdr@onecountereverythingfalse
\DeclareOption{OneCounterForEverything}{\global\let\ifcdr@onecountereverything\iftrue}
\newif\ifcdr@subsectaspar\cdr@subsectasparfalse
\DeclareOption{SubsectAsParagraph}{\global\let\ifcdr@subsectaspar\iftrue}
\DeclareOption{AmsartStyle}{\global\let\ifcdr@flcountersinsections\iffalse\global\let\ifcdr@onecountereverything\iftrue\global\let\ifcdr@subsectaspar\iftrue}
\ProcessOptions\relax
%% On charge amsart
\LoadClass[centertags,portrait,10pt,twoside,%
 onecolumn,psamsfonts]{amsart}[2004/08/06 v2.20]
%% Modifs amsart pour compatibilité cedram
\AtBeginDocument{%
  \@for\@tempa:=-1,0,1,2,3,4\do{%
    \@ifundefined{r@tocindent\@tempa}{%
      \@xp\gdef\csname r@tocindent\@tempa\endcsname{0pt}}{}%
  }%
}
\def\@writetocindents{%
  \begingroup
  \@for\@tempa:=-1,0,1,2,3\do{%
    \immediate\write\@auxout{%
      \string\newlabel{tocindent\@tempa}{%
        \csname r@tocindent\@tempa\endcsname}}%
  }%
  \endgroup}
%% Structure de la commande \author
\renewcommand{\author}[2][]{%
  \ifx\@empty\authors
    \gdef\authors{#2}%
    \g@addto@macro\addresses{\author{#2}}%
  \else
    \g@addto@macro\authors{\and#2}%
    \g@addto@macro\addresses{\author{#2}}%
  \fi
  \@ifnotempty{#1}{%
    \ifx\@empty\shortauthors
      \gdef\shortauthors{#1}%
    \else
      \g@addto@macro\shortauthors{\and#1}%
    \fi
  }%
}
\edef\author{\@nx\@dblarg
  \@xp\@nx\csname\string\author\endcsname}
%% Théorèmes prédéfinis (piqué à smfthm)
\newif\ifcdr@thmsin\cdr@thmsintrue
\newif\ifcdr@thmsas\cdr@thmsasfalse
\newif\ifcdr@thm@necounter\cdr@thm@necounterfalse
\def\OneNumberAllTheorems{\cdr@thm@necountertrue}
\def\NumberTheoremsIn#1{\@ifempty{#1}%
     {\cdr@thmsinfalse}%
     {\@ifundefined{c@#1}{\@nocounterr{#1}}%
       {\cdr@thmsintrue\cdr@thmsasfalse\def\@NumberTheorems{#1}}}}
  \NumberTheoremsIn{section}%
\def\NumberTheoremsAs#1{\@ifempty{#1}%
     {\cdr@thmsasfalse}%
     {\@ifundefined{c@#1}{\@nocounterr{#1}}%
       {\cdr@thmsinfalse\cdr@thmsastrue\cdr@thm@necountertrue\def\@NumberTheorems{#1}}}}
  \NumberTheoremsAs{}%
\def\SwapTheoremNumbers{\def\thm@swap{S}}
\def\NoSwapTheoremNumbers{\def\thm@swap{N}}
  \NoSwapTheoremNumbers
\def\cdr@thmdefs{%
  \theoremstyle{plain}
  \ifcdr@thm@necounter
  \ifcdr@thmsin
  \newcounter{cdrthm}[\@NumberTheorems]%
  \xdef\thecdrthm
         {\expandafter\noexpand\csname the\@NumberTheorems\endcsname
           \@thmcountersep\@thmcounter{cdrthm}}%
    \gdef\cdr@thm{cdrthm}%     
    \else
    \ifcdr@thmsas
    \xdef\cdr@thm{\@NumberTheorems}%
    \else
    \newcounter{cdrthm}%
    \gdef\cdr@thm{cdrthm}%     
    \fi\fi\fi
\ifcdr@thm@necounter
  \newtheorem{theo}[\cdr@thm]{\theoname}%
  \newtheorem{prop}[\cdr@thm]{\propname}%
  \newtheorem{conj}[\cdr@thm]{\conjname}%
  \newtheorem{coro}[\cdr@thm]{\coroname}%
  \newtheorem{lemm}[\cdr@thm]{\lemmname}%
  \theoremstyle{definition}%
  \newtheorem{defi}[\cdr@thm]{\definame}%
  \theoremstyle{remark}%
  \newtheorem{nota}[\cdr@thm]{\notaname}%
  \newtheorem{notas}[\cdr@thm]{\notasname}%
  \newtheorem{rema}[\cdr@thm]{\remaname}%
  \newtheorem{remas}[\cdr@thm]{\remasname}%
  \newtheorem{exem}[\cdr@thm]{\exemname}%
  \newtheorem{exems}[\cdr@thm]{\exemsname}%
\else
\ifcdr@thmsin
  \newtheorem{theo}{\theoname}[\@NumberTheorems]%
  \newtheorem{prop}{\propname}[\@NumberTheorems]%
  \newtheorem{conj}{\conjname}[\@NumberTheorems]%
  \newtheorem{coro}{\coroname}[\@NumberTheorems]%
  \newtheorem{lemm}{\lemmname}[\@NumberTheorems]%
  \theoremstyle{definition}%
  \newtheorem{defi}{\definame}[\@NumberTheorems]%
  \theoremstyle{remark}%
  \newtheorem{nota}{\notaname}[\@NumberTheorems]%
  \newtheorem{notas}{\notasname}[\@NumberTheorems]%
  \newtheorem{rema}{\remaname}[\@NumberTheorems]%
  \newtheorem{remas}{\remasname}[\@NumberTheorems]%
  \newtheorem{exem}{\exemname}[\@NumberTheorems]%
  \newtheorem{exems}{\exemsname}[\@NumberTheorems]%
\else
  \newtheorem{theo}{\theoname}%
  \newtheorem{prop}{\propname}%
  \newtheorem{conj}{\conjname}%
  \newtheorem{coro}{\coroname}%
  \newtheorem{lemm}{\lemmname}%
  \theoremstyle{definition}%
  \newtheorem{defi}{\definame}%
  \theoremstyle{remark}%
  \newtheorem{nota}{\notaname}%
  \newtheorem{notas}{\notasname}%
  \newtheorem{rema}{\remaname}%
  \newtheorem{remas}{\remasname}%
  \newtheorem{exem}{\exemname}%
  \newtheorem{exems}{\exemsname}%
\fi\fi
  \theoremstyle{definition}%
  \newtheorem*{defi*}{\definame}%
  \theoremstyle{remark}%
  \newtheorem*{nota*}{\notaname}%
  \newtheorem*{notas*}{\notasname}%
  \newtheorem*{rema*}{\remaname}%
  \newtheorem*{remas*}{\remasname}%
  \newtheorem*{exem*}{\exemname}%
  \newtheorem*{exems*}{\exemsname}%
  \theoremstyle{plain}%
  \newtheorem*{theo*}{\theoname}%
  \newtheorem*{prop*}{\propname}%
  \newtheorem*{conj*}{\conjname}%
  \newtheorem*{coro*}{\coroname}%
  \newtheorem*{lemm*}{\lemmname}%
}
\def\cdr@enoncedef{%
 \newenvironment{enonce}[2][plain]%
    {\let\cdrenonce\relax \theoremstyle{##1}%
      \ifcdr@thm@necounter
      \newtheorem{cdrenonce}[\cdr@thm]{##2}%
      \else
      \ifcdr@thmsin
      \newtheorem{cdrenonce}{##2}[\@NumberTheorems]%
      \else
      \newtheorem{cdrenonce}{##2}%
      \fi\fi
     \begin{cdrenonce}}%
    {\end{cdrenonce}}%
 \newenvironment{enonce*}[2][plain]%
    {\let\cdrenonce\relax \theoremstyle{##1}%
     \newtheorem*{cdrenonce}{##2}%
     \begin{cdrenonce}}%
    {\end{cdrenonce}}%
}
\AtBeginDocument{%
\cdr@thmdefs
\cdr@enoncedef}
\def\propname{Proposition}%
\def\conjname{Conjecture}%
\def\notaname{Notation}%
\def\notasname{Notations}%
\if@francais
\def\theoname{Th\'eor\`eme}%
\def\coroname{Corollaire}%
\def\lemmname{Lemme}%
\def\definame{D\'efinition}%
\def\remaname{Remarque}%
\def\remasname{Remarques}%
\def\exemname{Exemple}%
\def\exemsname{Exemples}%
\else
\def\theoname{Theorem}%
\def\coroname{Corollary}%
\def\lemmname{Lemma}%
\def\definame{Definition}%
\def\remaname{Remark}%
\def\remasname{Remarks}%
\def\exemname{Example}%
\def\exemsname{Examples}%
\fi
\def\equalenv#1#2{%
\newenvironment{#1}{\begin{#2}}{\end{#2}}}
\equalenv{theorem}{theo}
\equalenv{thm}{theo}
\equalenv{thm*}{theo*}
\equalenv{lemma}{lemm}
%% Métadonnées
% titre du journal 
\newcommand{\setpublname}[2][Titre abr\'eg\'e absent]{%
\gdef\shortpublname{#1}\gdef\publname{#2}}
\setpublname[Ann. Inst. Fourier, Grenoble]{Annales de l'institut
  Fourier}%
\def\currentjournaltitle{Annales de l'institut Fourier}%
% entité éditrice du journal 
\edef\currentjournalpublisher{Association des \currentjournaltitle}
% titre abrégé du journal
\def\currentjournalshorttitle{Ann. inst. Fourier}%
% acronyme
\def\cdr@journalacro{AIF}
% ISSN
\def\@issn{0373-0956}
%
%\CDRjournalURL{aif}
%
%% Métadonnées article
\let\@altabstract\@empty
\let\@alttitle\@empty
\newcommand*{\alttitle}[1]{\gdef\@alttitle{#1}}%
\newcommand*{\altkeywords}[1]{\gdef\@altkeywords{#1}}%
\newbox\altabstractbox
\newenvironment{altabstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Altabstract should precede
      \protect\maketitle\space in AMS document classes; reported}%
  \fi
  \global\setbox\altabstractbox=\vtop \bgroup
    \normalfont\Small
    \list{}{\labelwidth\z@
      \leftmargin3pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    \item[\hskip\labelsep\scshape\altabstractname.]%
}{%
  \endlist\egroup
  \ifx\@setaltabstract\relax \@setaltabstracta \fi
}
\def\@setaltabstract{\@setaltabstracta \global\let\@setaltabstract\relax}
\def\@setaltabstracta{%
\ifx\@empty\@alttitle\else
\begin{center}%
\large\slshape  \@alttitle  
\end{center}%
\fi
  \ifvoid\altabstractbox
  \else
%     \skip@20\p@ \advance\skip@-\lastskip
%     \advance\skip@-\baselineskip \vskip\skip@
    \box\altabstractbox
    \prevdepth\z@ % because \altabstractbox is a vtop
  \fi
}
\def\@setabstract{\@setabstracta \global\let\@setabstract\relax
\@setaltabstract}
%% géométries
\paperwidth=158mm
\paperheight=240mm
\textwidth=27pc
\textheight=43pc
\ifx\undefined\pdfpagewidth\else
\pdfpagewidth\paperwidth
\pdfpageheight\paperheight
\fi
\topmargin-.94cm
\oddsidemargin-.34cm
\evensidemargin-.34cm
\headheight12pt
%\logoheight6pt
\headsep18pt
\topskip13pt
%% Typo
\footskip36pt
\def\footnoterule{\kern-6\p@
  \hrule width 1truein \kern 5.6\p@}
\skip\footins=12pt plus 4pt minus 4pt
\parskip=0pt
\parindent=10pt
\normalparindent=10pt
\renewcommand\baselinestretch{}
\frenchspacing
\smallskipamount=3pt plus 1pt minus .6pt
\medskipamount=5pt plus 1pt minus .6pt
\bigskipamount=13pt plus 2pt minus 1pt
%% 10 pt et dimensions TeX...
\def\@mainsize{10}\def\@ptsize{0}%
  \def\@typesizes{%
    \or{5}{6}\or{6}{7}\or{7}{8}\or{8}{9}\or{9}{11}%
    \or{10}{13}% normalsize
    \or{\@xipt}{13}\or{\@xiipt}{14}\or{\@xivpt}{17}%
    \or{\@xviipt}{20}\or{\@xxpt}{24}}%
  \normalsize \linespacing=\baselineskip
\let\ept\Small
%%%% Versions jolies -- macros spécifiques
\RequirePackage{amssymb}
\let\le\leqslant
\let\ge\geqslant 
\let\leq\leqslant   
\let\geq\geqslant
%% Truc discutable...
\DeclareRobustCommand\em
        {\@nomath\em \ifdim \fontdimen\@ne\font >\z@
                       \upshape \else \slshape \fi}
%%
\def\todo{À faire !}
\def\pointir{\discretionary{.}{}{.\kern.3em---\kern.4em\ignorespaces}}
\def\thsp{\if@francais\,\fi}
% Pas de mise en romain des numérotations intempestives !
\def\@upn#1{#1}
\let\cdr@up\relax
%% compatibilité enumerate.sty
\AtBeginDocument{\@ifpackageloaded{enumerate}{%
\def\@@enum@[#1]{%
  \@enLab{}\let\@enThe\@enQmark
  \@enloop#1\@enum@
  \ifx\@enThe\@enQmark\@warning{The counter will not be printed.%
   ^^J\space\@spaces\@spaces\@spaces The label is: \the\@enLab}\fi
  \expandafter\edef\csname label\@enumctr\endcsname{\the\@enLab}%
  \expandafter\let\csname the\@enumctr\endcsname\@enThe
  \csname c@\@enumctr\endcsname7
  \expandafter\settowidth
            \csname leftmargin\romannumeral\@enumdepth\endcsname
            {\the\@enLab\hspace{\labelsep}}%
  \advance\leftmargini by \normalparindent
  \@enum@}
\def\@enum@{\list{\csname label\@enumctr\endcsname}%
           {\usecounter{\@enumctr}\def\makelabel##1{\hss\llap{\upshape##1}}}}%
}{}}%
%% Macros pratiques
\def\tn#1{\text{\normalfont#1}}
\newcommand\nfrac[2]{#1/#2}
\newcommand\pfrac[2]{(#1/#2)}
%% Paramètres de mise en page
%% 1re page
\pagenumbering{arabic}%
%% Mention de copyright
\def\@setcopyright{}%
%% Style des pages courantes
\def\ps@aif{%\ps@empty
  \def\@evenhead{%
    \normalfont%
    \rlap{\thepage}\hfil
    \def\thanks{\protect\thanks@warning}%
    {\scriptsize\leftmark}{}{}\hfil}%
  \def\@oddhead{%
    \setTrue{runhead}%
    \normalfont \hfil
    \def\thanks{\protect\thanks@warning}%
    {\scriptsize\rightmark}{}{}\hfil \llap{\thepage}}%
  \def\@evenfoot{\Tiny\MakeUppercase{\currentjournaltitle}\hfill}%
  \def\@oddfoot{\Tiny
    \if@francais\MakeUppercase{ARTICLE SOUMIS : \jobname.tex}\else
    \MakeUppercase{SUBMITTED ARTICLE : \jobname.tex}\fi
    \hfill}%
%  \let\@mkboth\cdr@markboth
}%
\let\ps@plain\ps@aif
\pagestyle{aif}%
%% Style de la première page
\def\ps@firstpage{\ps@plain
  \def\@oddfoot{\global\topskip\normaltopskip}%
  \let\@evenfoot\@oddfoot
  \def\@oddhead{\@serieslogo\hss}%
  \let\@evenhead\@oddhead % in case an article starts on a left-hand page
}%
% %% Identificiation article première page
 \def\@logofont{\Small}
 % \ifcdr@special
% \def\article@logo{}%
% \else
\let\currentvolume\@empty
 \def\article@logo{%
   \set@logo{%
     {\shortpublname}\\
     \ifx\@empty\currentvolume \textbf{\if@francais Version de
       travail\else Working version\fi\ -- \today}
     \else \textbf{\currentvolume}, \currentissue\ (\currentyear) \pageinfo
     \fi
   }%
 }
% \fi
%% Présentation du titre
\def\@settitle{%
  \bgroup
  \centering
  \vglue1cm
  \fontsize{12}{15}\fontseries{b}\selectfont
  %\usefont{T1}{lmr}{b}{n}%
  \uppercasenonmath\@title
  \@title
  \vskip20pt plus 6pt minus 8pt
  \egroup
}
%% Présentation des auteurs
\def\author@andify{%
  \nxandlist {\unskip ,\penalty-2 \space\ignorespaces}%
    {\unskip {} \@@and~}%
    {\unskip {} \penalty-1  \@@and~}%
}
\let\redactor@contribs\@empty
\def\@setredactor@contribs{%
\if@francais
R\'edig\'e par
\else
Redacted by
\fi
\author@andify\redactor@contribs
\redactor@contribs
}
\let\appendixwriter@contribs\@empty
\def\@setappendixwriter@contribs{%
\if@francais
Avec un appendice par
\else
With an appendix by
\fi
\author@andify\appendixwriter@contribs
\appendixwriter@contribs
}
\def\initial#1{#1}
\def\lastname#1{#1}
\def\firstname#1{#1}
\def\middlename#1{#1}
\def\vonname#1{#1}
\def\@setauthors{%
  \begingroup
  \def\thanks{\protect\thanks@warning}%
  \trivlist
  \centering\normalfont\bfseries \@topsep30\p@\relax
  \advance\@topsep by -\baselineskip
  \item\relax
  \author@andify\authors
  \def\\{\protect\linebreak}%
  \def\lastname##1{\MakeUppercase{##1}}%
  \if@francais par\else by\fi\ 
  \authors\unskip\ifx\@empty\thankses\else
  \kern3pt(*)\fi
  \ifx\@empty\redactor@contribs
  \else \vskip6pt \@setredactor@contribs
  \fi
  \ifx\@empty\appendixwriter@contribs
  \else \vskip6pt \@setappendixwriter@contribs
  \fi
  \endtrivlist
  \vskip0.6cm
  \endgroup
}
\def\@setsubtitle{%
  \bgroup
  \centering
  \vglue-3mm
  \fontsize{12}{15}\fontseries{b}\selectfont
  %\usefont{T1}{lmr}{b}{n}%
%  \uppercasenonmath\@subtitle
  \@subtitle
  \vskip10pt plus 3pt minus 4pt
  \egroup
}
\def\@setdedicatory{%
	\vtop{\raggedleft{\footnotesize\slshape\@dedicatory\@@par}}}
%\advance\@titlebotskip-7mm
\def\cdr@preabstracthook{%
  \centerline{\vrule depth0pt height0.4pt width 1.3cm}%
}
%% Notes
\def\@makefnmark{%
  \leavevmode
	\raise.9ex\hbox{\fontsize\sf@size\z@\normalfont(\@thefnmark)\kern.15em}\ignorespaces%
}
\def\@makefntext{\noindent\@makefnmark}
%% Notes de la première page
\def\@adminfootnotes{%
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \begingroup\parindent=0pt\normalparindent=0pt
 % \ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \ifx\@empty\@translators \else\@footnotetext{\@settranslators}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks}%
  \fi
\endgroup}
\def\@settranslators{%
\def\lastname##1{\MakeUppercase{##1}}%
\andify\@translators
\if@francais
Traduit par
\else
Translated by
\fi
\@translators\@addpunct.}
\def\@setthanks{\def\thanks##1{\par##1\@addpunct.}%
  (*)\kern\fontdimen2\font\thankses}% 
\def\@setsubjclass{%
  {\slshape\subjclassname\thsp:}\space\@subjclass\@addpunct.}
\def\@setkeywords{%
  {\slshape \keywordsname\thsp:}\space \@keywords\@addpunct.}
\if@francais
 \def\keywordsname{Mots-cl\'es}
 \def\subjclassname{Classification math.}
\renewcommand{\abstractname}{R\'esum\'e}
\newcommand{\altabstractname}{Abstract}
\else
 \def\keywordsname{Keywords}
 \def\subjclassname{Math. classification}
%\newcommand{\abstractname}{Abstract}
\newcommand{\altabstractname}{R\'esum\'e}
\fi
\@xp\let\csname subjclassname@2000\endcsname \subjclassname
\@xp\let\csname subjclassname@1991\endcsname \subjclassname
%
\AtBeginDocument{\@ifpackageloaded{hyperref}{}{\def\url#1{#1}%
  \def\href#1#2{#2}}}
\def\@setaddresses{\par
  \begingroup
  \interlinepenalty\@M
  \def\lastname##1{\MakeUppercase{##1}}%
  \def\author##1{\par\allowbreak\addvspace\medskipamount\ignorespaces##1\unskip}%
  \def\noauthor##1##2{\par\allowbreak\addvspace\medskipamount\ignorespaces##2\unskip}%
  \def\address##1##2{\begingroup
    \newline\nopagebreak%\addvspace\bigskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip)\newline\nopagebreak }%
    {\ignorespaces##2\unskip}\endgroup}%
  \def\curraddr##1##2{\begingroup
    \newline\nopagebreak
    \@ifnotempty{##2}{\curraddrname{}%
      \@ifnotempty{##1}{(\ignorespaces##1\unskip)}\thsp:\\*
      ##2}\endgroup}%
  \def\email##1##2{\begingroup\nopagebreak\par\addvspace\smallskipamount
    \@ifnotempty{##2}{%\nobreak%\indent
      \@ifnotempty{##1}{\emailaddrname \space (\ignorespaces##1\unskip):\\*}%
      \href{mailto:##2}{##2}}\endgroup}%
  \def\urladdr##1##2{\begingroup\newline\nopagebreak
%    \def~{\char`\~}%
    \@ifnotempty{##2}{%\nobreak\indent\urladdrname
      \@ifnotempty{##1}{\urladdrname \space (\ignorespaces##1\unskip):\\*}%
      \url{##2}}\endgroup}%
  \addresses
  \endgroup
}
%% final
\def\printauthors{\xdef\enddoc@text{}{\@printauthors}}
\def\enddoc@text{\@printauthors}%
\def\@printauthors{\samepage
\par\normalfont\footnotesize
\nobreak\addvspace{.4cm}\leftskip4.5cm\parindent=0pt\parskip0pt\relax
%\begingroup\selectlanguage{french}\interlinepenalty\@M
%\ifx\@empty\@daterecieved\nobreak\par Manuscrit jamais reçu !\else\@setdaterecieved\fi
%\ifx\@empty\@daterevised\else\@setdaterevised\fi
%\ifx\@empty\@dateaccepted\newline\nopagebreak Manuscrit non accept\'e !\else\@setdateaccepted\fi
%\endgroup
%\vspace{.3cm}
\ifx\@empty\addresses \else\@setaddresses\fi\@@par}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% sections
% \section remplace TITRE
\renewcommand\section{\@startsection{section}{1}{\z@}%
{27pt plus 6pt minus 8pt}{14pt plus 6pt minus 8pt}%%
{\center\normalfont\large\bfseries}}
% \subsection remplace \titre
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
{27pt plus 6pt minus 8pt}{14pt plus 6pt minus 8pt}%%
{\center\normalfont\bfseries}}
% \subsubsection ne remplace rien, mais sert pour la biblio
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
{18pt plus 6pt minus 8pt}{14pt plus 6pt minus 8pt}%%
{\center\normalfont}}
% \paragraph remplace \sect 
\renewcommand\paragraph{\@startsection{paragraph}{4}{\parindent}%
{3mm}{-.33em}{\normalfont\bfseries}}
% \paragraphc ne remplace rien
\newcommand\paragraphc{\@startsection{paragraph}{4}{\parindent}%
{3mm}{1sp}{\normalfont\bfseries}}
% \subparagraph remplace \ssection ?
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
{3mm}{-.3em}{\normalfont\scshape}}
% \subparagraphc remplace \ssect ?
\newcommand{\subparagraphc}{\@startsection{subparagraph}{5}{\parindent}%
{3mm}{1sp}{\normalfont\scshape}}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname .\hspace{0.5em}\ignorespaces}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
%% Biblio
\renewcommand{\@bibtitlestyle}{%
\if@francais
  \subsubsection*{BIBLIOGRAPHIE}%
\else
  \subsubsection*{BIBLIOGRAPHY}%
\fi}
%% Th\'eorèmes
\OneNumberAllTheorems
\def\th@plain{%
  \thm@bodyfont{\normalfont\slshape}
  \thm@headfont{\normalfont\scshape}
  \thm@notefont{\normalfont}
  \thm@headpunct{\pointir}
%  \let\thmheadnl\relax
%  \let\thm@swap\@gobble
  \thm@headsep 0\p@\relax
  \let\thm@indent\indent 
  \def\thm@space@setup{%
    \thm@preskip=\smallskipamount
    \thm@postskip=\thm@preskip}
  \slshape
}
\def\th@remark{%
  \thm@bodyfont{\normalfont}
  \thm@headfont{\normalfont\slshape}
  \thm@notefont{\normalfont\slshape}
  \thm@headpunct{\pointir}
  \let\thm@indent\indent 
  \def\thm@space@setup{%
    \thm@preskip=\smallskipamount
    \thm@postskip=\thm@preskip}%
}
\let\th@definition\th@plain
% Versions coupées -- sans pointir !
 \def\th@plainc{%
   \thm@bodyfont{\normalfont\slshape}
   \thm@headfont{\normalfont\scshape}
   \thm@notefont{\normalfont}
   \thm@headpunct{.}
   \def\thmheadnl{\newline}
%   \let\thm@swap\@gobble
   \thm@headsep\z@skip
   \let\thm@indent\indent 
   \def\thm@space@setup{%
     \thm@preskip=\smallskipamount
     \thm@postskip=\thm@preskip}
   \slshape
 }
 \def\th@remarkc{%
   \thm@bodyfont{\normalfont}
   \thm@headfont{\normalfont\slshape}
   \thm@notefont{\normalfont\slshape}
   \thm@headpunct{.}
   \let\thm@indent\indent 
   \thm@headsep\z@skip
 \def\thmheadnl{\newline\indent}
   \def\thm@space@setup{%
     \thm@preskip=\smallskipamount
     \thm@postskip=\thm@preskip}%
 }
\AtBeginDocument{%
\theoremstyle{plainc}%
  \newtheorem{theoc}[\cdr@thm]{\theoname}%
  \newtheorem{propc}[\cdr@thm]{\propname}%
  \newtheorem{conjc}[\cdr@thm]{\conjname}%
  \newtheorem{coroc}[\cdr@thm]{\coroname}%
  \newtheorem{lemmc}[\cdr@thm]{\lemmname}%
  \newtheorem{defic}[\cdr@thm]{\definame}%
  \newtheorem*{theoc*}{\theoname}%
  \newtheorem*{propc*}{\propname}%
  \newtheorem*{conjc*}{\conjname}%
  \newtheorem*{coroc*}{\coroname}%
  \newtheorem*{lemmc*}{\lemmname}%
  \newtheorem*{defic*}{\definame}%
  \theoremstyle{remarkc}%
  \newtheorem{notac}[\cdr@thm]{\notaname}%
  \newtheorem{notasc}[\cdr@thm]{\notasname}%
  \newtheorem{remac}[\cdr@thm]{\remaname}%
  \newtheorem{remasc}[\cdr@thm]{\remasname}%
  \newtheorem{exemc}[\cdr@thm]{\exemname}%
  \newtheorem{exemsc}[\cdr@thm]{\exemsname}%
  \newtheorem*{notac*}{\notaname}%
  \newtheorem*{notasc*}{\notasname}%
  \newtheorem*{remac*}{\remaname}%
  \newtheorem*{remasc*}{\remasname}%
  \newtheorem*{exemc*}{\exemname}%
  \newtheorem*{exemsc*}{\exemsname}%
\theoremstyle{plain}%
}%
%\def\proofheadfont{\slshape}
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep\smallskipamount
  \trivlist
  \item\hskip\parindent
        \slshape
        #1\@addpunct{\pointir}\ignorespaces\normalfont
}{%
  \popQED\endtrivlist\@endpefalse
}
%
%% Amsart/one numbering for everything compatibility
\ifcdr@onecountereverything
\let\c@equation\c@subsection
\let\theequation\thesubsection
\OneNumberAllTheorems
\NumberTheoremsAs{subsection}
\fi
\ifcdr@subsectaspar
\let\c@paragraph\c@subsection
\let\theparagraph\thesubsection
\let\subsection\paragraph
\setcounter{secnumdepth}{4}
\fi

%% Floats
\def\@captionheadfont{\slshape}
\def\@captionfont{\slshape}
\newskip\abovecaptionskip \abovecaptionskip=12pt \relax
\newskip\belowcaptionskip \belowcaptionskip=12pt \relax
\newdimen\captionindent \captionindent=\normalparindent
 \ifcdr@eqcountersinsections
 \numberwithin{equation}{section}
 \fi
 \ifcdr@flcountersinsections
 \numberwithin{figure}{section}
 \numberwithin{table}{section}
 \fi

\endinput