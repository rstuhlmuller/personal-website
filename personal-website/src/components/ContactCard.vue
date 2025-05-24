<template>
    <ContentCard title="Contact" icon="✉️">
        <div class="contact-content">
            <h3>Let's Connect!</h3>
            <div class="contact-info">
                <div class="contact-item">
                    <span class="icon">📧</span>
                    <a href="mailto:rodman@stuhlmuller.net">rodman@stuhlmuller.net</a>
                </div>
                <div class="contact-item">
                    <span class="icon">📍</span>
                    <span>Seattle, WA</span>
                </div>
            </div>

            <div class="social-section">
                <h4>Find me on social media:</h4>
                <SocialLinks />
            </div>

            <div class="availability">
                <h4>Current Availability</h4>
                <p>Open to discussing new opportunities and collaborations in cloud architecture and DevOps.</p>
            </div>
        </div>
    </ContentCard>
</template>

<script>
import ContentCard from './ContentCard.vue'
import SocialLinks from './SocialLinks.vue'

export default {
    name: 'ContactCard',
    components: {
        ContentCard,
        SocialLinks
    }
}
</script>

<style scoped>
.contact-content {
    padding: 1rem;
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

h3 {
    margin: 0;
    color: var(--text-color);
    text-align: center;
}

.contact-info {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    margin-top: 1rem;
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 0.8rem;
    padding: 0.8rem;
    background-color: var(--bg-color);
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.icon {
    font-size: 1.2rem;
}

a {
    color: var(--text-color);
    text-decoration: none;
    transition: opacity 0.2s;
}

a:hover {
    opacity: 0.8;
}

.social-section {
    text-align: center;
    margin-top: 1rem;
}

h4 {
    margin: 0 0 1rem 0;
    color: var(--text-color);
}

.availability {
    text-align: center;
    background-color: var(--bg-color);
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.availability p {
    margin: 0.5rem 0 0 0;
    line-height: 1.6;
}

@media (max-width: 768px) {
    .contact-content {
        padding: 0.5rem;
        gap: 1rem;
    }

    .contact-item {
        padding: 0.6rem;
    }

    .availability {
        padding: 0.8rem;
    }
}
</style>