#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
# ===========================================================================
# makefile.R (Release 0.5.0)
# ==========-----------------------------------------------------------------
#
# (C)opyleft by Norman Markgraf in 2017 
#
# Lizenz: GNU General Public License v3.0
#
# Ein Skript um alle Rmd-Dateien in PDF-Dateien umzuwandeln
#
# Zum Starten einfach: 
# > source("makefile.R") 
# eingeben
#
#
# Releases:
# ---------
# 0.1.0  (nm)  13. Nov. 2017  Erster Entwurf
# 0.1.1  (nm)  15. Nov. 2017  Typo fixed! Und Debuginformationen eingebaut!
# 0.2.0  (nm)  15. Nov. 2017  Parallelisierung eingebaut... (EXPERIMENTAL!!)
# 0.2.1  (nm)  15. Nov. 2017  Rückbau auf Version OHNE Parallelisierung!
# 0.2.2  (kl)  16. Nov. 2017  Lauffähigkeit wiederhergestellt
# 0.2.3  (nm)  18. Nov. 2017  "library(methods)" hinzugefügt.
# 0.2.4  (nm)  20. Nov. 2017  Speicher aufräumen am Anfang!
# 0.3.0  (nm)  22. Nov. 2017  "Build"-Verzeichnis zwecks Übersichlichkeit
#                             eingeführt.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# 0.5.0  (nm)  30. Nov. 2017  Neues Konzept.
#
# ---------------------------------------------------------------------------

library(rmarkdown)
library(methods)

beamer_presentation_loop <- getFunction("beamer_presentation")

doRender <- function(rmdfile, outputformat="beamer_presentation")
{
	rmarkdown::render(               
		input = rmdfile,               
		output_format = outputformat,  
		envir = globalenv(),           
		encoding = "UTF-8"             
	)                                
}


# test if there is at least one argument: if not, return an error
if (length(args) == 0) 
{
	stop("At least one argument must be supplied (input file).n", call. = FALSE)
}

if (length(args) == 1) {
	  # default output file
	  doRender(args[1])
} else 
{
  if (length(args) == 2) 
  {
    if (args[2] == "revealjs_presentation" || args[2] == "revealjs::revealjs_presentation") 
    {
      library(revealjs)
      doRender(args[1], revealjs_presentation(
        theme = "moon",        # "simple", "sky", "beige", "serif", "solarized", "blood", "moon", "night", "black", "league" or "white"
        highlight = "zenburn",  # default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn", and "haddock"
        pandoc_args = "--filter=pandoc-filter/typography.py",
        center = FALSE,
        self_contained = TRUE,
        fig_caption = FALSE,
        reveal_options = "width: '100%', height: '100%', margin: 0, minScale: 1, maxScale: 1"
        ))
    } 
    else 
    {
	    doRender(args[1], args[2])
    }
  }
}



# ===========================================================================
