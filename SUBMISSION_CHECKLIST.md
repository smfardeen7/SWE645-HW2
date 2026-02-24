# SWE645 HW2 – What to Submit

Submit **one zipped package** to Canvas containing the items below.

---

## 1. Zipped package contents

### Source code
- All HW1 source: `WebContent/` (HTML, CSS, JS, images, etc.)
- `WebContent/WEB-INF/web.xml`
- Any Java source if you add it later (`src/`)

### Configuration files (must be in the zip)
- **Dockerfile**
- **Jenkinsfile**
- **deployment.yaml**
- **service.yaml**
- Any other scripts or config you used

**Tip:** You can create the zip from your project folder so the root of the zip is the repo root (same as [github.com/smfardeen7/645-hw2](https://github.com/smfardeen7/645-hw2)).

---

## 2. Documentation (PDF or Word)

Include a **separate** documentation file that explains:
- What you built
- How it works
- Installation and setup instructions
- CI/CD pipeline details
- Kubernetes deployment details  

*(You can base it on **HW2-SETUP-GUIDE.md** and expand with your actual setup, URLs, and screenshots.)*

---

## 3. Video (with voice-over)

Record a video that shows:
- The setup process
- Deployment on the K8s cluster using **kubectl**
- The CI/CD pipeline running in Jenkins
- The running application on Kubernetes
- The **AWS (or cloud) URL** of the deployed app

The video should be detailed enough for the TA/instructor to follow and replicate.

---

## Quick zip from terminal

From the project folder (e.g. Desktop):

```bash
cd "/Users/shaikmohammadfardeen/Desktop"
zip -r SWE645-HW2-Submission.zip "645 hw2" -x "645 hw2/.git/*" -x "645 hw2/__MACOSX/*"
```

Then add your **documentation PDF** and **video file** to the zip, or submit them separately if Canvas has separate slots for doc and video.

---

## Assignment notes (from PDF)

- Your name (or all group members’ names) on all artifacts
- 1–2 sentence “purpose” comments at the top of each source/config file
- Late: 10% per week; not accepted after 2 weeks late
