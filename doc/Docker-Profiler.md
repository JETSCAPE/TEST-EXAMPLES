# Docker Profiler

The Docker image provided for profiling contains the JETSCAPE/X-SCAPE pre-requisites as well as additional profiling tools.  The image can be pulled directly from DockerHub [here](https://hub.docker.com/r/jetscape/profile). This image is intended for JETSCAPE/X-SCAPE collaborators working on performance profiling and optimization.

## Example Steps to Pull and Run the Profiling Image

These steps show how to pull the Docker image, create a container based on the image, and test the vTune Profiler.  Instructions to install JETSCAPE/X-SCAPE are not included in these instructions.  These steps were created using a Ubuntu Linux system with Docker already installed.

### Pull and Run the Image

This command pulls the profiler image from DockerHub, ensures that host processes will be available in the container, mounts the host system's home directory in the container as **/home/jetscape-user**, and runs the container.

```
docker run --pid=host --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE -it -v ~/:/home/jetscape-user --name myJetProfile jetscape/profile:beta
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

Note that in addition to vTune, the profiling tools Massif-Visualizer, KCachegrind, Valgrind, and 


