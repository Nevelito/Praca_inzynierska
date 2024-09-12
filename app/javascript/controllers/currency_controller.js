import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["amount", "fromCurrency", "toCurrency", "result"];

    convert() {
        const amount = parseFloat(this.amountTarget.value);
        const fromCurrency = this.fromCurrencyTarget.value;
        const toCurrency = this.toCurrencyTarget.value;

        if (isNaN(amount) || amount <= 0) {
            alert("Wprowadź poprawną kwotę");
            return;
        }

        if (fromCurrency === toCurrency) {
            this.resultTarget.innerText = `Wynik: ${amount} ${toCurrency}`;
            return;
        }

        fetch(`http://api.nbp.pl/api/exchangerates/rates/A/${fromCurrency}/?format=json`)
            .then(response => response.json())
            .then(data => {
                const fromRate = data.rates[0].mid;

                if (toCurrency === "PLN") {
                    const convertedAmount = (amount * fromRate).toFixed(2);
                    this.resultTarget.innerText = `Wynik: ${convertedAmount} PLN`;
                } else {
                    fetch(`http://api.nbp.pl/api/exchangerates/rates/A/${toCurrency}/?format=json`)
                        .then(response => response.json())
                        .then(data => {
                            const toRate = data.rates[0].mid;
                            const convertedAmount = (amount * fromRate / toRate).toFixed(2);
                            this.resultTarget.innerText = `Wynik: ${convertedAmount} ${toCurrency}`;
                        });
                }
            })
            .catch(error => {
                console.error("Błąd w pobieraniu danych z API NBP:", error);
                alert("Wystąpił problem z przeliczeniem walut. Spróbuj ponownie później.");
            });
    }
}
