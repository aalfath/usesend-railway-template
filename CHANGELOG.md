# Changelog

Each entry is one update that reaches everyone who deployed the template. Breaking changes are listed first.

## README button (2026-11-16)

- Added the Deploy on Railway button for the published template `usesend-1`. No change to the deployed service.

## 1.10.4 (2026-11-16)

- First release: useSend v1.10.4 (`usesend/usesend:v1.10.4@sha256:ae78d9dcc9e73645b406ec3256967956498c346e42ce7221ba4c1f92aee09071`) with Railway Postgres and Redis.
- The wrapper listens on IPv4 and IPv6, derives `NEXTAUTH_URL` from the Railway domain, and stops with a clear message when no login method is set.
