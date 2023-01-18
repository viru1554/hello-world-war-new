pipeline{
    agent any
    environment {
        PATH = "$PATH:/usr/share/maven/bin"
    }
    stages{
       stage('GetCode'){
            steps{
                git 'https://github.com/viru1554/java-login-app.git'
            }
         }
       stage('mvn clean install'){
            steps{
                sh 'mvn clean install'
            }
       }
       stage('mvn clean package'){
            steps{
                sh 'mvn clean package'
            }
       }
       stage('mvn test'){
           steps{
               sh 'mvn test'
           }
       }
       stage('SonarQube analysis') {
            steps{
                withSonarQubeEnv('sonarqube-8.3') { 
                sh ''' mvn verify sonar:sonar -Dsonar.login=admin -Dsonar.password=admin'''
                }
                
            }
        }
       
    }
}
