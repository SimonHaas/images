FROM manimcommunity/manim:v0.18.1
# TODO latest-tag does not work to install manim-voiceover: Cannot install on Python version 3.11.11; only versions >=3.7,<3.11 are supported.

USER root

RUN apt-get update && \
    apt-get install -y \
        git \
        htop \
        nano \
        vim \
        ffmpeg \
        libportaudio2 \
        libportaudiocpp0 \
        portaudio19-dev \
        python3-dev \
        build-essential \
        xdg-utils \
        unzip \
        sox \
        portaudio19-dev \
        libasound-dev \
        libevdev-dev \
        libsox-dev \
    && rm -rf /var/lib/apt/lists/*

# RUN pip install --upgrade pip
RUN pip install --upgrade "manim-voiceover[all]"
#RUN pip install "manim-voiceover[all]"
#RUN pip install TTS

RUN echo 'root:root' | chpasswd && \
    echo 'manimuser:manimuser' | chpasswd

USER manimuser
