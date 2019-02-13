
  node("staging") {
        deleteDir()
        stage('Checkout SCM'){
          dir('.') {
                git branch: "${BRANCH}", url: "https://github.com/${OWNER}/installation.git"
          } 
        }
        
        stage('Uninstall'){
            dir('.'){
              sh 'sudo ansible-playbook -i inventories/hosts playbooks/uninstall.yml'   
            }
        }
}
