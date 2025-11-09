import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    title: String,
    message: String
  }

  connect() {
    const form = this.element.closest("form")
    if (form) {
      this.form = form
    }
  }

  confirm(event) {
    event.preventDefault()
    event.stopPropagation()
    
    const form = this.form || this.element.closest("form")
    
    if (!form) {
      console.error("No form found for delete confirmation")
      return
    }
    
    const modalEvent = new CustomEvent("modal:open", {
      detail: {
        title: this.titleValue || "Confirm Deletion",
        message: this.messageValue || "Are you sure you want to delete this item? This action cannot be undone.",
        confirmCallback: () => {
          form.requestSubmit()
        }
      }
    })
    
    document.dispatchEvent(modalEvent)
  }
}
