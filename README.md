# Gaurav's Website

Custom personal website developed by **Pranjal**.

## First Time Setup (New Computer)

1. Right-click `START.bat` → **Run as Administrator**
2. Wait for it to install dependencies and start the server
3. Open http://localhost:1313 in your browser

That's it! The script installs everything automatically.

## Quick Start (After Setup)

Just double-click `RUN.bat` to start the website locally.

## Folder Structure

```
📁 gaurav-website/
├── 📄 START.bat          ← First-time setup (Run as Admin)
├── 📄 RUN.bat            ← Quick start server
├── 📄 setup.ps1          ← PowerShell setup script
├── 📄 config.toml        ← Site config (edit this!)
├── 📁 content/           ← Your content (Markdown files)
│   ├── 📄 about.md       ← About page
│   ├── 📁 posts/         ← Blog posts
│   └── 📁 projects/      ← Project pages
├── 📁 static/            ← Static files (images, etc.)
│   └── 📁 images/        ← Put your avatar & images here
├── 📁 assets/css/        ← Custom CSS
└── 📁 themes/            ← Theme files (Vanta.js bg is here)
```

## How to Edit

### Change Your Info
Edit `config.toml`:
- `title` - Site title
- `[params]` section - Your name, description, etc.
- `[[params.social]]` - Your social links
- `[[menu.main]]` - Navigation menu

### Add a Blog Post
Create a new file in `content/posts/`:
```markdown
+++
title = "Post Title"
date = "2026-02-07"
tags = ["tag1", "tag2"]
+++

Your content here...
```

### Add Your Avatar
1. Put your image in `static/images/avatar.jpg`
2. That's it! (already configured in config.toml)

### Add Images to Posts
1. Put images in `static/images/`
2. Reference in markdown: `![Alt](/images/filename.jpg)`

## Deploy

Run the build command and upload the `public/` folder to your hosting provider.

---
*Developed by Pranjal*
