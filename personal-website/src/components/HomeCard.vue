<template>
    <ContentCard title="Home" icon="🏠">
        <div class="home-content">
            <h3>Welcome! 👋</h3>
            <p>I'm a Senior DevOps Engineer passionate about cloud architecture and automation. My expertise lies in:
            </p>
            <ul>
                <li>🌩️ Cloud Architecture (AWS)</li>
                <li>🔄 CI/CD Pipeline Development</li>
                <li>🛠️ Infrastructure as Code (Terraform)</li>
                <li>🐳 Container Orchestration (Kubernetes)</li>
                <li>🤖 Process Automation</li>
            </ul>
            <p>Swipe or use arrows to explore more about my work and experience!</p>
        </div>
    </ContentCard>
</template>

<script>
import ContentCard from './ContentCard.vue'

export default {
    name: 'HomeCard',
    components: {
        ContentCard
    }
}
</script>

<style scoped>
.home-content {
    padding: 1rem;
}

h3 {
    margin-top: 0;
    color: var(--text-color);
}

ul {
    list-style: none;
    padding-left: 0;
    margin: 1.5rem 0;
}

li {
    margin: 0.8rem 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

p {
    line-height: 1.6;
    margin: 1rem 0;
}
</style>