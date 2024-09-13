import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ['overlay', 'modal']

    connect() {
        this.overlay = document.getElementById('overlay');
        this.overlay.classList.remove('hidden');
        document.addEventListener('turbo:load', this.resetOverlay);
    }

    disconnect() {
        document.removeEventListener('turbo:load', this.resetOverlay);
    }

    resetOverlay = () => {
        if (this.overlay) {
            this.overlay.classList.add('hidden');
        }
    }

    hideModal(event) {
        event.preventDefault();
        this.modalTarget.classList.add('hidden');
        this.overlay.classList.add('hidden');
    }

    hideOverlay(event) {
        if(event.detail.success) {
            this.overlay.classList.add('hidden');
        }
    }
}
