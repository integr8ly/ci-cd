
  node("staging") {
        deleteDir()
        stage('Checkout SCM'){
          dir('.') {
            git branch: "${BRANCH}", url: "https://github.com/${OWNER}/installation.git"
            if(!fileExists("evals")) {
              sh "ln -s . evals"
            }
          } 
        }
        
        stage('Uninstall'){
            dir('evals'){
              sh 'sudo ansible-playbook -i inventories/hosts playbooks/uninstall.yml'   
            }
        }
}
