import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "show", "hideable" ]

  connect() {
    console.log("Hello, Stimulus!")
  }

  call(event) {
    event.preventDefault();

    if(this.hideableTarget && this.hideableTarget.classList.contains("d-none")) {
      this.hideableTarget.classList.remove("d-none");
      this.showTarget.classList.add("d-none");
    } else if (this.showTarget && this.showTarget.classList.contains("d-none")) {
      this.showTarget.classList.remove("d-none");
      this.hideableTarget.classList.add("d-none");
    }
  }
}
