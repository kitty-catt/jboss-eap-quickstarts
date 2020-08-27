FROM jboss-eap-7/eap72-openshift
LABEL io.k8s.description="kitchensink"

# option 1: get it from the shared workspace
# TODO

# option 2: get it from nexus
RUN  curl -L -X GET 'http://nexus3-tools.svc.cluster.local:8081/service/rest/v1/search/assets/download?sort=version&repository=maven-snapshots&group=org.jboss.eap.quickstarts&name=kitchensink&maven.baseVersion=0.1-SNAPSHOT' \
  --output /opt/eap/standalone/deployments/kitchensink.war

EXPOSE 8080
EXPOSE 9990
