# py-meteo-num : Docker image for computational atmospheric sciences
# Anti-Copyright (a-c) Sandy Herho and Dasapta Erwin Irawan (2020).
# Distributed under the terms of the GNU GPLv3.

# We will use Debian 10 (Buster) for our image
FROM debian:buster-slim

LABEL maintainer="Sandy Hardian Susanto Herho <sandyherho@meteo.itb.ac.id>"

# Updating Debian packages
RUN apt update && yes|apt upgrade

# Adding wget and bzip2
RUN apt install -y wget bzip2

# Add sudo
RUN apt -y install sudo

# Add user Debian with no password, add to sudo group
RUN adduser --disabled-password --gecos '' debian && \
    adduser debian sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER debian
WORKDIR /home/debian/
RUN chmod a+rwx /home/debian/

# Anaconda installing
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    bash Anaconda3-2020.02-Linux-x86_64.sh -b && \
    rm Anaconda3-2020.02-Linux-x86_64.sh

# Set path to conda
ENV PATH /home/debian/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda && \
    conda update anaconda && \
    conda update --all

# Installing needed packages for atmospheric science research
RUN conda install -c conda-forge basemap cmocean basemap-data-hires cartopy \
    pydap metpy wrf-python siphon opencv fbprophet ctd pymc3 pygrib windspharm \
    paegan iris mpld3 owslib gsw cbsyst climlab xclim cdsapi cdo && \
    conda install -c anaconda netcdf4 xarray tensorflow && \
    conda install -c pytorch pytorch

# Configuring access to Jupyter
RUN mkdir /home/debian/notebooks && \
    jupyter notebook --generate-config --allow-root && \
    echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/debian/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupyter notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/home/debian/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
