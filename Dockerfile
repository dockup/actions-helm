FROM alpine:3.10

# https://github.com/dtzar/helm-kubectl/blob/master/Dockerfile
ENV KUBE_LATEST_VERSION="v1.15.2"
ENV HELM_VERSION="v2.14.3"
RUN apk add --no-cache ca-certificates bash ca-certificates curl jq \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm


# Install Google sdk for gcloud
ENV CLOUD_SDK_VERSION=266.0.0
RUN apk add --no-cache python \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && export PATH=/google-cloud-sdk/bin:$PATH \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true

COPY scripts /scripts
RUN chmod -R +x /scripts

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["--help"]
