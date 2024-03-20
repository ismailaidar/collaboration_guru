import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userSelect", "emailInput"]

  query() {
    const select = this.userSelectTarget;
    
    // clear the select first
    this.reset(select)

    // add more options based on the search
    const url = `/users/fetch_users?userInput=${this.emailInputTarget.value}`
    fetch(url, {
      headers: {
        Accept: "application/json"
      }
    })
    .then(response => response.json())
    .then(response => {
      const option = document.createElement('option');
      response.forEach(element => {
        option.text = element.email
        select.add(option)
      });
    })
  }

  reset(selectElement) {
    while (selectElement.options.length > 0) {
      selectElement.remove(0);
    }
  }
}
