# Docker Dispatch

## Available Docker Images

JETSCAPE provides several Docker images for use with JETSCAPE and X-SCAPE.

1. A Docker image with preinstalled dependencies.  In most cases, this is the recommended Docker image.  This image contains the software prerequisites needed to install JETSCAPE or X-SCAPE but not the JETSCAPE or X-SCAPE installations themselves.  After starting a container based on this image, you can clone or install JETSCAPE or X-SCAPE in a mounted home directory.  This allows for source code modification and development.  Installation instructions for this recommended Docker usage is linked [here for JETSCAPE](https://github.com/JETSCAPE/JETSCAPE/wiki/Doc.Installation.Docker) and [here for X-SCAPE](https://github.com/JETSCAPE/X-SCAPE/wiki/Doc.Installation.Docker).  Note that JETSCAPE and X-SCAPE require the same dependencies, so the same Docker image is used for both instruction sets.

2. A Docker image is provided that includes a full installation of JETSCAPE.  Because the application itself is preinstalled, this image is not ideal for development, but can be used to run JETSCAPE as it.  An example showing this usage is linked [here](https://github.com/JETSCAPE/JETSCAPE/wiki/Doc.Installation.Docker.Linux.Full).

3. A Docker image is provided that includes a full installation of X-SCAPE.  Because the application itself is preinstalled, this image is not ideal for development, but can be used to run X-SCAPE as it.  An example showing this usage is linked [here](https://github.com/JETSCAPE/X-SCAPE/wiki/Doc.Installation.Docker.Linux.Full).

4. A Docker image native to the ARM64 architecture and including the JETSCAPE dependencies is provided.  The current implementation of this ARM64 image does not include the Root and Heppy packages.  And unlike the *stable* image, this ARM64 image is not fully vetted.  This image is mainly intended for users interested to run JETSCAPE or X-SCAPE on their M1 Macs and is not intended as a full production environment.

5. A Docker image is provided that includes prerequisites for profiling and performance analysis (in development).

## Docker Dispatch Instructions

Because JETSCAPE and X-SCAPE provide multiple Docker images, a deployment utility is provided [here](https://github.com/JETSCAPE/TEST-EXAMPLES/actions/workflows/docker-deploy.yaml) to allow administrators and collaborators with write access to this repository the ability to build and deploy our Docker images using GitHub Workflows.

1. Sign into GitHub using an account that has sufficient access privileges to this repository.
2. Navigate to the [docker-build](https://github.com/JETSCAPE/TEST-EXAMPLES/actions/workflows/docker-deploy.yaml) *GitHub Actions* page.
3. Click the **Run workflow** dropdown button.  If you do not see the button, you do not have sufficient access privileges to run the utility.
4. In the drop down window, complete the following fields:
    * In the "Use workflow from" field, choose **Branch: main** unless the Dockerfile you want to call is from another branch.
    *  In the "input for docker version" field, write the tag name to be appended to the repository on Docker Hub.  For example: stable, beta, v1.8, etc.
    * In the "input for container name" field, type the name of the repository that will be appended to the jetscape account name on DockerHub.  For example, if you typed *beta* in the above tag field and *xscape_full* in this name field, the image will be deployed on Docker Hub as **jetscape/xscape_full:beta**
    * In the "path to Dockerfile" field, enter the path to the Dockerfile given the repository's **docker** folder as the present working directory.  Any Dockerfile we can call should be in a subfolder of this repository's docker folder.
        * To build the full X-SCAPE Docker image, input: **full/Dockerfile.xscape.full**
        * To build the full JETSCAPE Docker image, input: **full/Dockerfile.jetscape.full**
        * To build the standard dependencies-only version of the Docker Image, input: **base/Dockerfile.base**
    * After entering the above data, click the **Run workflow** button.  The image will be created and deployed to [JETSCAPE's Docker Hub page](https://hub.docker.com/u/jetscape).
