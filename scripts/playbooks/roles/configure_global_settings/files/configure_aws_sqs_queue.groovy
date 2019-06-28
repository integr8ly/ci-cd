import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import io.relution.jenkins.awssqs.SQSTrigger
import org.kohsuke.stapler.StaplerRequest
import org.kohsuke.stapler.Stapler
import net.sf.json.JSONObject
import java.util.UUID

def instance = Jenkins.getInstance()
def sqs = instance.getDescriptor(SQSTrigger.class)

StaplerRequest req = Stapler.getCurrentRequest();
JSONObject json = new JSONObject()
def sqsQueues = new JsonSlurper().parseText('${sqs_queues}')

sqsQueues.each { sqsQueue ->
  String uuid = UUID.randomUUID().toString()  
  sqsQueue.uuid = uuid
}
json.accumulate("sqsQueues", sqsQueues)

sqs.configure(req, json)
instance.save()