pipeline {

	agent {
                dockerfile true
	}
	
	stages {
		stage('Build') {
			steps {
                                // Execute Batch script if OS flavor is Windows		
                                sh 'mvn clean package'
                                // Publish JUnit Report
                                junit '**/target/surefire-reports/TEST-*.xml'	
                                archiveArtifacts(artifacts: 'target/**/*.war', onlyIfSuccessful: true, fingerprint: true)
			}		
		}
	}
}
