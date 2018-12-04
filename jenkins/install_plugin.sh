#! /bin/sh

kubectl exec jenkins-0 /usr/local/bin/install-plugins.sh \
kubernetes blueocean workflow-job workflow-aggregator credentials-binding git

kubectl exec -it  jenkins-0 -- /bin/bash -c "cp -r /usr/share/jenkins/ref/plugins/* /var/jenkins_home/plugins"

kubectl exec jenkins-0 cat /var/jenkins_home/secrets/initialAdminPassword

echo "please use $'kubectl delete pod jenkins-0' to reload pod"
