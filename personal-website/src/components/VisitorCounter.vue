<script>
import { ref, onMounted } from 'vue'
import axios from 'axios'

export default {
    name: 'VisitorCounter',
    setup() {
        const visitorCount = ref(0)

        onMounted(async () => {
            try {
                // Get the initial visitor count
                const response = await axios.get('https://api.rodman.stuhlmuller.net/visitor_count')
                visitorCount.value = response.data["count"]

                // Increment the visitor count
                await axios.post('https://api.rodman.stuhlmuller.net/visitor_count')
            } catch (error) {
                console.error('Error fetching or updating visitor count:', error)
            }
        })

        return {
            visitorCount
        }
    }
}
</script>

<template>
    <p class="visitor-count">Visitors: {{ visitorCount }}</p>
</template>

<style scoped>
.visitor-count {
    position: fixed;
    bottom: 20px;
    right: 20px;
    margin: 0;
    padding: 8px 12px;
    font-size: 0.9em;
    color: var(--text-color);
    background-color: var(--card-bg);
    border-radius: 8px;
    box-shadow: var(--card-shadow);
    z-index: 100;
    opacity: 0.8;
    transition: opacity 0.2s ease;
}

.visitor-count:hover {
    opacity: 1;
}

/* Adjust for mobile devices */
@media (max-width: 768px) {
    .visitor-count {
        bottom: calc(env(safe-area-inset-bottom, 0px) + 10px);
        right: 10px;
        font-size: 0.8em;
        padding: 6px 10px;
    }
}
</style>
