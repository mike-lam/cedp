// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            // Rather than inline YAML, in a multibranch Pipeline you could use: yamlFile 'jenkins-pod.yaml'
            // Or, to avoid YAML:
            // containerTemplate {
            //     name 'shell'
            //     image 'ubuntu'
            //     command 'sleep'
            //     args 'infinity'
            // }
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: shell
    image: openshift/origin-cli
    command:
    - sleep
    args:
    - infinity
'''
            // Can also wrap individual steps:
            // container('shell') {
            //     sh 'hostname'
            // }
            defaultContainer 'shell'
        }
    }
    stages {
	    
        stage('DeployGrafana') {
            steps {
                sh '''#!/bin/bash
		git --version
		oc --help
		          oc login -u admin -p admin --insecure-skip-tls-verify https://api.crc.testing:6443
		          oc project a1
                  oc adm policy add-scc-to-user anyuid  system:serviceaccount:a1:default 
		          GRP=app.kubernetes.io/part-of=monitoring-grp
                  dbname=grafana
                  user=grafana
                  password=grafana
                  oc get templates -n openshift -o custom-columns=NAME:.metadata.name|grep -i ^postgres
                  oc new-app --name=postgresql-$dbname --template=postgresql-ephemeral -p DATABASE_SERVICE_NAME=postgresql-$dbname -p POSTGRESQL_USER=$user -p POSTGRESQL_PASSWORD=$password -p POSTGRESQL_DATABASE=$dbname -l ${GRP}
                  
                  oc new-app grafana/grafana \
                    --name=grafana-cedp \
            	    -l ${GRP} 
                  oc expose service/grafana-cedp

		            '''
            }
        }
	    
   
	    
    }
}
