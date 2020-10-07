pipeline {
//  agent any
 agent {
    kubernetes {
      //label 'maven'  // all your pods will be named with this prefix, followed by a unique id
      idleMinutes 5  // how long the pod will live after no jobs have run on it
      yamlFile 'build-agent-pod.yaml'  // path to the pod definition relative to the root of our project 
      defaultContainer 'maven'  // define a default container if more than a few stages use it, will default to jnlp container
    }
  }  
  
	stages {
		stage('UnitTests & Coverage') {
			steps {
                                // Execute Batch script if OS flavor is Windows		
                                sh 'mvn cobertura:cobertura'
                                // Publish JUnit Report
                                junit '**/target/surefire-reports/TEST-*.xml'
                                cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/target/site/cobertura/*.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII'
			}		
		}
		    stage('Static Code Analysis') {

      steps {
        
        sh 'wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip'
        sh 'unzip sonar-scanner-cli-3.3.0.1492-linux.zip'
        withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'SonarToken') {
          sh 'ls -l'
          sh 'sonar-scanner-3.3.0.1492-linux/bin/sonar-scanner -Dsonar.projectVersion=1.0 -Dsonar.projectKey=sample-springboot-app -Dsonar.java.binaries=. -Dsonar.sources=src/test,src/main/java/org/springframework/samples/petclinic,src/main/webapp/resources,src/main/webapp/WEB-INF/jsp,src/main/webapp/WEB-INF/tags'
        }
waitForQualityGate(abortPipeline: true, credentialsId: 'SonarToken')
        
      }
    }
    
        stage('Build') {
      steps {
        sh 'mvn clean package -Dmaven.test.skip=true'
        archiveArtifacts(artifacts: '**/*.war', onlyIfSuccessful: true, fingerprint: true)
      }
    }
	}
}
