FROM jenkins/jenkins:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common \
    dirmngr \
    gnupg \
    wget \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libpq-dev \
    git
    
RUN echo "deb https://cloud.r-project.org/bin/linux/debian bookworm-cran40/" > /etc/apt/sources.list.d/cran.list \
    && apt-get update --allow-insecure-repositories || true \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
    r-base r-base-dev

RUN R -e "install.packages('renv')"
RUN R -e 'renv::consent(provided = TRUE)'
USER jenkins
EXPOSE 8080
