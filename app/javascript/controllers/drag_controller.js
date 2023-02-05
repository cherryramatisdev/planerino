import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['debit']

  dragStart(event) {
    this.originEl = event.target

    sessionStorage.setItem('originElId', JSON.parse(event.target.dataset.info).id)
    
    event.dataTransfer.effectAllowed = "move";
    event.dataTransfer.setData('text/html', event.target.innerHTML);
  }

  dragEnd(event) {}

  drop(event) {
    event.stopPropagation()

    if (sessionStorage.getItem('originElOwner')) {
      const originId = parseInt(sessionStorage.getItem('originElId'))
      const targetOwnerId = parseInt(JSON.parse(event.target.dataset.info).owner_id)

      fetch('/debit/change_owner', {
        method: 'POST',
        credentials: 'same-origin',
        headers: {
          Accept: "text/vnd.turbo-stream.html",
          "Content-Type": "application/json",
          "X-CSRF-Token": document.head.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({
          origin_id: originId,
          target_owner_id: targetOwnerId,
        })
      })
    }
  }

  dragEnter(event) {
    if (event.preventDefault) {
      event.preventDefault()
    }

    return false
  }

  dragLeave() {}
  
  dragOver() {
    if (event.preventDefault) {
      event.preventDefault()
    }

    return false
  }
}
