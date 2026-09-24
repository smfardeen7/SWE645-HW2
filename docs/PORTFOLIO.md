# Container Delivery Pipeline — implementation guide

Configured a Jenkins delivery pipeline that checks out a static student-survey site, packages a WAR, builds a Tomcat Docker image, pushes it to Docker Hub and applies Kubernetes manifests. The deployment declares three replicas and a LoadBalancer service. Source includes Docker, Jenkins and Kubernetes configuration plus coursework setup guides. The current Jenkinsfile does not contain an automated test stage, and this portfolio update does not verify an active AWS/Rancher deployment.

![Source-derived architecture for Container Delivery Pipeline](images/project-overview.png)

The graphic describes the checked-in implementation. It is an architecture diagram, not a screenshot, a benchmark result or evidence of a live production deployment.

## Source map

- **GitHub + Jenkins:** Clone main and package WebContent as a WAR. See [Jenkinsfile](../Jenkinsfile).
- **Tomcat container:** Build the Docker image containing StudentSurvey.war. See [Dockerfile](../Dockerfile).
- **Docker Hub:** Push with a Jenkins-managed registry credential. See [deployment.yaml](../deployment.yaml).
- **Kubernetes:** Apply a 3-replica Deployment and LoadBalancer Service. See [service.yaml](../service.yaml).

## Scope

Diagram reflects pipeline configuration. The Jenkinsfile has no automated test stage; active AWS/Rancher deployment was not verified.

This presentation was checked against source revision `fddabb825ea14f5c35d2b34ab88d4e0c3249af2c` on September 24, 2026. The documentation update does not claim a new application test run, cloud deployment or performance measurement.
