FROM alpine/helm:2.14.1 AS helm


FROM alpine:3.10

RUN apk add --update --no-cache ca-certificates bash

COPY --from=helm /usr/bin/helm /usr/bin/helm
RUN chmod +x /usr/bin/helm

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
