# ===========================================================================
# Makefile (Release 1.0.0)
# ========-------------------------------------------------------------------
# 
# (C)opyleft in 2017 by Norman Markgraf
# 
# Releases:
# =========
#   1.0.0 - 01.12.2017 (nm) - Erste Fassung für das Repository
# 
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# OS detection
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ifeq ($(OS),Windows_NT)
    detected_OS := Windows
else
    detected_OS := $(shell sh -c 'uname -s 2>/dev/null || echo not')
endif

RSCRIPT = Rscript
RSCRIPT_OPTS = --vanilla
GIT = git

# ---------------------------------------------------------------------------

RMDIR = rm -fr 
RM = rm -f
MKDIR = mkdir

# ---------------------------------------------------------------------------

PANDOCFILTERDIR = "pandoc-filter"
REPOURL = "https://github.com/NMarkgraf/typography.py.git"

SCHLEIFEN  = Schleife-PraDA.pdf 
SCHLEIFEN += Schleife-DES.pdf 
SCHLEIFEN += Schleife-QFM.pdf
SCHLEIFEN += Schleife-WM.pdf
SCHLEIFEN += Schleife-WMQD.pdf
SCHLEIFEN += Schleife-QMWI.pdf

FOLIEN  = Praxis-der-Datenanalyse.pdf 
FOLIEN += Datenerhebung-Statistik.pdf
FOLIEN += Quantitative-Forschungsmethoden.pdf
FOLIEN += Wissenschaftliche-Methodik.pdf
FOLIEN += WissMethoden-QuantitativeDatenanalyse.pdf
FOLIEN += QM-Wirtschaftsinformatik.pdf

HTML = $(FOLIEN:%.pdf=%_slidy.html) $(FOLIEN:%.pdf=%_ioslides.html)

# ---------------------------------------------------------------------------

.PHONY: all all-schleifen all-folien all-html

all: init update $(SCHLEIFEN) $(FOLIEN)

all-schleifen: init update $(SCHLEIFEN)

all-folien: init update $(FOLIEN)

all-html: init update $(HTML)

# ---------------------------------------------------------------------------

.PHONY: init init-filterdir

init: init-filterdir

init-filterdir:
	if [ ! -d "./$(PANDOCFILTERDIR)" ];then	\
		$(MKDIR) $(PANDOCFILTERDIR);	\
		$(GIT) clone $(REPOURL) $(PANDOCFILTERDIR); \
	fi

# ---------------------------------------------------------------------------

.PHONY: update update-filter

update: update-filter

update-filter: 	
	cd $(PANDOCFILTERDIR)
	$(GIT) checkout master
ifneq ($(detected_OS),Windows)
		chmod a+x $(PANDOCFILTERDIR)/*.py
endif
	cd ..

# ---------------------------------------------------------------------------

.PHONY: clean clean-filterdir clean-tex clean-schleifen clean-folien

clean: clean-schleifen clean-folien

clean-filterdir:
	if [ -d "./$(PANDOCFILTERDIR)" ];then	\
		$(RMDIR) $(PANDOCFILTERDIR);	\
	fi

clean-tex:
	$(RM)  $(SCHLEIFEN:%.pdf=%.tex) $(FOLIEN:%.pdf=%.tex) texput.log
	
clean-schleifen: 
	$(RM) $(SCHLEIFEN)

clean-folien:
	$(RM) $(FOLIEN)

# ---------------------------------------------------------------------------

.PHONY: proper super-proper proper-folien proper-schleifen

proper: clean proper-schleifen proper-folien

super-proper: proper clean-filterdir

proper-folien:
	$(RMDIR) $(FOLIEN:%.pdf=%_cache) $(FOLIEN:%.pdf=%_files)

proper-schleifen: 
	$(RMDIR) $(SCHLEIFEN:%.pdf=%_cache) $(SCHLEIFEN:%.pdf=%_files)
	
proper-html:
	$(RMDIR) $(FOLIEN:%.pdf=%_slidy_files) $(FOLIEN:%.pdf=%_ioslides_files) $(FOLIEN:%.pdf=%_files/figure-revealjs) $(FOLIEN:%.pdf=%_cacherevealjs)

# ---------------------------------------------------------------------------

setup-filterdir: 
	cd $(PANDOCFILTERDIR)
	$(GIT) init
	$(GIT) remote add origin $(REPOURL)
	$(GIT) fetch
	$(GIT) checkout origin/master -ft
	cd ..

# ---------------------------------------------------------------------------
	
Schleife-%.pdf: Schleife-%.Rmd
	$(RSCRIPT) $(RSCRIPT_OPTS) makefile.R $< "beamer_presentation_loop"
	
%.pdf: %.Rmd
	$(RSCRIPT) $(RSCRIPT_OPTS) makefile.R $<

# %%%EXPERIMENTAL%%%
# ioslides presentation
%_ioslides.html: %.Rmd
	$(RSCRIPT) $(RSCRIPT_OPTS) makefile.R $< "ioslides_presentation"

# %%%EXPERIMENTAL%%%
# slidy presentation
%_slidy.html: %.Rmd
	$(RSCRIPT) $(RSCRIPT_OPTS) makefile.R $< "slidy_presentation"

# %%%EXPERIMENTAL%%%
# reaveal.js presentation
%_revealjs.html: %.Rmd
	$(RSCRIPT) $(RSCRIPT_OPTS) makefile.R $< "revealjs_presentation"
	

# 
# ===========================================================================
