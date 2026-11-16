#!/bin/sh
# Railway wrapper for useSend: fills in defaults Railway can derive, checks the
# login settings, then runs the image's own start script (database migrations,
# then the web server).
set -e

# Listen on every interface, IPv4 and IPv6 (Railway's private network is IPv6).
export HOSTNAME="${USESEND_LISTEN_HOST:-::}"
export PORT="${PORT:-3000}"

# The public URL. Railway sets RAILWAY_PUBLIC_DOMAIN when the service has a domain.
if [ -z "$NEXTAUTH_URL" ] && [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  export NEXTAUTH_URL="https://$RAILWAY_PUBLIC_DOMAIN"
fi

# useSend has no password login: it needs GitHub or Google OAuth, or e-mail
# links once a sending domain is verified. Fail with a clear message instead of
# a stack trace.
if [ -z "$GITHUB_ID$GOOGLE_CLIENT_ID$FROM_EMAIL" ]; then
  echo "useSend: no login method configured. Set GITHUB_ID and GITHUB_SECRET" >&2
  echo "(a GitHub OAuth app with callback https://YOUR-DOMAIN/api/auth/callback/github)," >&2
  echo "or GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET, then redeploy." >&2
  exit 1
fi

cd /app
exec sh /app/start.sh
