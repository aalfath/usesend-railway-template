# useSend for Railway: the official image, pinned by version and digest.
# Upstream: https://github.com/usesend/useSend (AGPL-3.0)
FROM usesend/usesend:v1.10.4@sha256:ae78d9dcc9e73645b406ec3256967956498c346e42ce7221ba4c1f92aee09071

# Fixed settings for a self-hosted instance. Override any of them with a
# service variable of the same name.
ENV PORT=3000 \
    AWS_DEFAULT_REGION=us-east-1 \
    NEXT_TELEMETRY_DISABLED=1

COPY railway-start.sh /app/railway-start.sh

CMD ["sh", "/app/railway-start.sh"]
