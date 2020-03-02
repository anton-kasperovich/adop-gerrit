FROM openfrontier/gerrit:2.10.x

# Environment variables
ENV GERRIT_USERNAME gerrit
ENV GERRIT_PASSWORD gerrit
ENV JENKINS_USERNAME jenkins
ENV JENKINS_PASSWORD jenkins

# Override entrypoint script
USER root
COPY resources/gerrit-entrypoint.sh ${GERRIT_HOME}/
RUN chmod +x ${GERRIT_HOME}/gerrit*.sh

# Add libraries
COPY resources/lib/mysql-connector-java-5.1.21.jar ${GERRIT_HOME}/site_ext/lib/mysql-connector-java-5.1.21.jar

# Add utility scripts
COPY resources/scripts/ ${GERRIT_HOME}/adop_scripts/
RUN chmod -R +x ${GERRIT_HOME}/adop_scripts/
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.4/jq-linux-x86_64 -O /usr/local/bin/jq && chmod -R +x /usr/local/bin && chmod -R +x ${GERRIT_HOME}/adop_scripts/

# Add site content
COPY resources/site/ ${GERRIT_HOME}/site_ext/

USER $GERRIT_USER
