FROM r-base:4.0.3

ENV RENV_VERSION 0.12.5-2
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev

RUN mkdir -p /project
WORKDIR /project
COPY renv.lock renv.lock
RUN R -e 'renv::restore()'
