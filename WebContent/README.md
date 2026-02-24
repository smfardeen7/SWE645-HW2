# Mohammad Fardeen Shaik – Portfolio & Survey Site

Static site for SWE645 Assignment 1. The project contains three HTML pages, the supporting images, and the resume PDF served by both Amazon S3 (static website) and an EC2 instance.

## Live References
- **S3 pre-signed link (time-limited):** [index.html](https://fardeen-swe645.s3.us-east-1.amazonaws.com/index.html)
- **EC2 endpoint (persistent):** [http://54.87.152.2/](http://54.87.152.2/)

## Directory Guide
| Path | Description |
| --- | --- |
| `index.html` | Portfolio landing page with education, experience, projects, skills, certifications, gallery, and contact information. Links to the resume PDF and survey page. |
| `survey.html` | Student survey form with HTML5 validation for SWE645 Assignment 1 (Part 2). |
| `404.html` | Custom error page used by both S3 and EC2 to handle missing routes. |
| `images/img1.jpeg` | Profile image used in the gallery (`alt="Profile Photo"`). |
| `images/img2.jpeg` | Motorcycle image (`alt="Motorcycle Photo"`). |
| `images/img3.jpeg` | Portrait image (`alt="Portrait Photo"`). |
| `Mohammad Fardeen-Shaik-resume.pdf` | Resume downloaded from the CTA button in `index.html`. |

All dependencies (W3.CSS, Google Fonts, Font Awesome) are loaded via CDN, so there is no build step.

## Step-by-Step Instructions

### 1. Preview the site locally
1. Open a terminal and switch to the project folder:  
   `cd /Users/shaikmohammadfardeen/Desktop/html`
2. Start a simple HTTP server:  
   `python3 -m http.server 8080`
3. Test each page in a browser:  
   - `http://localhost:8080/` → `index.html`  
   - `http://localhost:8080/survey.html` → survey form  
   - `http://localhost:8080/404.html` → error page
4. Stop the server with `Ctrl+C` after verifying the content.

### 2. Deploy to Amazon S3 (static website hosting)
1. **Create/Select bucket** – make sure the bucket name is globally unique and enable static website hosting.
2. **Upload files** – drag the entire folder contents (three HTML files, `images/` directory, and the resume PDF) into the bucket. Preserve the folder structure so relative paths stay valid.
3. **Set permissions** – either enable public read access through a bucket policy or place the site behind CloudFront with an Origin Access Control.
4. **Configure hosting** – set `index.html` as the index document and `404.html` as the error document in the Static Website Hosting section.
5. **Obtain URL** – use the bucket website endpoint (recommended) or generate a pre-signed URL. Remember: pre-signed URLs expire, so regenerate them when sharing with instructors.
6. **Verify** – open the endpoint and confirm that the resume download and gallery images load correctly.

### 3. Deploy to an EC2 instance (Apache example)
1. **SSH into the instance:** `ssh ec2-user@54.87.152.2` (replace with the actual username/key pair).
2. **Install Apache (once):**
   ```bash
   sudo yum update -y
   sudo yum install -y httpd
   sudo systemctl enable httpd --now
   ```
3. **Copy the site:** upload `index.html`, `survey.html`, `404.html`, `images` directory, and `Mohammad Fardeen-Shaik-resume.pdf` into `/var/www/html/`. Example using `scp`:
   ```bash
   scp -r /Users/shaikmohammadfardeen/Desktop/html/* ec2-user@54.87.152.2:/var/www/html/
   ```
4. **Set ownership/permissions (if needed):**
   ```bash
   sudo chown -R apache:apache /var/www/html
   sudo chmod -R 755 /var/www/html
   ```
5. **Restart Apache:** `sudo systemctl restart httpd`
6. **Test:** visit `http://54.87.152.2/` and verify the homepage, survey form, and download link.

### 4. Confirm the live links
1. Open both the S3 link and `http://54.87.152.2/` in different tabs.
2. Check that:
   - The hero buttons navigate to the resume (`/Mohammad Fardeen-Shaik-resume.pdf`) and `survey.html`.
   - The gallery shows three photos (loaded from `/images/img1.jpeg`, `/images/img2.jpeg`, `/images/img3.jpeg`).
   - Navigating to a non-existent path (e.g., `/missing`) displays `404.html`.

## Maintenance Checklist
- Update text in `index.html` as experience/projects evolve; re-upload to both hosts afterward.
- Replace the resume or gallery images by overwriting the same filenames or updating the HTML paths.
- After any change, repeat the verification steps to confirm S3 and EC2 remain in sync.
