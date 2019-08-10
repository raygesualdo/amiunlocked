const $main = document.querySelector('main')
const $state = document.querySelector('#state')
const $updatedAt = document.querySelector('#updated-at')

const STATES = ['locked', 'unlocked']

const updateUi = ({ state, updatedAt } = {}) => {
  if (state) {
    $main.classList.remove(...STATES)
    $main.classList.add(state)
    $state.textContent = state
  }
  if (updatedAt) {
    const date = new Date(updatedAt)
    const humanReadableDate = date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      second: '2-digit',
    })
    $updatedAt.textContent = `Updated ${humanReadableDate}`
  }
}

const resetUi = () => {
  $main.classList.remove(...STATES)
  $state.textContent = "Schrödinger's cat"
  $updatedAt.innerHTML = '&nbsp;'
}

const fetchState = async () => {
  try {
    const response = await fetch(window.kvdbUrl, { cache: 'no-store' })
    const json = await response.json()
    updateUi(json)
  } catch (error) {
    console.error(error)
    resetUi()
  }
}

fetchState()
setInterval(() => {
  fetchState()
}, 5000)
