#!/usr/bin/bash
# execute script in this directory
cd "$(dirname ${0})"

# create a new project for testing
oc new-project non-root-image-builds

# create the builds for each agent image
oc new-build --name non-root-jenkins-agent-base  --binary=true --strategy=docker
oc new-build --name non-root-jenkins-agent-python --binary=true --strategy=docker

# build the base jenkins agent
cp -v Dockerfile.base /tmp/Dockerfile
oc start-build non-root-jenkins-agent-base --from-file=/tmp/Dockerfile --wait --follow
rm -f /tmp/Dockerfile

# build the python jenkins agent
cp -v Dockerfile.python /tmp/Dockerfile
oc start-build non-root-jenkins-agent-python --from-file=/tmp/Dockerfile --wait --follow
rm -f /tmp/Dockerfile
