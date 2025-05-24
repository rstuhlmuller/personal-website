<script>
import { ref, onMounted, watch } from 'vue'
import ProfileCard from './components/ProfileCard.vue'
import VisitorCounter from './components/VisitorCounter.vue'
import ThemeToggle from './components/ThemeToggle.vue'
import ContentCard from './components/ContentCard.vue'
import CertificationBadge from './components/CertificationBadge.vue'
import HomeCard from './components/HomeCard.vue'
import AboutCard from './components/AboutCard.vue'
import ProjectsCard from './components/ProjectsCard.vue'
import ContactCard from './components/ContactCard.vue'

export default {
  name: 'App',
  components: {
    ProfileCard,
    VisitorCounter,
    ThemeToggle,
    ContentCard,
    CertificationBadge,
    HomeCard,
    AboutCard,
    ProjectsCard,
    ContactCard
  },
  setup() {
    const theme = ref(localStorage.getItem('theme') || 'auto')
    const systemTheme = ref(window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light')
    const currentCardIndex = ref(0)
    const isTransitioning = ref(false)

    const cards = [
      { id: 'profile', component: 'ProfileCard' },
      { id: 'certifications', component: 'ContentCard', child: 'CertificationBadge', title: 'Certifications', icon: '🏆' },
      { id: 'home', component: 'HomeCard' },
      { id: 'about', component: 'AboutCard' },
      { id: 'projects', component: 'ProjectsCard' },
      { id: 'contact', component: 'ContactCard' }
    ]

    const switchCard = (direction) => {
      if (isTransitioning.value) return;
      isTransitioning.value = true;

      const newIndex = direction === 'next'
        ? (currentCardIndex.value + 1) % cards.length
        : (currentCardIndex.value - 1 + cards.length) % cards.length;

      currentCardIndex.value = newIndex;

      setTimeout(() => {
        isTransitioning.value = false;
      }, 300);
    }

    const applyTheme = (newTheme) => {
      const themeToApply = newTheme === 'auto' ? systemTheme.value : newTheme
      document.documentElement.classList.remove('light', 'dark')
      document.documentElement.classList.add(themeToApply)
    }

    const updateSystemTheme = (e) => {
      systemTheme.value = e.matches ? 'dark' : 'light'
      if (theme.value === 'auto') {
        applyTheme('auto')
      }
    }

    const touchStart = ref({ x: 0, y: 0 })
    const touchEnd = ref({ x: 0, y: 0 })
    const isSwiping = ref(false)
    const swipeThreshold = 50 // minimum distance for swipe

    const handleTouchStart = (event) => {
      // Don't prevent default to allow scrolling
      touchStart.value = {
        x: event.touches[0].clientX,
        y: event.touches[0].clientY
      }
      isSwiping.value = true
    }

    const handleTouchMove = (event) => {
      // Don't prevent default to allow scrolling
      if (!isSwiping.value) return

      touchEnd.value = {
        x: event.touches[0].clientX,
        y: event.touches[0].clientY
      }

      // Calculate deltas
      const deltaX = touchEnd.value.x - touchStart.value.x
      const deltaY = touchEnd.value.y - touchStart.value.y

      // If scrolling vertically, stop tracking swipe
      if (Math.abs(deltaY) > Math.abs(deltaX)) {
        isSwiping.value = false
      }
    }

    const handleTouchEnd = () => {
      if (!isSwiping.value) return

      const deltaX = touchEnd.value.x - touchStart.value.x
      const deltaY = touchEnd.value.y - touchStart.value.y

      // Only handle horizontal swipes
      if (Math.abs(deltaX) > swipeThreshold && Math.abs(deltaY) < Math.abs(deltaX)) {
        if (deltaX > 0) {
          switchCard('prev')
        } else {
          switchCard('next')
        }
      }

      isSwiping.value = false
    }

    const handleWheel = (event) => {
      // Only handle horizontal scrolling with two fingers (trackpad)
      if (event.deltaX !== 0 && Math.abs(event.deltaX) > Math.abs(event.deltaY)) {
        event.preventDefault();
        if (event.deltaX > 50) {
          switchCard('next');
        } else if (event.deltaX < -50) {
          switchCard('prev');
        }
      }
    }

    watch(theme, (newTheme) => {
      localStorage.setItem('theme', newTheme)
      applyTheme(newTheme)
    })

    onMounted(() => {
      applyTheme(theme.value)
      const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
      mediaQuery.addListener(updateSystemTheme)
      
      // Add wheel event listener
      document.querySelector('.card-deck-container').addEventListener('wheel', handleWheel, { passive: false })
      
      return () => {
        mediaQuery.removeListener(updateSystemTheme)
        // Clean up wheel event listener
        document.querySelector('.card-deck-container')?.removeEventListener('wheel', handleWheel)
      }
    })

    return {
      theme,
      cards,
      currentCardIndex,
      isTransitioning,
      switchCard,
      handleTouchStart,
      handleTouchMove,
      handleTouchEnd,
      handleWheel
    }
  }
}
</script>

<template>
  <div class="container">
    <div class="content-wrapper">
      <div class="card-deck-container" 
        @touchstart="handleTouchStart" 
        @touchmove.passive="handleTouchMove"
        @touchend="handleTouchEnd"
        @wheel="handleWheel">
        <!-- Navigation buttons -->
        <button class="nav-button prev" @click="switchCard('prev')" :disabled="isTransitioning">
          <span class="arrow">←</span>
        </button>
        <button class="nav-button next" @click="switchCard('next')" :disabled="isTransitioning">
          <span class="arrow">→</span>
        </button>

        <!-- Card Stack -->
        <div class="card-stack">
          <template v-for="(card, index) in cards" :key="card.id">
            <div class="card-wrapper" :class="{
              'active': index === currentCardIndex,
              'next': (index === (currentCardIndex + 1) % cards.length),
              'prev': (index === (currentCardIndex - 1 + cards.length) % cards.length)
            }">
              <!-- Dynamic component rendering -->
              <component :is="card.component" v-bind="card">
                <component v-if="card.child" :is="card.child" />
              </component>
            </div>
          </template>
        </div>
      </div>

      <!-- Card Indicators moved below card-deck-container -->
      <div class="card-indicators">
        <button v-for="(card, index) in cards" :key="card.id" class="indicator"
          :class="{ 'active': index === currentCardIndex }" @click="currentCardIndex = index">
        </button>
      </div>

      <!-- Theme Toggle -->
      <div class="controls-wrapper">
        <ThemeToggle v-model="theme" class="theme-toggle" />
      </div>

      <!-- Visitor Counter -->
      <VisitorCounter />
    </div>
  </div>
