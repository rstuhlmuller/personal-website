<template>
    <div class="content-card">
        <div class="card-header" v-if="title">
            <div class="card-icon" v-if="icon">{{ icon }}</div>
            <h2 class="card-title">{{ title }}</h2>
        </div>
        <div class="card-body">
            <slot></slot>
        </div>
    </div>
</template>

<script>
export default {
    name: 'ContentCard',
    props: {
        title: {
            type: String,
            default: ''
        },
        icon: {
            type: String,
            default: ''
        }
    }
}
</script>

<style scoped>
.content-card {
    background-color: var(--card-bg);
    border-radius: 16px;
    box-shadow: var(--card-shadow);
    padding: 1.5rem;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.card-header {
    display: flex;
    align-items: center;
    padding-bottom: 1rem;
    border-bottom: 1px solid rgba(125, 125, 125, 0.1);
    margin-bottom: 1rem;
    flex-shrink: 0;
}

.card-icon {
    font-size: 1.5rem;
    margin-right: 0.75rem;
}

.card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: var(--text-color);
    margin: 0;
}

.card-body {
    flex: 1;
    color: var(--text-color);
    line-height: 1.6;
    overflow-y: auto;
    padding-right: 0.5rem;
    min-height: 0;
    -webkit-overflow-scrolling: touch;
    overscroll-behavior: contain;
    touch-action: pan-y;
}

.card-body::-webkit-scrollbar {
    width: 4px;
}

.card-body::-webkit-scrollbar-track {
    background: transparent;
}

.card-body::-webkit-scrollbar-thumb {
    background-color: rgba(125, 125, 125, 0.3);
    border-radius: 4px;
}

/* Media query for mobile devices */
@media (max-width: 768px) {
    .content-card {
        padding: 1.25rem;
        border-radius: 12px;
        height: 100%;
        min-height: 100%;
        display: flex;
        flex-direction: column;
        touch-action: pan-y;
    }

    .card-title {
        font-size: 1.1rem;
    }

    .card-icon {
        font-size: 1.3rem;
    }

    .card-body {
        flex: 1;
        overflow-y: auto;
        -webkit-overflow-scrolling: touch;
        overscroll-behavior: contain;
        touch-action: pan-y;
        padding-right: 0;
    }
}
</style>