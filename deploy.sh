#!/usr/bin/env bash
set -ex

function cleanup(){
    rm -rf ${tomcatLocation}'/webapps/'${warName}
    rm -rf ${tomcatLocation}'/work/Catalina/localhost/'${warName}
    rm -rf ${tomcatLocation}'/temp'
}

function stopTomcat(){
    service tomcat stop
}

function deployArtefacts(){

    URLS[0]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=war'
    URLS[1]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=struts-test'
    URLS[2]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=log4j-test'
    URLS[3]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=hibernate-test&r=snapshots'
    URLS[4]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=c3p0-test&r=snapshots'
    URLS[5]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=B-override_runtime-test'
    URLS[6]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=B-override-test'
    URLS[7]=${nexusRestApiURL}'?g='${groupId}'&a='${artefactId}'&v='${version}'&r='${repository}'&p=properties.properties&c=application-test'

    LOCATIONS[0]=${tomcatLocation}'/B-esb.war'
    LOCATIONS[1]=${tomcatLocation}'/lib/struts.properties'
    LOCATIONS[2]=${tomcatLocation}'/lib/log4j.properties'
    LOCATIONS[3]=${tomcatLocation}'/lib/hibernate.properties'
    LOCATIONS[4]=${tomcatLocation}'/lib/c3p0.properties'
    LOCATIONS[5]=${tomcatLocation}'/lib/B-override_runtime.properties'
    LOCATIONS[6]=${tomcatLocation}'/lib/B-override.properties'
    LOCATIONS[7]=${tomcatLocation}'/lib/application.properties'

    count=0
    for i in "${URLS[@]}"
    do
       :
        STATUSCODE=$(curl --silent --write-out '%{http_code}\n' -v -o ${LOCATIONS["$count"]} -u ${nexusUsername}:${nexusPassword} ${i})

        if test ${STATUSCODE} -ne 200; then
                echo 'Wrong http status code on dowloading '${i}
                exit 1
        fi
        ((count+=1))

    done
}

function changeOwnerToTomcat(){
    chown -R tomcat:tomcat /opt/tomcat
}

# TODO: for the new tomcat box make this NOT to use root as user, but use tomcat
function startTomcat(){
    /bin/bash /opt/tomcat/bin/startup.sh
}

nexusUsername=$1
nexusPassword=$2
version=$3

nexusRestApiURL='https://nexus.domain.com/service/local/artifact/maven/content'
tomcatLocation='/opt/tomcat'
warName='warname'
groupId='com.group.groupr'
artefactId=${warName}

if [ ${version} == *-SNAPSHOT ]; then
  repository='snapshots'
else
  repository='releases'
fi

stopTomcat

cleanup

deployArtefacts

changeOwnerToTomcat

startTomcat
