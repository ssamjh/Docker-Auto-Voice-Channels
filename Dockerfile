FROM python:slim

ENV DISABLE_LOOP=false
ENV HEARTBEAT_TIMEOUT=60
ENV RDY_MESSAGE=false
ENV AWS=false

RUN apt-get update &&\
    apt-get -y install curl unzip &&\
    curl https://codeload.github.com/gregzaal/Auto-Voice-Channels/zip/master -o avc.zip &&\
    unzip avc.zip &&\
    mv Auto-Voice-Channels-master AutoVoiceChannels &&\
    apt-get -y remove curl unzip &&\
    rm avc.zip 
    

WORKDIR /AutoVoiceChannels

RUN apt-get -y install build-essential &&\
    pip install -r /AutoVoiceChannels/requirements.txt &&\
    apt-get -y remove build-essential
    
# Clear unused files
RUN apt clean && \
    apt autoremove -y && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

COPY startAVC.sh startAVC.sh

CMD [ "bash", "startAVC.sh" ]
