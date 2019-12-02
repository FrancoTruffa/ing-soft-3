node {
   def mvnHome
   def image
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/FrancoTruffa/ing-soft-3.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'M3'
   }
stage('Build') {
      withEnv(["MVN_HOME=$mvnHome"]) {
        sh 'cd payroll/server && "$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
		image = docker.build("francotruffa1/pipeline")
      }
   }

// stage('SonarCloud'){
//   withEnv(["MVN_HOME=$mvnHome"]){
//   sh 'cd payroll/server && "$MVN_HOME/bin/mvn" verify sonar:sonar \
//   -Dsonar.projectKey=FrancoTruffa_ing-soft-3 \
//   -Dsonar.organization=francotruffa \
//   -Dsonar.host.url=https://sonarcloud.io \
//   -Dsonar.login=8a7625c7b1e1722f308b5b9f322d2369fa42f0b7 \
//   -Dmaven.test.failure.ignore=true'
//   }

  
// }

stage('Pusheando Imagen a Docker') {
    docker.withRegistry('', 'dockerhub'){
        image.push()
    }
}

stage('Pusheando Imagen a Heroku'){
    withCredentials([usernamePassword(credentialsId: 'herokuCredentials', passwordVariable: 'password',
      usernameVariable: 'user')]){
     sh 'docker login --username=_ --password=f3b486da-ea13-48df-a818-247d92b2de70 registry.heroku.com'
     sh 'docker tag francotruffa1/pipeline registry.heroku.com/hidden-hamlet-79766/web'
     sh 'docker push registry.heroku.com/hidden-hamlet-79766/web'
     sh 'heroku container:release web --app=hidden-hamlet-79766'
      }
}

}