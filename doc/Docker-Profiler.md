# Docker Profiler

The Docker image provided for profiling contains the JETSCAPE/X-SCAPE pre-requisites as well as additional profiling tools.  The image can be pulled directly from DockerHub [here](https://hub.docker.com/r/jetscape/profile). This image is intended for JETSCAPE/X-SCAPE collaborators working on performance profiling and optimization.

## Example Steps to Pull and Run the Profiling Image

These steps show how to pull the Docker image, create a container based on the image, and test the vTune Profiler.  Instructions to install JETSCAPE/X-SCAPE are not included in these instructions.  These steps were created using a Ubuntu Linux system with Docker already installed.

### Pull and Run the Image

This command pulls the profiler image from DockerHub, ensures that host processes will be available in the container, mounts the host system's home directory in the container as **/home/jetscape-user**, and runs the container.

```
docker run --pid=host --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE -it -v ~/:/home/jetscape-user --name myJetProfile jetscape/profile:v0.6
```

### Source the vTune Profiler

```
source /opt/intel/oneapi/vtune/latest/env/vars.sh
```

### Run the Self-Checker to Test vTune
```
vtune-self-checker.sh
```
The vTune Self-Checker will run several tests.  This could take several minutes.

### Exiting the Container

To exit the container, type **exit**.
```
exit
```

### Re-Entering the Container
To re-enter the container, type the following command:

```
docker start -ai myJetProfile
```

---

## Notes

* In addition to vTune, the profiling tools Massif-Visualizer, KCachegrind, Valgrind, and gProf are also included in the jetscape/profile:beta image.

* Since vTune is installed inside Docker, some profiling limitations may apply.  Installing vTune locally on an Ubuntu host system with sudo privileges can be done using the APT package manager.

    ```
    cd /tmp \
    && wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
    && sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
    && rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
    && echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list \
    && sudo apt update \
    && sudo apt install -y intel-oneapi-vtune
    ```

    Then source the vTune profiler.
    ```
    source /opt/intel/oneapi/vtune/latest/env/vars.sh
    ```
