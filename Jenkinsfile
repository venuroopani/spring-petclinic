pipeline {

 agent {
    kubernetes {
      //label 'maven'  // all your pods will be named with this prefix, followed by a unique id
      idleMinutes 5  // how long the pod will live after no jobs have run on it
      yamlFile 'build-agent-pod.yaml'  // path to the pod definition relative to the root of our project 
      defaultContainer 'maven'  // define a default container if more than a few stages use it, will default to jnlp container
    }
  }
	
	stages {
		stage('Build') {
			steps {
                                // Execute Batch script if OS flavor is Windows		
                                sh 'mvn cobertura:cobertura'
                                // Publish JUnit Report
                                junit '**/target/surefire-reports/TEST-*.xml'
                                cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/target/site/cobertura/*.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII'
			}		
		}
	}
}
