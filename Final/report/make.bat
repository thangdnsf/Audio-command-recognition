@echo off
REM make.bat, 2018/10/07
REM Copyright (C) 2018 Luiz E. M. Lima (luizeduardomlima@gmail.com)
REM
REM This make.bat provides commands to make compiling LaTeX files.

REM Sets local variables
setlocal EnableDelayedExpansion

REM Source and base name
set src=utfprpgtex-article.tex
if [%src%] == [] set /p src="Enter source filename with 3-digits extension: "
set base_name=%src:~0,-4%

REM Title
title %base_name%

REM Command lines: latex, pdflatex, dvips, and ps2pdf
set "cmd_latex=latex -interaction=errorstopmode %base_name%.tex"
set "cmd_pdflatex=pdflatex -interaction=errorstopmode %base_name%.tex"
set "cmd_dvips=dvips -P pdf %base_name%.dvi -o %base_name%.ps"
set "cmd_ps2pdf=ps2pdf %base_name%.ps %base_name%.pdf"

REM bibtex or biber command line
set prg_bib=biber
if [%2] == [biber] set prg_bib=biber
if [%2] == [bibtex] set prg_bib=bibtex
if [%prg_bib%] == [] (
  set "cmd_bib=@echo Warning: no biber or bibtex execution."
) else (
  set "cmd_bib=%prg_bib% %base_name%"
)

REM makeindex command line
set prg_mkidx=
if [%3] == [mkidx] set prg_mkidx=makeindex
if [%prg_mkidx%] == [] (
  set "cmd_mkidx=@echo Warning: no makeindex execution."
) else (
  set "cmd_mkidx=%prg_mkidx% %base_name%.idx"
)

REM Creates dvi file
set "cmd_dvi=%cmd_latex% & %cmd_bib% & %cmd_mkidx% & %cmd_latex% & %cmd_latex%"
if [%1] == [dvi] %cmd_dvi%

REM Creates ps file
set "cmd_ps=%cmd_dvi% & %cmd_dvips%"
if [%1] == [ps] %cmd_ps%

REM Creates pdf file using latex or pdflatex
set "cmd_pdf1=%cmd_ps% & %cmd_ps2pdf%"
if [%1] == [pdf1] %cmd_pdf1%
set "cmd_pdf2=%cmd_pdflatex% & %cmd_bib% & %cmd_mkidx% & %cmd_pdflatex% & %cmd_pdflatex%"
if [%1] == [pdf2] %cmd_pdf2%

REM Removes intermediate files
set inter_files=*.aux *.log *.bbl *.bcf *.blg *.brf *.mw *.out *.run.xml^
  *.acn* *.acr* *.alg* *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.nlo *.nls^
  *.loa *.loc *.lod *.lof *.loh *.lop *.lot *.tdo *.toc
set "cmd_clean=del /s %inter_files% & del /s %base_name%.dvi %base_name%*.ps"
if [%1] == [clean] %cmd_clean%

REM Creates pdf file using latex or pdflatex and removes intermediate files
if [%1] == [all1] %cmd_pdf1% & %cmd_clean%
if [%1] == [all2] %cmd_pdf2% & %cmd_clean%

REM Shows help
if [%1] == [help] (
  @echo ##############################################################################
  @echo # Commands to make compiling LaTeX source files
  @echo ##############################################################################
  @echo # make dvi:       creates dvi, converts tex-dvi.
  @echo # make ps:        creates ps, converts tex-dvi-ps.
  @echo # make pdf1:      creates pdf using latex, converts tex-dvi-ps-pdf.
  @echo # make pdf2:      creates pdf using pdflatex, converts tex-pdf.
  @echo # make clean:     removes intermediate files.
  @echo # make all1:      creates pdf using latex and removes intermediate files.
  @echo # make all2:      creates pdf using pdflatex and removes intermediate files.
  @echo # make 1 biber:   uses biber to generate references with option 1.
  @echo # make 1 bibtex:  uses bibtex to generate references with option 1.
  @echo # make 1 2 mkidx: uses makeindex to generate index with options 1 and 2.
  @echo # make help:      shows help.
  @echo # option 1:       dvi, ps, pdf1, pdf2, all1, or all2.
  @echo # option 2:       biber or bibtex.
  @echo ##############################################################################
)

REM Unsets local variables
endlocal
