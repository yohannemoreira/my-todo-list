import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "backdrop", "panel", "title", "message", "confirmButton"]
  
  connect() {
    this.boundOpen = this.open.bind(this)
    document.addEventListener("modal:open", this.boundOpen)
  }

  disconnect() {
    document.removeEventListener("modal:open", this.boundOpen)
  }

  open(event) {
    const { title, message, confirmCallback } = event.detail
    
    this.confirmCallback = confirmCallback
    
    if (title) {
      this.titleTarget.textContent = title
    }
    if (message) {
      this.messageTarget.textContent = message
    }
    
    this.containerTarget.classList.remove("hidden")
    
    this.containerTarget.offsetHeight
    
    this.backdropTarget.classList.add("opacity-100")
    this.panelTarget.classList.add("opacity-100", "translate-y-0", "sm:scale-100")
    
    document.body.style.overflow = "hidden"
    
    setTimeout(() => {
      this.confirmButtonTarget.focus()
    }, 100)
  }

  close(event) {
    if (event) {
      event.preventDefault()
    }
    
    this.backdropTarget.classList.remove("opacity-100")
    this.panelTarget.classList.remove("opacity-100", "translate-y-0", "sm:scale-100")
    
    setTimeout(() => {
      this.containerTarget.classList.add("hidden")
      document.body.style.overflow = ""
    }, 200)
  }

  confirm(event) {
    event.preventDefault()
    
    if (this.confirmCallback && typeof this.confirmCallback === "function") {
      this.confirmCallback()
    }
    
    this.close()
  }

  handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
}
