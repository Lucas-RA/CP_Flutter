# Simulador de Lavagem de Veículos

App Flutter que calcula o valor da lavagem de veículos de acordo com a modalidade escolhida, usando o padrão **Strategy** e **testes unitários (TDD)**.

## Regras

| Modalidade | Regra de cobrança |
|------------|-------------------|
| Simples    | R$ 35,00 por veículo, sem desconto |
| Completa   | R$ 60,00 por veículo, 10% de desconto sobre o total a partir de 3 veículos |
| Premium    | R$ 100,00 por veículo + taxa fixa de R$ 20,00 por compra |

- Quantidade negativa lança `ArgumentError`.
- Quantidade zero resulta em R$ 0,00 em todas as modalidades (a taxa Premium não é cobrada).

## Estrutura

```
lib/
  lavagem/
    calculadora_lavagem.dart
    strategy/
      lavagem_strategy.dart
      lavagem_simples.dart
      lavagem_completa.dart
      lavagem_premium.dart
  screens/
    lavagem_screen.dart
test/
  lavagem/
    calculadora_lavagem_test.dart
    strategy/
      lavagem_simples_test.dart
      lavagem_completa_test.dart
      lavagem_premium_test.dart
```

`CalculadoraLavagem` recebe a estratégia pelo construtor e só delega o cálculo, sem `if` ou `switch`. As regras ficam em cada estratégia.

## Rodando os testes

```bash
flutter test
```
