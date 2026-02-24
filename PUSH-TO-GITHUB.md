# Push This Project to GitHub

Do this once to push your code. (Docker Hub username is already set to **mfardeenshaik** in the repo.)

## 1. Create a new repo on GitHub

- Go to [https://github.com/new](https://github.com/new)
- Repository name: e.g. `swe645-hw2` or `student-survey`
- Leave it **empty** (no README, no .gitignore)
- Create repository

## 2. Run these in the project folder (645 hw2)

Run from the project folder. Repo: **https://github.com/smfardeen7/645-hw2**

```bash
cd "/Users/shaikmohammadfardeen/Desktop/645 hw2"

git remote add origin https://github.com/smfardeen7/645-hw2.git
git push -u origin main
```

If the repo already has a remote, update and push:

```bash
git remote set-url origin https://github.com/smfardeen7/645-hw2.git
git push -u origin main
```

## 3. Use this repo in Jenkins

- In Jenkins pipeline config, set **Repository URL** to:  
  `https://github.com/smfardeen7/645-hw2`
- Script Path: `Jenkinsfile`
