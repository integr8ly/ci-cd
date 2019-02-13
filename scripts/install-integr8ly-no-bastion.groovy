
node("staging") {
        deleteDir()
        stage('Checkout SCM'){
          dir('.') {
                git branch: "${BRANCH}", url: "https://github.com/${OWNER}/installation.git"
          } 
        }
        
        stage('Install'){
            sh '''
                sed -i 's/rhsso_seed_users_count: 50/rhsso_seed_users_count: 2/g' roles/rhsso/defaults/main.yml
                cat inventories/hosts
                
                sudo ansible-playbook -i inventories/hosts playbooks/install.yml -e github_client_id=${GH_CLIENT_ID} -e github_client_secret=${GH_CLIENT_SECRET}"  
            '''
        }
}
