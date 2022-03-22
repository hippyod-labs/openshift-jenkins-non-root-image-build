# openshift-jenkins-non-root-image-build
Sample code supporting the Enable Sysadmin article [**_How to build images with rootless Podman in Jenkins on OpenShift_**](https://www.redhat.com/sysadmin/rootless-podman-jenkins-openshift).

## ERRATA
**Code fixes and updates from the original article have been made:**

1. I noticed an error in the SecurityContextConstraints definition: `Uid: 1001` should be `uid: 1001`.  I regret the error.  It has been fixed here.
1. Since the writing of the article, CRC has been updated and new version cannot install podman/skopeo/buildah on the Red Hat supplied Jenkins Agent image;
   therefore, after playing with it for awhile, I created a Fedora based Jenkins Agent image to get around the problem.  `Dockerfile.base` is now based on this image.  If you are running in a RHEL cluster with a valid subscription, you should have no problem with the original `Dockerfile.base` from the article, but if you are running a later version of CRC you can use this Dockerfile for testing purposes.
1. Dockerfile.base was also updated from
   ```
   chmod u-s /usr/bin/newuidmap && \
   chmod u-s /usr/bin/newgidmap && \
   ```

   to 

   ```
   chmod u-s /usr/bin/new[gu]idmap && \
   setcap cap_setuid+eip /usr/bin/newuidmap && \
   setcap cap_setgid+eip /usr/bin/newgidmap && \
   ```

   The latter code makes sure the proper capabilites are set on the two binaries.  Use the latter when creating your own Jenkins Agents, just to be sure.
1. The Jenkinsfile was updated so that it can be run multiple times without failing. `oc new-app` will only be executed once now.
1. A Jenkins instance will now be created automatically for you when running `agent-image-build.sh`, so there's no need to do so separately.