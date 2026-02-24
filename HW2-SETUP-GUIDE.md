# SWE645 HW2 – Setup & Submission Guide

Use this with the assignment PDF and the example setup PDF. **Replace every placeholder** before use.

---

## Placeholder to Replace

| Placeholder | Replace with |
|-------------|--------------|
| *(Already set)* | Docker Hub username is **mfardeenshaik** in deployment.yaml and Jenkinsfile. |
| `StudentSurvey` | Your app context path if different (in Dockerfile, URLs, and docs) |

**Note:** Kubernetes namespace is set to `default` in the Jenkinsfile. If you use a different namespace in Rancher, change `-n default` to `-n <your-namespace>` in the Jenkinsfile.

---

## Step 1: Push HW1 to GitHub

1. Create a **new empty** repo on GitHub.
2. Put all HW1 source (and these HW2 files) in one folder:
   - Java/HTML/CSS/JS from HW1
   - Eclipse structure: e.g. `WebContent/`, `src/`, `Dockerfile`, `Jenkinsfile`, `deployment.yaml`, `service.yaml`
3. From that folder (or use the one-time commands in **PUSH-TO-GITHUB.md**):
   ```bash
   git init
   git remote add origin https://github.com/<your-username>/<repo-name>.git
   git add .
   git commit -m "HW1 + HW2 config"
   git push -u origin main
   ```
4. Ensure **Dockerfile**, **Jenkinsfile**, **deployment.yaml**, and **service.yaml** are in the **repo root**.

---

## Step 2: Dockerize the App

1. In Eclipse: Right‑click project → **Export → WAR file** → save as `StudentSurvey.war` in the **same folder as the Dockerfile** (repo root).
2. Image is set to **mfardeenshaik/studentsurvey645** in deployment.yaml and Jenkinsfile.
3. Build and test:
   ```bash
   docker build --tag studentsurvey645:0.1 .
   docker run -it -p 8182:8080 studentsurvey645:0.1
   ```
   Open: http://localhost:8182/StudentSurvey
4. Push to Docker Hub:
   ```bash
   docker login -u mfardeenshaik
   docker tag studentsurvey645:0.1 mfardeenshaik/studentsurvey645:0.1
   docker push mfardeenshaik/studentsurvey645:0.1
   ```
   Confirm the image appears on https://hub.docker.com

---

## Step 3: AWS EC2 for Rancher

- **AMI:** Ubuntu Server 20.04 LTS  
- **Type:** t2.medium (or t3.medium)  
- **Inbound rules:** 22 (SSH), 80 (HTTP), 443 (HTTPS) to `0.0.0.0/0`  
- Save the `.pem` key, then:
  ```bash
  chmod 400 yourkey.pem
  ssh -i yourkey.pem ubuntu@<PUBLIC-IP>
  ```
- On the instance:
  ```bash
  sudo apt-get update
  sudo apt install docker.io
  docker -v
  sudo docker run --privileged=true -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
  ```
- After ~1 min, open https://\<EC2-PUBLIC-DNS\>, accept warnings, set admin password.

---

## Step 4: Kubernetes Cluster in Rancher

- Rancher → **Add Cluster** → **Amazon EC2**.
- Create an IAM user with **Programmatic access** and **AdministratorAccess**, save Access Key and Secret Key.
- In Rancher: add keys, region **us-east-1**, create node template (e.g. t3.medium, Rancher AMI), set IAM instance profile.
- Create cluster (e.g. 1 node for etcd/control plane, rest as workers). Wait until nodes are healthy.

---

## Step 5: Deploy to Kubernetes (3 Pods + Load Balancer)

1. In **deployment.yaml**, `image` is set to `mfardeenshaik/studentsurvey645:0.1`.
2. If you use a custom namespace (not `default`), use `-n <your-namespace>` in `kubectl` commands and in the Jenkinsfile Deploy stage.
3. Apply (from directory containing the YAML files):
   ```bash
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl get pods
   ```
   You should see **3 running** pods.
4. Get the Load Balancer URL:
   ```bash
   kubectl get svc student-survey-lb
   ```
   Open **http://\<EXTERNAL-IP\>/StudentSurvey** (or https if you use an ingress).

---

## Step 6: Jenkins EC2

- New Ubuntu EC2 (e.g. t2.medium), ports 22, 80, 8080 open.
- SSH in and run:
  ```bash
  sudo apt-get update
  sudo apt install docker.io openjdk-11-jdk
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt update && sudo apt install jenkins
  sudo apt install snapd && sudo snap install kubectl --classic
  systemctl status jenkins
  ```
- Open http://\<JENKINS-IP\>:8080, unlock with password from `/var/lib/jenkins/secrets/initialAdminPassword`, install suggested plugins.

---

## Step 7: Jenkins ↔ Kubernetes

- In Rancher: cluster → **Kubeconfig File** → copy contents.
- On Jenkins server:
  ```bash
  sudo su jenkins
  mkdir -p ~/.kube
  nano ~/.kube/config   # paste kubeconfig
  exit
  ```
- Verify (as user that runs Jenkins):
  ```bash
  kubectl config current-context
  ```
  Should show your cluster name.

---

## Step 8: Jenkins Pipeline and Jenkinsfile

1. **Jenkins:** Manage Jenkins → Credentials → add **Secret text** credential with ID `docker-pass` (your Docker Hub password).
2. **Plugins:** Install **Docker Pipeline**. (The Jenkinsfile uses a pipeline-defined `BUILD_TAG`; no Build Timestamp plugin is required.)
3. **Pipeline job:** New Item → Pipeline.  
   - **Build Triggers:** Poll SCM, schedule `* * * * *` (every minute).  
   - **Pipeline:** “Pipeline script from SCM” → Git → repo URL + credentials.  
   - **Script Path:** `Jenkinsfile`.
4. **Jenkinsfile** uses Docker Hub user **mfardeenshaik** and namespace **default**; change `-n default` if you use another namespace.
5. Commit and push the Jenkinsfile. The pipeline expects:
   - Repo root = directory with `WebContent/` and `Jenkinsfile`
   - `jar -cvf StudentSurvey.war -C WebContent/ .` to build the WAR

---

## Step 9: Test the Pipeline

1. Make a small change (e.g. in HTML), commit, push to GitHub.
2. Within about a minute Jenkins should run the pipeline (Build Image → Push to DockerHub → Deploy to Kubernetes).
3. In Rancher, confirm deployment image tag matches the build timestamp.
4. Open the load balancer URL + `/StudentSurvey` and confirm the app is live.

---

## What to Submit (Zipped)

- [ ] Source code (HTML/CSS/JS/Java from HW1)
- [ ] **Dockerfile**
- [ ] **Jenkinsfile**
- [ ] **deployment.yaml** + **service.yaml**
- [ ] Documentation PDF (what you built, how it works, setup, CI/CD, K8s)
- [ ] Video with voice-over: setup, `kubectl` deployment, pipeline run, live app with cloud URL

---

## File Layout (Suggested)

```
<repo-root>/
  Dockerfile
  Jenkinsfile
  deployment.yaml
  service.yaml
  StudentSurvey.war          # built locally / by Jenkins; often in .gitignore
  WebContent/               # from Eclipse HW1
    index.html
    ...
  src/                      # Java source from HW1
  ...
```

Ensure your name (or group names) and 1–2 sentence “purpose” comments are in source and config files as required by the assignment.
