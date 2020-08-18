echo "setup pipeline"

# doubtfull prelims
oc adm policy add-scc-to-user anyuid system:serviceaccount:${MY_PROJECT}:default
oc apply -f ../tekton/clusteradmin-rolebinding.yaml

# give default sa access to icr for pulling the build image
oc delete secret regcred 
oc create secret docker-registry regcred \
--docker-server=https://${IBM_REGISTRY_URL}/v1/ \
--docker-username=iamapikey \
--docker-password=${IBM_ID_APIKEY} \
--docker-email=${IBM_ID_EMAIL}
oc secrets link default regcred --for=pull

# give access to icr for pushing the image

oc delete secret ibmcloud-apikey 2>/dev/null
oc create secret generic ibmcloud-apikey --from-literal APIKEY=${IBM_ID_APIKEY}

oc delete configmap ibmcloud-config 2>/dev/null
oc create configmap ibmcloud-config \
--from-literal RESOURCE_GROUP=default \
--from-literal REGION=eu-de

# link to the secret
oc apply -f ../tekton/link-sa-pipeline.yaml

# pipeline resource to clone from git, and push to icr
oc apply -f ../tekton/kitchensink-pipeline-resources.yaml

# add tekton tasks
oc apply -f ../tekton/01_apply_manifest_task.yaml
oc apply -f ../tekton/02_update_deployment_task.yaml
oc apply -f ../tekton/03_restart_deployment_task.yaml
oc apply -f ../tekton/04_build_vfs_storage.yaml

# gradle
#oc apply -f ../tekton/05_java_sonarqube_task.yaml
oc apply -f ../tekton/06_VA_scan.yaml

# maven scan
#oc apply -f https://github.com/IBM/ibm-garage-tekton-tasks/blob/master/tasks/1-java-maven-test.yaml
oc apply -f ../tekton/07_ibm-java-maven-test.yaml

# pipeline
#oc apply -f ../tekton/pipeline-vfs-just-sonar.yaml
oc apply -f ../tekton/pipeline-vfs-sonar-and-icr.yaml

# sonarqube
echo "using SONARQUBE_URL=${SONARQUBE_URL}"
oc delete configmap sonarqube-config-java 2>/dev/null
oc create configmap sonarqube-config-java \
--from-literal SONARQUBE_URL=${SONARQUBE_URL}
            
oc delete secret sonarqube-access-java 2>/dev/null
oc create secret generic sonarqube-access-java \
--from-literal SONARQUBE_PROJECT=${SONARQUBE_PROJECT} \
--from-literal SONARQUBE_LOGIN=${SONARQUBE_LOGIN} 
