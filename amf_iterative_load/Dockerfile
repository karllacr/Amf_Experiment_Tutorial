FROM golang:1.14.4-stretch

WORKDIR /workspace

RUN git clone https://github.com/TheDramaturgy/my5G-RANTester \
    && cd my5G-RANTester  \
    && go mod download 

WORKDIR /workspace/my5G-RANTester/scripts

RUN go build -o amf_load

VOLUME [ "/workspace/my5G-RANTester/config" ]

COPY exec.sh /workspace/
RUN chmod +x /workspace/exec.sh
ENTRYPOINT [ "/workspace/exec.sh" ]