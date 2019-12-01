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