</template>

<style>
:root {
  --bg-color: #f0f0f0;
  --text-color: #333;
  --card-bg: #ffffff;
  --card-shadow: 0 10px 20px rgba(0, 0, 0, 0.1), 0 6px 6px rgba(0, 0, 0, 0.1);
}

.dark {
  --bg-color: #1a1a1a;
  --text-color: #f0f0f0;
  --card-bg: #2a2a2a;
  --card-shadow: 0 10px 20px rgba(0, 0, 0, 0.3), 0 6px 6px rgba(0, 0, 0, 0.2);
}

body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: var(--bg-color);
  color: var(--text-color);
  transition: background-color 0.3s, color 0.3s;
  min-height: 100vh;
  min-height: -webkit-fill-available; /* iOS Safari */
  overflow: hidden;
  position: fixed;
  width: 100%;
}

.container {
  min-height: 100vh;
  min-height: -webkit-fill-available; /* iOS Safari */
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  box-sizing: border-box;
  overflow: hidden;
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2rem;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
}

.card-deck-container {
  position: relative;
  width: 100%;
  height: 600px;
  max-width: 900px;
  margin: 0 auto;
  touch-action: pan-y;
  overflow: visible;
  user-select: none;
  -webkit-user-select: none;
  padding: 2rem;
}

.card-stack {
  position: relative;
  width: 100%;
  height: 100%;
  perspective: 2000px;
  transform-style: preserve-3d;
}

