# git
export GIT_USERNAME='kitty-catt'

# CRC
export SONARQUBE_URL='http://sonarqube-sonarqube.tools.svc.cluster.local:9000'
export SONARQUBE_PROJECT=''
export SONARQUBE_LOGIN=''

export MY_PROJECT=""

# ICR with VA Scan
export IBM_ID_APIKEY=
export IBM_ID_EMAIL=
export IBM_REGISTRY_URL=
export IBM_REGISTRY_NS=

PS3='Please enter your choice: '
options=("init-ns" "setup-pipeline" "run-pipeline" "delete-ns" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "init-ns")
            echo "you chose init-ns"
            oc new-project $MY_PROJECT
            ;;
        "setup-pipeline")
            echo "you chose setup-pipeline"
            oc project $MY_PROJECT
            ./setup-pipeline.sh
            ;;
        "run-pipeline")
            echo "you chose run-pipeline"
            oc project $MY_PROJECT
            ./run-pipeline.sh
            ;;
        "delete-ns")
            echo "you chose delete-ns"
            oc delete project $MY_PROJECT
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
