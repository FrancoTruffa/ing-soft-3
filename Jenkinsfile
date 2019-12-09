node {
   def mvnHome
   def image
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/FrancoTruffa/ing-soft-3.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'M3' //mi definicion del instalador de maven en jenkins
   }
stage('Build') { //aca buildeamos la aplicacion y despues generamos la imagen, buildea el proyecto 
      withEnv(["MVN_HOME=$mvnHome"]) {
        sh 'cd payroll/server && "$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
		image = docker.build("francotruffa1/pipeline") // generamos una imagen de docker, pero aun no esta pusheada
      }
   }

stage('SonarCloud'){
  withEnv(["MVN_HOME=$mvnHome"]){
  sh 'cd payroll/server && "$MVN_HOME/bin/mvn" verify sonar:sonar \
  -Dsonar.projectKey=FrancoTruffa_ing-soft-3 \
  -Dsonar.organization=francotruffa \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.login=8a7625c7b1e1722f308b5b9f322d2369fa42f0b7 \
  -Dmaven.test.failure.ignore=true'
  }
} 

stage('Pusheando Imagen a Docker') {
    docker.withRegistry('', 'dockerhub'){
        image.push() //aca usamos la variable que definimos en el build
    }
}

stage('Pusheando Imagen a Heroku'){ //necesitamos que la app este corriendo en algun lado para poder hacer los test de integracion
    withCredentials([usernamePassword(credentialsId: 'herokuCredentials', passwordVariable: 'password',
    usernameVariable: 'user')]){
     sh 'docker login --username=_ --password=${password} registry.heroku.com'
     sh 'docker tag francotruffa1/pipeline registry.heroku.com/hidden-hamlet-79766/web'
     sh 'docker push registry.heroku.com/hidden-hamlet-79766/web'
     sh 'heroku container:release web --app=hidden-hamlet-79766'
    }
}

//otro push

stage('Integration test'){ 
      sleep 60 //por ahi publica pero no termina de correr heroku y cuando corren los test de integracion no encuentra la app prendida. cuando buscaba los logs, no se terminaba de correr la app en heroku, mandaba deploy y madnabaa a heroku y nunca dejaba de estar sleep, pero era porque no se levantaba en heroku
      sh 'cd payroll/server/src/test/java/payroll-test && npx codeceptjs run --steps --reporter mocha-multi'
   }


stage('Results') {
      archiveArtifacts 'payroll/server/target/*.jar'
      archiveArtifacts 'payroll/server/src/test/java/payroll-test/output/result.xml'
      junit '**/target/surefire-reports/TEST-*.xml'
      archiveArtifacts 'payroll/server/target/surefire-reports/*.xml'

   }

}