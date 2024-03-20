import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userSelect", "emailInput", "emailTags"]
  
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
        option.value = element.id;
        select.add(option);
      });
    })
  }

  reset(selectElement) {
    while (selectElement.options.length > 0) {
      selectElement.remove(0);
    }
  }

  addEmailTag() {
    // Get only the first selection since I am only firing this action on click
    // so I don't need all the selected values but only the first one
    // as soon as it's click I add a tag to the list.
    const option = this.userSelectTarget.selectedOptions[0];
    if (option) {
      const tag = this.createTag(option);
      this.emailTagsTarget.appendChild(tag);
    }
  }

  createTag(option) {
    const wrapper = document.createElement('div');
    wrapper.innerHTML = `
      <span class="inline-flex items-center rounded-md bg-gray-50 px-2 py-1 text-xs font-medium text-gray-600 ring-1 ring-inset ring-gray-500/10" id="${option.value}">
        ${option.text}
        <button class="ml-2 inline-flex items-center justify-center rounded-full bg-red-300 p-1 text-white hover:bg-red-500 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 text-xs" 
                type="button" data-action="click->search-user#removeTag">
          X
        </button>
      </span>
    `;
    return wrapper.firstElementChild;
  }

  removeTag(event) {
    event.target.closest('span').remove();
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
