FROM bgruening/galaxy-stable

RUN if [ ! -d docker-cellorganizer-galaxy ]; then git clone https://github.com/icaoberg/docker-cellorganizer-galaxy.git; fi && \
	cd docker-cellorganizer-galaxy && \
	git fetch --all && \
	git pull origin master
RUN if [ ! -d mcell_galaxy ]; then git clone https://github.com/mcellteam/mcell_galaxy.git; fi && \
	cd mcell_galaxy && \
	git fetch --all && \
	git pull origin master
RUN rm -fv $(pwd)/config/tool_conf.xml && cp -v $(pwd)/mcell_galaxy/config/tool_conf.xml $(pwd)/config/tool_conf.xml
RUN cd mcell_galaxy && git fetch --all 
RUN rm -rfv $(pwd)/tools/*
RUN cp -rv $(pwd)/mcell_galaxy/tools/mcell $(pwd)/tools/
RUN wget -nc --O mcell.zip http://mmbios.org/mcell-3-4/mcell_34_linux-zip?format=raw && unzip mcell.zip && rm -fv mcell.zip