.card-wrapper {
  position: absolute;
  width: 100%;
  height: 100%;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  opacity: 0;
  pointer-events: none;
  transform: translateX(100%) scale(0.9) rotate(5deg);
  will-change: transform;
  transform-origin: center;
  touch-action: none;
  display: none;
}

.card-wrapper.active {
  opacity: 1;
  pointer-events: auto;
  transform: translateX(0) scale(1) rotate(0deg);
  z-index: 3;
  display: block;
}

.card-wrapper.next {
  opacity: 0.7;
  transform: translateX(40%) scale(0.95) rotate(5deg);
  z-index: 2;
  display: block;
}

.card-wrapper.prev {
  opacity: 0.7;
  transform: translateX(-40%) scale(0.95) rotate(-5deg);
  z-index: 1;
  display: block;
}

.nav-button {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: var(--card-bg);
  border: none;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  box-shadow: var(--card-shadow);
  transition: all 0.2s ease;
}

.nav-button:hover {
  transform: translateY(-50%) scale(1.1);
}

.nav-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.nav-button.prev {
  left: -25px;
}

.nav-button.next {
  right: -25px;
}

.arrow {
  color: var(--text-color);
  font-size: 1.2rem;
  line-height: 1;
}

.card-indicators {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 1rem;
  width: 100%;
}

.indicator {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--text-color);
  opacity: 0.3;
  border: none;
  cursor: pointer;
  padding: 0;
  transition: all 0.2s ease;
}

.indicator.active {
  opacity: 1;
  transform: scale(1.2);
}

.controls-wrapper {
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 1rem;
  background-color: var(--bg-color);
}

/* Media query for desktop devices */
@media (min-width: 769px) {
  .card-deck-container {
    overflow: visible;
    height: 600px;
  }

  .card-wrapper.next {
    opacity: 0.7;
    transform: translateX(40%) scale(0.95) rotate(5deg);
  }

  .card-wrapper.prev {
    opacity: 0.7;
    transform: translateX(-40%) scale(0.95) rotate(-5deg);
  }

  .nav-button {
    display: flex;
    width: 50px;
    height: 50px;
  }

  .nav-button.prev {
    left: -25px;
  }

  .nav-button.next {
    right: -25px;
  }
}

/* Media query for mobile devices */
@media (max-width: 768px) {
  .container {
    padding: 1rem;
    height: 100vh;
    overflow: hidden;
  }

  .content-wrapper {
    height: 100%;
    gap: 1rem;
    display: flex;
    flex-direction: column;
  }

  .card-deck-container {
    flex: 1;
    padding: 0;
    position: relative;
    height: calc(100vh - 160px); /* Set a fixed height based on viewport */
    touch-action: pan-y;
    -webkit-overflow-scrolling: touch;
  }

  .card-stack {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    height: 100%;
  }

  .card-wrapper {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    height: 100%;
    min-height: 100%;
    transform: translateX(100%);
    transition: transform 0.3s ease-out;
    display: none;
  }

  .card-wrapper.active {
    transform: translateX(0);
    display: block;
    height: 100%;
  }

  .card-wrapper.next {
    transform: translateX(100%);
  }

  .card-wrapper.prev {
    transform: translateX(-100%);
  }

  .nav-button {
    display: none;
  }

  .card-indicators {
    margin-bottom: 0;
  }

  .controls-wrapper {
    margin-top: auto;
    padding-bottom: env(safe-area-inset-bottom, 1rem);
  }
}

/* Improve performance on mobile devices */
@supports (backdrop-filter: none) {
  .card-wrapper {
    will-change: transform, opacity;
    backface-visibility: hidden;
    -webkit-backface-visibility: hidden;
  }
}

/* Additional mobile optimizations */
@media (max-width: 480px) {
  .container {
    padding: 0.5rem;
  }

  .card-wrapper {
    max-height: calc(100vh - 160px);
  }
}

/* Handle very short screens */
@media (max-height: 600px) {
  .container {
    padding: 0.5rem;
  }

  .content-wrapper {
    gap: 0.5rem;
  }

  .card-wrapper {
    max-height: calc(100vh - 140px);
  }
}
</style>