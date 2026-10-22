# Simulador de Lavagem de Veículos

Simulador de lavagem de veículos em Flutter/Dart desenvolvido com **testes unitários**, **TDD (Red → Green → Refactor)** e **Strategy Pattern**.

## Regras implementadas

| Modalidade | Valor por veículo | Regra |
|------------|------------------:|-------|
| Simples    | R$ 35,00  | sem desconto |
| Completa   | R$ 60,00  | 10% de desconto sobre o total a partir de 3 veículos |
| Premium    | R$ 100,00 | taxa fixa de R$ 20,00 por compra |

- Quantidade negativa é inválida (`ArgumentError`).
- Quantidade zero resulta em R$ 0,00 em todas as modalidades (a taxa Premium não é cobrada).
- A `CalculadoraLavagem` recebe a estratégia pelo construtor e só delega o cálculo.

## Como rodar os testes

```bash
flutter test
```
