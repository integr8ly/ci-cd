
node("${NODE}") {
        deleteDir()
        stage('Checkout'){
            checkout scm: [
                $class: "GitSCM", 
                branches:[
                   [ name: "${BRANCH}" ]
                ],
                userRemoteConfigs: [
                   [   
                     name: "origin", 
                     refspec: "+refs/heads/*:refs/remotes/origin/*",
                     url: "https://github.com/${OWNER}/installation.git" ]
                   ]
                ]
        }
        
        stage('Install'){
            sh '''
                sed -i 's/rhsso_seed_users_count: 50/rhsso_seed_users_count: 2/g' evals/roles/rhsso/defaults/main.yml
                cat evals/inventories/hosts
                cd evals
                sudo ansible-playbook -i inventories/hosts playbooks/install.yml -e github_client_id=${GH_CLIENT_ID} -e github_client_secret=${GH_CLIENT_SECRET}
            '''
        }
}
