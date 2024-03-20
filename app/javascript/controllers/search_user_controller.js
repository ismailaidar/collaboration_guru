import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userSelect", "emailInput"]
  
  connect() {
    this.query = this.debounce(this.query, 900); 
  }

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
      response.forEach(element => {
        const option = document.createElement('option'); // Moved inside loop
        option.text = element.email;
        option.value = element.email; // Assuming you'd also want to set the value
        select.add(option);
      });
    })
  }

  reset(selectElement) {
    while (selectElement.options.length > 0) {
      selectElement.remove(0);
    }
  }

  debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func.apply(this, args);
      };

      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }
}
