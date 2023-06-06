import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['slider']

  connect() {
    console.log(this.sliderTarget.value);
  }

  slider() {
    const valueLabels = ["£", "££", "£££", "££££"];
    const sliderValueElement = document.getElementById('sliderValue');

    this.sliderTarget.addEventListener('input', () => {
      const value = parseInt(this.sliderTarget.value);
      const snapIncrement = 1;
      const snappedValue = Math.round(value / snapIncrement) * snapIncrement;

      this.sliderTarget.value = snappedValue;
      sliderValueElement.textContent = valueLabels[snappedValue - 3];
    });
  }
}

