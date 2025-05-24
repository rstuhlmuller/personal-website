<template>
    <ContentCard title="Projects" icon="💻">
        <div class="projects-content">
            <div class="project-item">
                <h4>Infrastructure as Code Platform</h4>
                <div class="tags">
                    <span class="tag">Terraform</span>
                    <span class="tag">AWS</span>
                    <span class="tag">Python</span>
                </div>
                <p>Built a comprehensive IaC platform managing multi-account AWS infrastructure, reducing deployment
                    time by 70%.</p>
            </div>

            <div class="project-item">
                <h4>CI/CD Pipeline Modernization</h4>
                <div class="tags">
                    <span class="tag">GitHub Actions</span>
                    <span class="tag">Docker</span>
                    <span class="tag">AWS</span>
                </div>
                <p>Modernized legacy deployment processes with containerized CI/CD pipelines, improving reliability and
                    reducing costs.</p>
            </div>

            <div class="project-item">
                <h4>Cloud Security Framework</h4>
                <div class="tags">
                    <span class="tag">AWS</span>
                    <span class="tag">Security</span>
                    <span class="tag">IAM</span>
                </div>
                <p>Developed a comprehensive security framework for AWS environments, implementing least-privilege
                    access and automated compliance checks.</p>
            </div>
        </div>
    </ContentCard>
</template>

<script>
import ContentCard from './ContentCard.vue'

export default {
    name: 'ProjectsCard',
    components: {
        ContentCard
    }
}
</script>

<style scoped>
.projects-content {
    padding: 1rem;
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.project-item {
    background-color: var(--bg-color);
    padding: 1.2rem;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

h4 {
    margin: 0 0 0.8rem 0;
    color: var(--text-color);
}

.tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-bottom: 0.8rem;
}

.tag {
    background-color: var(--card-bg);
    color: var(--text-color);
    padding: 0.3rem 0.8rem;
    border-radius: 15px;
    font-size: 0.85rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

p {
    margin: 0;
    line-height: 1.6;
}

@media (max-width: 768px) {
    .projects-content {
        padding: 0.5rem;
        gap: 1rem;
    }

    .project-item {
        padding: 1rem;
    }
}
</style>