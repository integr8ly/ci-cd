import groovy.json.JsonSlurper
import org.jenkinsci.plugins.ansible_tower.AnsibleTowerGlobalConfig
import org.jenkinsci.plugins.ansible_tower.util.TowerInstallation

def instance = Jenkins.getInstance()
def tower = instance.getDescriptor(AnsibleTowerGlobalConfig.class)

def towerInstallations = new JsonSlurper().parseText('${tower_installations}')

List ansibleTowerInstallations = []
towerInstallations.each{ towerInstallation ->
  ansibleTowerInstallations.add(new TowerInstallation(towerInstallation.display_name, towerInstallation.url, towerInstallation.credentials_id, towerInstallation.trust_cert, towerInstallation.enable_debugging))
}

tower.setTowerInstallation(ansibleTowerInstallations)
instance.save()



