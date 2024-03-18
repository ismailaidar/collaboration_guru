document.addEventListener("turbo:load", function () {
  const btn = document.getElementById('user-menu-button');
  if(btn) {
    btn.addEventListener('click', function () {
      var dropdownMenu = document.querySelector('[aria-labelledby="user-menu-button"]');
      if (dropdownMenu.classList.contains('hidden')) {
        dropdownMenu.classList.remove('hidden');
        dropdownMenu.classList.add('block');
      } else {
        dropdownMenu.classList.add('hidden');
        dropdownMenu.classList.remove('block');
      }
    });
  }
})

document.addEventListener('DOMContentLoaded', function () {
  // Find the button and the menu element
  const toggleButton = document.querySelector('button[aria-controls="mobile-menu"]');
  const menu = document.getElementById('mobile-menu');

  // Add a click event listener to the button
  if(toggleButton) {
    toggleButton.addEventListener('click', function () {
      // Toggle the 'hidden' class on the menu
      menu.classList.toggle('hidden');
  
      // Update aria-expanded attribute based on visibility
      const isExpanded = toggleButton.getAttribute('aria-expanded') === 'true';
      toggleButton.setAttribute('aria-expanded', !isExpanded);
    });
  }
});
