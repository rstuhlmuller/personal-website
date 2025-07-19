---
layout: post
title: Reworking my Personal Site
date: 2025-07-18 21:30 -0700
categories: [Personal Site]
tags: [jekyll, aws, webdev, static sites]
author: rodman
---

I've been tinkering with my personal site again, and I decided to switch things up. I moved it from a Vue.js setup to Jekyll, purely because I'm leaning into the joys of a fully static site these days.

### Why the Change?
Vue was great for interactivity, but for a simple personal portfolio/blog, it felt like overkill. Jekyll lets me generate static HTML/CSS/JS files from Markdown, which means:

- **Faster load times**: No dynamic rendering on the fly.
- **Easier maintenance**: Just write in Markdown, build, and deploy.
- **No server-side worries**: Pure static goodness—lightweight and secure.

It's all about that minimalist vibe: write, build, deploy, done!

### How It Went Down
The migration was straightforward:
1. Ported my content to Jekyll's templates.
2. Added plugins for SEO, RSS feeds, and syntax highlighting.
3. Built the site locally and tested.

Done! I'm still hosting it on **AWS CloudFront** in my personal account for reliable, edge-cached delivery worldwide. No big infrastructure changes, just a cleaner, more efficient stack.

If you're thinking about static sites, Jekyll (or alternatives like Hugo or Antora) is definitely worth a look. It's empowered me to focus more on content than code overhead.