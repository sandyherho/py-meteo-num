# py-meteo-num

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![](https://images.microbadger.com/badges/version/herholabs/py-meteo-num.svg)](https://microbadger.com/images/herholabs/py-meteo-num "Get your own version badge on microbadger.com") 

#### [![DOI](https://zenodo.org/badge/267724851.svg)](https://zenodo.org/badge/latestdoi/267724851)

Docker image for implementing atmospheric science data analysis algorithms using Python 3 inside Jupyter Notebook.

Users are required to install the docker in advance according to the host operating systems respectively. The guidelines can be obtained through [this site](https://docs.docker.com/engine/install/).

To initiate this docker session, run the following command:

```bash
docker run --name herholabs/py-meteo-num -p 8888:8888 --env="DISPLAY" -v "${PWD/notebooks:/home/debian/notebooks}" -d meteo-num  
```

Then open your browser and enter port 8888: <a href="http://localhost:8888/" target="_blank">http://localhost:8888/.</a>

You will be asked to enter a password. For the password requested, enter: `root`.

To copy files folders from host to container, run:

```bash
docker cp /[host_path]/[file or folder_name] meteo-num:/home/notebooks
```

Instead, to copy files / folders from container to host, run:

```bash
docker cp meteo-num:/home/notebooks/[file or folder_name] /[host_path] 
```

To stop and delete a container, run:

```bash
docker rm -f meteo-num  
```

