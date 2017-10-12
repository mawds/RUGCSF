.PHONEY: present clean all rpackages publish unpublish clean exampledoc

presentationname=RUGCSF
pubdoc=./docs/index.html
figures=$(wildcard figs/*.png) $(wildcard figs/*.jpg) 
#SUBDIRS=example

all:  $(presentationname).html 


$(presentationname).html: $(presentationname).Rmd 
	Rscript -e "rmarkdown::render('$<')"

$(presentationname).Rmd: $(figures) 
	
#subdirs: $(SUBDIRS)

present: $(presentationname).html
	chromium-browser $< &

clean:
	rm -f $(presentationname).html 

rpackages:
	Rscript installRpackages.R




