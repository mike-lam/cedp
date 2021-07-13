
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
	    
        stage('DeploySonarqube') {
            steps {
                sh '''#!/bin/bash
		    oc login -u admin -p admin --insecure-skip-tls-verify https://api.crc.testing:6443
		    oc project a1
		    GRP=app.kubernetes.io/part-of=sonarqube-grp
                    oc new-app sonarqube -l ${GRP}
                    oc expose service/sonarqube
		'''
            }
        }
	    
   
	    
    }
}
