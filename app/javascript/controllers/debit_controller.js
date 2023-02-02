import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["clickarea", "arrowicon", "payable", "ownertotal"]

  hideElement(element) {
    element.classList.remove('flex')
    element.classList.add('hidden')

    this.clickareaTarget.classList.remove("mb-2")

    this.arrowiconTarget.style = 'transform: rotate(180deg)';
  }

  displayElement(element) {
    element.classList.remove('hidden')
    element.classList.add('flex')
this.clickareaTarget.classList.add("mb-2")

    this.arrowiconTarget.style = 'transform: rotate(360deg)';
  }

  siblings(elem) {
    // create an empty array
    let siblings = [];

    // if no parent, return empty list
    if (!elem.parentNode) {
      return siblings;
    }

    // first child of the parent node
    let sibling = elem.parentNode.firstElementChild;

    // loop through next siblings until `null`
    do {
      // push sibling to array
      if (sibling != elem) {
        siblings.push(sibling);
      }
    } while (sibling = sibling.nextElementSibling);

    return siblings;
  }

  async updateTotalDebitForOwner(owner_id, month_id) {
    const response = await fetch(`/owner/get_debit_total/${owner_id}?month_id=${month_id}`, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }})

    if (response.status === 200) {
      const { total } = await response.json()

      document.getElementById(`total_owner-${owner_id}`).textContent = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(total)
    }
  }

  async updateTotalForDebit(debit_title, month_id) {
    const response = await fetch(`/debit/get_debit_total?title=${debit_title}&month_id=${month_id}`, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }})

    if (response.status === 200) {
      const { total } = await response.json()

      document.getElementById(`total_debit-${debit_title}`).textContent = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(total)
    }
  }

  // ACTIONS

  toggle(event) {
    event.preventDefault();

    let siblings = this.siblings(this.clickareaTarget)

    for (let sibling of siblings) {
      let isOpen = sibling.classList.contains("flex")

      if (isOpen) {
        this.hideElement(sibling)
      } else {
        this.displayElement(sibling)
      }
    }
  }

  async pay(event) {
    event.preventDefault()

    const body = JSON.parse(this.payableTarget.dataset.info)

    const url = `/debits/update_paid/${body.id}?month_id=${body.month_id}&id=${body.id}`

    const response = await fetch(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }})


    if (response.status === 200) {
      const { debit_paid } = await response.json()

      await this.updateTotalDebitForOwner(body.owner_id, body.month_id)
      await this.updateTotalForDebit(body.debit_title, body.month_id)

      if (debit_paid) {
        this.payableTarget.childNodes[3].classList.remove("bg-yellow-300")
        this.payableTarget.childNodes[3].classList.add("bg-green-300")
        this.payableTarget.childNodes[3].textContent = "Pago"
      } else {
        this.payableTarget.childNodes[3].classList.remove("bg-green-300")
        this.payableTarget.childNodes[3].classList.add("bg-yellow-300")
        this.payableTarget.childNodes[3].textContent = "Pendente"
      }
    }
  }
}
