# Deploying

## Objective #1 : Create a workspace

Description:
- Prep the workspace by forking the repo privately, adding reviewers, and using a feature branch for changes.

Execution:
```shell
# GitHub UI:
# - Fork the repo as private
# - Add collaborators: stefancrain, vbheemineni

# Local setup:
git clone <your-fork-url>
cd devops-coding-challenge-v2
git checkout -b feat/objective-1
```

Testing:
```shell
git remote -v
git branch --show-current
```

Screenshot:
![Healthcheck response](./assets/healthcheck.png)

## Objective #2 : Review and publish the app

Description:
- Updated the Dockerfile with non-root runtime ownership, healthcheck, and safer pip settings.
- Added a new SSH public key in app/app_ed25519.pub for the app to display.
- Pinned Werkzeug to 2.0.3 to keep Flask 2.0.2 compatible.
- Used a local tarball as the artifact (no cloud registry).

Execution:
```shell
# Build and run locally
docker build -t devops-challenge-app:local .
docker run -d --name app -p 8080:8080 devops-challenge-app:local
docker rm -f app

# Build, test, and publish in one script
./build_test_publish.sh

# Local artifact (publish)
docker save devops-challenge-app:local | gzip > package.tar.gz
```

Testing:
```shell
curl http://localhost:8080/healthcheck
curl http://localhost:8080/
```

## Objective #3 : Deploy the app using Kubernetes

Description:
- TODO

Execution:
```shell
# TODO
```

Testing:
```shell
# TODO
```

## Objective #4 : Monitor the app

Description:
- TODO

Execution:
```shell
# TODO
```

Testing:
```shell
# TODO
```

## Feedback

Feel free to mention hours and comments on hands-on exam here
