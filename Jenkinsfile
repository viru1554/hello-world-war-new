pipeline {
    agent {
        label "slave1"
    }
    stages {
        stage('tomcat installation') {
            steps {
                sh 'rm -rf hello-world-war-new'
                sh 'git clone https://github.com/venkibiligere/hello-world-war-new.git'
                sh 'chmod 755 ${WORKSPACE}/hello-world-war-new/tomcatscript'
                sh '${WORKSPACE}/hello-world-war-new/tomcatscript'

            }
        }
        stage('Build') {
            steps {
                dir('hello-world-war-new'){
                sh 'mvn package'
                }    
            }
        }
        stage('Deploy step') {
             steps {
                 sh 'sudo cp ${WORKSPACE}/target/hello-world-war-new-1.0.0.war /var/lib/tomcat9/webapps'       
            }
        }
    }
}
