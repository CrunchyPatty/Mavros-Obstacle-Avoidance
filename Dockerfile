FROM noetic-base


ENV USER=Queen
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/Queen/


RUN apt-get update && apt-get install -y \
python3-pip \
ros-noetic-mavros \
ros-noetic-mavros-extras \
iproute2 \
&& rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh \
   && chmod a+x install_geographiclib_datasets.sh \
   && ./install_geographiclib_datasets.sh

RUN python3 -m pip install \
lxml \
pymavlink \
pexpect \
future \
empy

RUN echo "keyboard-configuration keyboard-configuration/layoutcode select us" | debconf-set-selections && \
echo "keyboard-configuration keyboard-configuration/modelcode select pc105" | debconf-set-selections

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata

USER Queen

WORKDIR /home/Queen/shared_ws/  

COPY startup.sh /home/Queen/startup.sh

ENTRYPOINT [ "/bin/bash", "/home/Queen/startup.sh" ]
CMD [ "/bin/bash" ]