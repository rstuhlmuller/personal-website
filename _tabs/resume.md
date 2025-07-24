---
icon: fas fa-file-text
order: 5
---

<div class="resume-container">
  <div class="resume-header">
    <a href="/assets/lib/Resume_Rodman_Stuhlmuller_2025.pdf" class="download-button" target="_blank">
      <i class="fas fa-download"></i> Download PDF
    </a>
  </div>

  <div class="resume-embed">
    <iframe src="/assets/lib/Resume_Rodman_Stuhlmuller_2025.pdf" width="100%" height="800px" style="border: none; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border-radius: 4px;"></iframe>
  </div>

  <div class="resume-fallback">
    <p>If the resume is not displaying properly above, you can <a href="/assets/lib/Resume_Rodman_Stuhlmuller_2025.pdf" target="_blank">view it directly</a> or download it using the button above.</p>
  </div>
</div>

<style>
.resume-container {
  max-width: 100%;
  margin: 20px 0;
}

.resume-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.resume-header h1 {
  margin: 0;
  font-size: 1.8rem;
}

.download-button {
  display: inline-block;
  padding: 10px 15px;
  background-color: var(--link-color, #2a408e);
  color: white;
  text-decoration: none;
  border-radius: 4px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.download-button:hover {
  background-color: var(--link-hover-color, #1e3276);
  text-decoration: none;
  color: white;
}

.resume-embed {
  margin-bottom: 20px;
}

.resume-fallback {
  text-align: center;
  font-style: italic;
  color: #666;
}

@media (max-width: 768px) {
  .resume-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 15px;
  }
  
  .resume-embed iframe {
    height: 500px;
  }
}
</style>