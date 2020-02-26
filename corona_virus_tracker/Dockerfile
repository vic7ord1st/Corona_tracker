FROM r-base:latest

# Install Ubuntu packages
RUN apt-get update && apt-get install -y --allow-downgrades \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libx11-dev \
    libxt-dev \
    libxcb1=1.13.1-2 \
    libxcb1-dev \
    libx11-dev \
    libssl-dev \
    libxml2 \
    libxml2-dev

# Download and install ShinyServer (latest version)
RUN wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.12.933-amd64.deb" -O ss-latest.deb && \
    wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb

# Install R packages that are required
# TODO: add further package if you need!
RUN R -e "install.packages(c('shiny', 'shinydashboard', 'plotly', 'httr', 'jsonlite'), repos='http://cran.rstudio.com/')"


# Copy configuration files into the Docker image
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /app /srv/shiny-server/

# Make the ShinyApp available at port 80
EXPOSE 3000

# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]