+++
title = "Run Downloaded Website Offline - Local Display Guide"
date = "2026-03-18T16:06:40+01:00"
draft = false
description = "Learn how to display a wget-downloaded website offline. Open saved HTML files in browser for offline viewing."
summary = "Guide to running and displaying websites downloaded with wget for offline viewing. Covers directory structure, local server options, and browser viewing."
slug = "run-website-offline-linux"
categories = ["Linux", "Web Development"]
tags = ["wget", "offline", "website", "local-server", "web"]
keywords = ["wget website offline", "view downloaded site", "local website", "offline browsing"]
+++


When you use **`wget`** to download a website for offline viewing, you'll need to open the saved files in a web browser. Here’s how to properly display the downloaded website:

---

### **Steps to Display the Downloaded Website Offline**
1. **Run `wget` to Download the Site**  
   Use a command like this to mirror the website:
   ```bash
   wget --mirror --convert-links --adjust-extension --page-requisites --no-parent https://example.com
   ```
   - This saves all files (HTML, CSS, JS, images) in a folder named `example.com`.

2. **Navigate to the Downloaded Folder**  
   - Open the folder where `wget` saved the files (e.g., `example.com`).
   - Look for the **main `index.html`** (or similar entry file).

3. **Open the Website in a Browser**  
   - Double-click the `index.html` file (or drag it into a browser).
   - Alternatively, use:
     ```bash
     # On Linux/Mac (replace with your browser if needed)
     firefox example.com/index.html
     ```
     ```bash
     # On Windows (via Command Prompt)
     start chrome "example.com\index.html"
     ```

4. **Verify Offline Functionality**  
   - Disable your internet connection.
   - Refresh the page—it should load without errors.

---

### **Fixing Common Issues**
- **Broken Links?**  
  `--convert-links` in `wget` should fix most internal links, but some JavaScript-based sites may still fail.
  
- **Missing Resources?**  
  Ensure `--page-requisites` was used. If assets are missing, manually check the folder structure.

- **Dynamic Sites (PHP/API Calls)?**  
  These won’t work offline—only static sites can be fully mirrored.

---

### **Alternative: Run a Local Server (For Better Compatibility)**
If links still don’t work, serve the folder via a local web server:
- **Python (Quick Server)**:
  ```bash
  python3 -m http.server 8000
  ```
  Then open `http://localhost:8000/example.com` in your browser.

- **Node.js (`http-server`)**:
  ```bash
  npx http-server ./example.com
  ```

This avoids browser security restrictions on local file access.

---

### **Summary**
- Use `wget` with `--mirror` and `--convert-links` for best results.
- Open the saved `index.html` in a browser.
- For complex sites, run a local server (`python -m http.server`).

