<script>
import { ref, computed, onMounted } from 'vue'
import md5 from 'md5'
import SocialLinks from './SocialLinks.vue'

export default {
  name: 'ProfileCard',
  components: {
    SocialLinks
  },
  setup() {
    const name = ref('Rodman Stuhlmuller')
    const description = ref('Transform complex technical challenges into elegant solutions that drive business value')
    const email = ref('rodman@stuhlmuller.net')
    const location = ref('Seattle, WA')
    const imageLoaded = ref(false)
    const imageError = ref(false)

    const gravatarUrl = computed(() => {
      const hash = md5(email.value.trim().toLowerCase())
      return `https://www.gravatar.com/avatar/${hash}?s=200`
    })

    const preloadGravatar = () => {
      const img = new Image()
      img.src = gravatarUrl.value

      return new Promise((resolve, reject) => {
        img.onload = () => {
          imageLoaded.value = true
          resolve()
        }
        img.onerror = () => {
          imageError.value = true
          reject(new Error('Failed to load Gravatar image'))
        }
      })
    }

    onMounted(async () => {
      try {
        await preloadGravatar()
      } catch (error) {
        console.error('Error preloading Gravatar:', error)
      }
    })

    return {
      name,
      description,
      location,
      gravatarUrl,
      imageLoaded,
      imageError
    }
  }
}
</script>

<template>
  <div class="card">
    <div class="profile-pic-container">
      <div class="profile-pic-border">
        <div class="profile-pic-background">
          <div v-if="!imageLoaded && !imageError" class="loading-placeholder">
            <div class="loading-spinner"></div>
          </div>
          <img v-show="imageLoaded" :src="gravatarUrl" alt="Profile Picture" class="profile-pic">
          <div v-if="imageError" class="error-placeholder">
            <span>!</span>
          </div>
        </div>
      </div>
    </div>
    <div class="location">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="location-icon">
        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
        <circle cx="12" cy="10" r="3"></circle>
      </svg>
      <span>{{ location }}</span>
    </div>
    <div class="card-content">
      <h1>{{ name }}</h1>
      <p>{{ description }}</p>
      <SocialLinks />
    </div>
  </div>
</template>

<style scoped>
.card {
  background-color: var(--card-bg);
  border-radius: 16px;
  box-shadow: var(--card-shadow);
  padding: 2rem;
  text-align: center;
  width: 100%;
  height: 100%;
  transition: box-shadow 0.3s ease, transform 0.3s ease;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.profile-pic-container {
  display: flex;
  justify-content: center;
  margin-bottom: 0.75rem;
}

.profile-pic-border {
  width: 210px;
  height: 210px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 1rem;
  background: conic-gradient(from 0deg,
      #ff6b6b,
      #feca57,
      #48dbfb,
      #ff9ff3,
      #ff6b6b);
}

.profile-pic-background {
  width: 200px;
  height: 200px;
  border-radius: 50%;
  background-color: var(--card-bg);
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
}

.profile-pic {
  width: 195px;
  height: 195px;
  border-radius: 50%;
  object-fit: cover;
}

.loading-placeholder,
.error-placeholder {
  width: 195px;
  height: 195px;
  border-radius: 50%;
  background-color: var(--card-bg);
  display: flex;
  justify-content: center;
  align-items: center;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(0, 0, 0, 0.1);
  border-left-color: var(--text-color);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

.error-placeholder {
  background-color: #ffebee;
}

.error-placeholder span {
  font-size: 48px;
  color: #f44336;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.location {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1rem;
  color: var(--text-color);
  opacity: 0.8;
  font-size: 0.9rem;
}

.location-icon {
  margin-right: 0.25rem;
}

.card-content {
  display: flex;
  flex-direction: column;
  align-items: center;
}

h1 {
  color: var(--text-color);
  margin-bottom: 1rem;
}

p {
  color: var(--text-color);
  line-height: 1.6;
  text-align: center;
}

/* Media query for mobile devices */
@media (max-width: 600px) {
  .card {
    padding: 1.5rem;
    border-radius: 12px;
    height: 100%;
    min-height: 100%;
  }

  .profile-pic-border {
    width: 180px;
    height: 180px;
    margin-top: 0;
  }

  .profile-pic-background {
    width: 170px;
    height: 170px;
  }

  .profile-pic,
  .loading-placeholder,
  .error-placeholder {
    width: 165px;
    height: 165px;
  }

  h1 {
    font-size: 1.5rem;
    margin-top: 0.5rem;
  }

  p {
    font-size: 0.9rem;
  }

  .location {
    font-size: 0.8rem;
  }
}
</style>