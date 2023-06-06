import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider-price-range"
export default class extends Controller {
static targets = ['slider', 'slidernumber']

  connect() {
    console.log(this.sliderTarget.value)
    console.log(this.slidernumberTarget.innerText)
  }

  slider() {
    this.sliderTarget.addEventListener('input', function() {
      const value = parseInt(this.sliderTarget.value);
      const snapIncrement = 1;
      const snappedValue = Math.round(value / snapIncrement) * snapIncrement;
      rangeSlider.value = snappedValue;
      this.slidernumberTarget.innerText = snappedValue;
    });
  }
}
