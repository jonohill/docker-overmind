FROM curlimages/curl AS download

ARG TARGETPLATFORM

WORKDIR /tmp

# renovate: datasource=github-releases depName=DarthSim/overmind
ARG OVERMIND_VERSION=v2.5.1
RUN ARCH="${TARGETPLATFORM#*/}"; \
    curl --fail -L -o /tmp/overmind.gz \
        https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-${ARCH}.gz && \
    gunzip /tmp/overmind.gz && \
    chmod +x /tmp/overmind


FROM alpine:3.23.2

RUN apk add --no-cache tmux

COPY --from=download /tmp/overmind /usr/local/bin/overmind

ENTRYPOINT [ "overmind" ]
CMD [ "start" ]
