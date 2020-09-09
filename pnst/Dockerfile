FROM jboss-eap-7/eap72-openshift
LABEL io.k8s.description="kitchensink"

USER jboss
# option 1: get it from the shared workspace
# TODO

# option 2: get it from nexus
#RUN  curl -L -X GET 'http://nexus3.tools.svc.cluster.local:8081/service/rest/v1/search/assets/download?sort=version&repository=maven-snapshots&group=org.jboss.eap.quickstarts&name=pnst&maven.baseVersion=0.1-SNAPSHOT&maven.extension=ear' \
#  --output /opt/eap/standalone/deployments/ROOT.war

# note: we can upload releases but not snapshots.
RUN  curl -L -X GET 'http://nexus3.tools.svc.cluster.local:8081/service/rest/v1/search/assets/download?sort=version&repository=maven-snapshots&group=org.jboss.eap.quickstarts&name=pnst&maven.baseVersion=0.1&maven.extension=ear' \
  --output /opt/eap/standalone/deployments/ROOT.ear

ENV DEP_DIR="/opt/eap/standalone/deployments"
RUN chown -R jboss:0 $DEP_DIR 


EXPOSE 8080
EXPOSE 9990
