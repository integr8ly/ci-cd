node("cirhos_rhel7"){
      deleteDir()

      withEnv(["GOPATH=$WORKSPACE",
               "BROKER_URL=http://msb-${NAMESPACE}.apps.${CLUSTER_ROUTE}"
            ])
            {
                  stage('Clone the managed-service-broker repo'){
                        dir(".") {
                              git branch: 'master', url: 'https://github.com/integr8ly/managed-service-broker.git'
                        }
                  }
        
                  stage('Docker Build & Push'){
                        dir("$GOPATH/src/github.com/integr8ly"){
                              sh '''
                                    ln -sf $WORKSPACE managed-service-broker
                                    cd managed-service-broker
            
                                    make build_binary 
                                    sudo docker login -u ${QUAY_USERNAME} -p ${QUAY_PASSWORD} quay.io
                                    sudo docker build -t quay.io/integr8lyqe/managed-services-broker:latest -f ./tmp/build/broker/Dockerfile .
                                    sudo docker push quay.io/integr8lyqe/managed-services-broker:latest
                              '''
                        }
                  }

                  stage('Deploy to OpenShift'){
                        dir("$WORKSPACE"){  
                              sh '''
                                    oc login https://master.${CLUSTER_ROUTE}:8443 -u admin@example.com -p Password1 --insecure-skip-tls-verify
                                    oc delete project ${NAMESPACE} || true
                                    sleep 30
                                    oc new-project ${NAMESPACE}
                                    oc process -f templates/broker.template.yaml \
                                          -p NAMESPACE=${NAMESPACE} \
                                          -p ROUTE_SUFFIX=${CLUSTER_ROUTE} \
                                          -p IMAGE_ORG=quay.io/integr8lyqe \
                                          -p IMAGE_NAME=managed-services-broker \
                                          -p IMAGE_TAG=latest \
                                          -p CHE_DASHBOARD_URL=empty \
                                          -p LAUNCHER_DASHBOARD_URL=empty \
                                          -p THREESCALE_DASHBOARD_URL=empty \
                                                | oc create -f - || true
                
                                    oc expose svc/msb
                                    sleep 30
	                        '''	
	                  }
                  }

                  stage('Test'){
                        dir("$GOPATH/src/github.com/integr8ly/managed-service-broker"){
                              sh '''
                                    export KUBERNETES_API_TOKEN=$(oc whoami -t)
                                    make integration          
	                        '''
                        }
	            }	
      }
}

