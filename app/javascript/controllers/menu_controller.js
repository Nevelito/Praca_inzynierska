import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = [
        'burgerDropdown'
    ];

    toggleBurgerDropdownVisibility() {
        this.burgerDropdownTarget.classList.toggle('hidden');
    }
}
