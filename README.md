# useSend on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/usesend-1?utm_medium=integration&utm_source=button&utm_campaign=usesend)

A one-click Railway template for [useSend](https://github.com/usesend/useSend), the open-source email platform (an alternative to Resend, SendGrid and Postmark) that sends through your own Amazon SES account.

## What it deploys

| Service | Source | Notes |
|---|---|---|
| `useSend` | this repo (`Dockerfile`) | `usesend/usesend:v1.10.4`, pinned by digest. Public domain, health check `/api/health` |
| `Postgres` | Railway Postgres | Teams, domains, contacts, campaigns and email logs, on a volume |
| `Redis` | Railway Redis | Job queues (BullMQ) and cache, on a volume. Private only |

The wrapper (`railway-start.sh`) only sets the listen address, derives `NEXTAUTH_URL` from the Railway domain, checks that a login method is set, and then runs the image's own start script (Prisma migrations, then the web server).

## Variables

| Variable | Default | Notes |
|---|---|---|
| `GITHUB_ID`, `GITHUB_SECRET` | prompt | A GitHub OAuth app. Callback URL: `https://YOUR-DOMAIN/api/auth/callback/github`. useSend has no password login |
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | prompt | An IAM user with SES and SNS access. useSend sends all mail through SES |
| `AWS_DEFAULT_REGION` | `us-east-1` | The AWS region useSend uses for its own SES and SNS calls |
| `NEXTAUTH_SECRET` | generated | Session signing secret |
| `NEXTAUTH_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Change it if you add a custom domain |
| `DATABASE_URL`, `REDIS_URL` | references | Point at the template's Postgres and Redis |
| `PORT` | `3000` | |

The first account that signs in becomes the instance admin. After that, new people can only join through a team invite. Optional settings (Google login, `ADMIN_EMAIL`, image uploads through S3-compatible storage, `EMAIL_CLEANUP_DAYS`) are listed in useSend's [`.env.selfhost.example`](https://github.com/usesend/useSend/blob/main/.env.selfhost.example).

## Updates

Changes to this repo's `main` branch reach everyone who deployed the template as an "update available" notice in Railway, and each deployer chooses when to apply it. Every update bumps the pinned image and adds an entry to [`CHANGELOG.md`](CHANGELOG.md). Read it before applying.

## License

useSend is licensed under AGPL-3.0 by its authors. This repo only adds the Railway wrapper.
