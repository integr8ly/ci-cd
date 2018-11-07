timeout(60) {
    node('cirhos_rhel7') {  
        stage('Clone the testsuite') {
            dir('integreatly-qe') {
                    git branch: BRANCH, url: REPOSITORY
            } 
        }
        
        docker.image('selenium/standalone-chrome:3.14.0-krypton').withRun('--name chrome_selenium -d -p 4444:4444 -v /dev/shm:/dev/shm -v "$PWD":"$PWD" -e SE_OPTS="-timeout 3600"') { c ->
            stage('Test') {
                dir('integreatly-qe/js-testsuite') {
                    sh """
                      # Disable starting Selenium, Docker is used instead
                      sed -i 's/"start_process" : true,/"start_process" : false,/g' nightwatch.json
                      npm install
                      npm test
                    """
                } 
            }
        }
    }
}