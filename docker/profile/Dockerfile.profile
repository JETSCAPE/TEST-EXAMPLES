# Build from the official docker python base image, based on Debian
FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive

# Install pre-reqs (commented ones are already in base image)
RUN apt update && apt install -y \
doxygen \
emacs \
ffmpeg \
gsl-bin \ 
hdf5-tools \
less \
libboost-all-dev \
libeigen3-dev \
libgsl-dev \
libhdf5-serial-dev \
libxpm-dev \
openmpi-bin \
rsync \
swig \
valgrind \
git \
vim \
build-essential \
cmake \
gpg-agent \
wget \
curl \
tclsh \
tcl-dev \
libxft-dev \
libxext-dev \
libfftw3-3 \
massif-visualizer \
kcachegrind \
kcachegrind-converters \
kmod \
#zlib1g-dev \
&& rm -rf /var/lib/apt/lists/*

# Install intel-basekit
RUN cd /tmp \
&& wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | \
  gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null \
&& echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | \
  tee /etc/apt/sources.list.d/oneAPI.list \
&& apt update \
&& apt install -y intel-basekit

RUN ["/bin/bash", "-c", "source /opt/intel/oneapi/vtune/latest/env/vars.sh"]

# Install Python
RUN apt update && apt install -y python3-pip

# Install additional useful python packages
RUN pip3 install --upgrade pip \
&& pip3 install \
emcee==2.2.1 \
h5py \
hic \
hsluv \
jupyter \
matplotlib \
nbdime \
numpy \
pandas \
pathlib \
ptemcee \
pyhepmc \
pyyaml \
scikit-learn \
scipy \
seaborn \
tqdm

# Install ROOT6 v6-26-06 (root excluded)
ENV ROOTSYS="/usr/local/root"
ENV PATH="${ROOTSYS}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${ROOTSYS}/lib:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="${ROOTSYS}/lib"

# Install HepMC 3.2.6
RUN curl -SL http://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.2.6.tar.gz | tar -xvzC /usr/local \
&& cd /usr/local \
&& mkdir hepmc3-build \
&& cd hepmc3-build \
&& cmake ../HepMC3-3.2.6 -DCMAKE_INSTALL_PREFIX=/usr/local -DHEPMC3_ENABLE_ROOTIO=OFF -DHEPMC3_BUILD_EXAMPLES=ON \
&& make -j8 install \
&& rm -r /usr/local/hepmc3-build
ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"

# Install Pythia8 with HepMC3-3.2.6 (that is needed by SMASH)
ARG pythiaV="8309"
RUN curl -SLk http://pythia.org/download/pythia83/pythia${pythiaV}.tgz \
| tar -xvzC /usr/local \
&& cd /usr/local/pythia${pythiaV} \
&& ./configure --enable-shared --prefix=/usr/local/ --with-hepmc3=/usr/local/HepMC3-3.2.6 \
&& make -j8 \
&& make -j8 install

# Set environmental variables for cmake to know where things are (needed for SMASH, heppy)
ARG username=jetscape-user
ENV JETSCAPE_DIR="/home/${username}/JETSCAPE"
ENV SMASH_DIR="${JETSCAPE_DIR}/external_packages/smash/smash_code"
ENV EIGEN3_ROOT /usr/include/eigen3
ENV PYTHIA8DIR /usr/local/
ENV PYTHIA8 /usr/local/
ENV PYTHIA8_ROOT_DIR /usr/local/
ENV PATH $PATH:$PYTHIA8DIR/bin

# Install environment modules
RUN curl -SLk https://sourceforge.net/projects/modules/files/Modules/modules-4.5.1/modules-4.5.1.tar.gz \
| tar -xvzC /usr/local \
&& cd /usr/local/modules-4.5.1 \
&& ./configure --prefix=/usr/local --modulefilesdir=/heppy/modules \
&& make -j8 \
&& make -j8 install

# Set up a user group
ARG id=1234
RUN groupadd -g ${id} ${username} \
&& useradd --create-home --home-dir /home/${username} -u ${id} -g ${username} ${username}
USER ${username}
ENV HOME /home/${username}
WORKDIR ${HOME}

ENTRYPOINT /bin/bash
