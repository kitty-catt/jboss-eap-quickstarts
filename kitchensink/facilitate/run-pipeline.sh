echo "run pipeline in namespace ${MY_PROJECT}"
#tkn pipeline start build-and-deploy -r git-repo=git-source-inventory -r image=docker-image-inventory -p deployment-name=kitchensink-deployment

tkn pipeline start build-and-deploy-java \
-r git-repo=git-source-inventory \
-r image=docker-image-inventory \
-p deployment-name=kitchensink-deployment \
-p image-url-name=${IBM_REGISTRY_URL}/${IBM_REGISTRY_NS}/kitchensink:latest \
-p scan-image-name=true
