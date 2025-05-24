<script>
export default {
    name: 'NavbarComponent',
    props: {
        isOpen: {
            type: Boolean,
            required: true
        }
    },
    emits: ['toggle']
}
</script>

<template>
    <div class="drawer-nav-container">
        <!-- Overlay backdrop when drawer is open -->
        <div class="drawer-backdrop" :class="{ 'active': isOpen }" @click="$emit('toggle')"></div>

        <!-- Drawer Navbar -->
        <nav class="drawer-navbar" :class="{ 'open': isOpen }">
            <div class="nav-content">
                <div class="nav-header">
                    <button class="close-button" @click="$emit('toggle')" aria-label="Close navigation menu">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                    <div class="nav-title">Menu</div>
                </div>
                <div class="nav-links">
                    <a href="#home" class="nav-link" @click="$emit('toggle')">
                        <span class="nav-icon">🏠</span>
                        <span class="nav-link-text">Home</span>
                    </a>
                    <a href="#about" class="nav-link" @click="$emit('toggle')">
                        <span class="nav-icon">👤</span>
                        <span class="nav-link-text">About</span>
                    </a>
                    <a href="#projects" class="nav-link" @click="$emit('toggle')">
                        <span class="nav-icon">💻</span>
                        <span class="nav-link-text">Projects</span>
                    </a>
                    <a href="#contact" class="nav-link" @click="$emit('toggle')">
                        <span class="nav-icon">✉️</span>
                        <span class="nav-link-text">Contact</span>
                    </a>
                </div>
            </div>
        </nav>
    </div>
</template>

<style scoped>
.drawer-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0);
    transition: background-color 0.3s ease;
    pointer-events: none;
    z-index: 100;
}

.drawer-backdrop.active {
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(2px);
    pointer-events: auto;
}

/* Drawer Navbar */
.drawer-navbar {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.9);
    width: 90%;
    max-width: 320px;
    height: auto;
    max-height: 80vh;
    background-color: var(--card-bg);
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    transition: transform 0.3s ease, opacity 0.3s ease;
    z-index: 101;
    overflow: hidden;
    opacity: 0;
    pointer-events: none;
}

.drawer-navbar.open {
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
    pointer-events: auto;
}

.nav-content {
    display: flex;
    flex-direction: column;
    height: 100%;
    box-sizing: border-box;
    overflow-y: auto;
}

.nav-header {
    display: flex;
    align-items: center;
    padding: 16px;
    border-bottom: 1px solid rgba(125, 125, 125, 0.1);
    position: sticky;
    top: 0;
    background-color: var(--card-bg);
    z-index: 1;
}

.close-button {
    background: none;
    border: none;
    color: var(--text-color);
    cursor: pointer;
    padding: 5px;
    margin-right: 10px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.2s;
}

.close-button:hover {
    background-color: rgba(125, 125, 125, 0.1);
}

.nav-title {
    font-size: 1.2rem;
    font-weight: 600;
    color: var(--text-color);
}

.nav-links {
    display: flex;
    flex-direction: column;
    padding: 8px;
}

.nav-link {
    color: var(--text-color);
    text-decoration: none;
    font-size: 1rem;
    font-weight: 500;
    letter-spacing: 0.2px;
    padding: 12px 16px;
    margin: 4px 0;
    border-radius: 8px;
    transition: background 0.2s, transform 0.1s;
    display: flex;
    align-items: center;
}

.nav-icon {
    margin-right: 12px;
    font-size: 18px;
}

.nav-link:hover {
    background: rgba(125, 125, 125, 0.08);
    transform: translateX(2px);
}

.nav-link:active {
    transform: scale(0.98);
}

/* Media query for mobile devices */
@media (max-width: 600px) {
    .drawer-navbar {
        width: 95%;
        max-width: 300px;
    }

    .nav-link {
        padding: 10px 14px;
    }
}
</style>