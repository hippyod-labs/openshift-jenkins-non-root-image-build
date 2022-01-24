# Example of a Python Jenkins Agent built from the base image
# Replace the default OpenShift route if using a different registry than the CRC default
FROM default-route-openshift-image-registry.apps-crc.testing/non-root-image-builds/non-root-jenkins-agent-base

USER root

RUN yum install -y --setopt=tsflags=nodocs gcc python3-devel python3-setuptools python3-pip python3-wheel && \
    yum clean all && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install bzt virtualenv && \
    rm -f /var/logs/*

# Make sure to set the user by UID; username will not work, because OCP cannot tell whether it's a non-root user
# We want to only use a non-root user an not allow the container to run with root
USER 1001