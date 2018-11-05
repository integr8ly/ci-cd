node('cirhos_rhel7'){
        stage('Clone QE repository') {
            dir('.') {
                git branch: "${BRANCH}", url: "${REPOSITORY}"
            }
        }
        stage('Run the smoke tests'){
            dir('node-testsuite'){
                sh '''
                    npm install
                '''
                try {
                    sh '''
                        gulp smoke
                    '''
                } catch(exp) {
                    currentBuild.result = 'UNSTABLE'
                }
            }
        }
}