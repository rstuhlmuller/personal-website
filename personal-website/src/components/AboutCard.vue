<template>
    <ContentCard title="About" icon="👤">
        <div class="about-content">
            <h3>Professional Journey</h3>
            <p>With over a decade of experience in technology, I've specialized in:</p>
            <div class="experience-section">
                <div class="experience-item">
                    <h4>Cloud Infrastructure</h4>
                    <p>Expert in AWS services, designing scalable and secure cloud architectures that drive business
                        value.</p>
                </div>
                <div class="experience-item">
                    <h4>DevOps Practices</h4>
                    <p>Leading teams in implementing modern DevOps practices, automating workflows, and improving
                        deployment processes.</p>
                </div>
                <div class="experience-item">
                    <h4>Security & Compliance</h4>
                    <p>Strong focus on implementing security best practices and maintaining regulatory compliance in
                        cloud environments.</p>
                </div>
            </div>
        </div>
    </ContentCard>
</template>

<script>
import ContentCard from './ContentCard.vue'

export default {
    name: 'AboutCard',
    components: {
        ContentCard
    }
}
</script>

<style scoped>
.about-content {
    padding: 1rem;
}

h3 {
    margin-top: 0;
    color: var(--text-color);
    margin-bottom: 1rem;
}

.experience-section {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    margin-top: 1rem;
}

.experience-item {
    background-color: var(--bg-color);
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

h4 {
    margin: 0 0 0.5rem 0;
    color: var(--text-color);
}

p {
    margin: 0;
    line-height: 1.6;
}

@media (max-width: 768px) {
    .about-content {
        padding: 0.5rem;
    }

    .experience-item {
        padding: 0.8rem;
    }
}
</style>