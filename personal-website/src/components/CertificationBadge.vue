<script>
import { onMounted } from 'vue'

export default {
    name: 'CertificationBadge',
    setup() {
        onMounted(() => {
            let script = document.createElement('script')
            script.type = 'text/javascript'
            script.src = '//cdn.credly.com/assets/utilities/embed.js'
            script.async = true
            document.head.appendChild(script)
        })
    }
}
</script>

<template>
    <div class="certification-badge-container">
        <div class="certification-badge">
            <div data-iframe-width="150" data-iframe-height="270"
                data-share-badge-id="46fd14a5-9d20-4d81-a893-11355efcdd2f"
                data-share-badge-host="https://www.credly.com"></div>
        </div>
    </div>
</template>

<style scoped>
.certification-badge-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    padding: 1rem;
    box-sizing: border-box;
    min-height: 270px;
}

.certification-badge {
    transform: scale(0.75);
    transform-origin: center;
}

@media (max-width: 768px) {
    .certification-badge {
        transform: scale(0.65);
    }

    .certification-badge-container {
        padding: 0.5rem;
        min-height: 240px;
    }
}

@media (max-width: 480px) {
    .certification-badge {
        transform: scale(0.55);
    }

    .certification-badge-container {
        min-height: 200px;
    }
}

@media (max-height: 600px) {
    .certification-badge {
        transform: scale(0.5);
    }

    .certification-badge-container {
        min-height: 180px;
    }
}
</style>
