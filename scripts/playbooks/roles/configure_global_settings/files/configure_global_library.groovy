import jenkins.plugins.git.GitSCMSource
import jenkins.plugins.git.traits.BranchDiscoveryTrait
import jenkins.plugins.git.traits.RefSpecsSCMSourceTrait
import jenkins.plugins.git.traits.RefSpecsSCMSourceTrait.RefSpecTemplate
import org.jenkinsci.plugins.workflow.libs.GlobalLibraries
import org.jenkinsci.plugins.workflow.libs.LibraryConfiguration
import org.jenkinsci.plugins.workflow.libs.SCMSourceRetriever

def libraryName = "${library_name}"
def gitUrl = "${gitUrl}"
def loadImplicit = "${load_implicit}".toBoolean()
def sshCredentialsId = "jenkinsgithub"
def version = "${default_version}"

def instance = Jenkins.getInstance()
def descriptor = instance.getDescriptor(GlobalLibraries.class)

def templates = [new RefSpecTemplate("+refs/heads/*:refs/remotes/@{remote}/*"), new RefSpecTemplate("+refs/pull/*/head:refs/remotes/@{remote}/pr/*")]
List sourceTraits = []
sourceTraits.add(new BranchDiscoveryTrait())
sourceTraits.add(new RefSpecsSCMSourceTrait(templates))

GitSCMSource source = new GitSCMSource(gitUrl)
source.setCredentialsId(sshCredentialsId)
source.setTraits(sourceTraits)

LibraryConfiguration library = new LibraryConfiguration(libraryName, new SCMSourceRetriever(source))
library.setDefaultVersion(version)
library.setImplicit(loadImplicit)
descriptor.get().setLibraries([library])




