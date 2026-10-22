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

---

# Passo a passo

## Sumário

0. [Criando o projeto](#0-criando-o-projeto)
1. [O contrato LavagemStrategy](#1-o-contrato-lavagemstrategy)
2. [LavagemSimples](#2-lavagemsimples)
3. [LavagemCompleta](#3-lavagemcompleta)
4. [LavagemPremium](#4-lavagempremium)
5. [CalculadoraLavagem](#5-calculadoralavagem)
6. [Rodando todos os testes](#6-rodando-todos-os-testes)
7. [Entrega](#7-entrega)

Em cada classe o ciclo é o mesmo:

- **RED** → escreve o teste primeiro e roda. Ele falha porque a classe ainda não existe.
- **GREEN** → cria a classe com o código para o teste passar.
- **REFACTOR** → melhora o código sem quebrar os testes.

---

## 0. Criando o projeto

```bash
flutter create cp_flutter
cd cp_flutter
```

Apagar o teste padrão do contador, porque ele não tem relação com o exercício:

```bash
rm test/widget_test.dart
```

Criar as pastas:

```bash
mkdir -p lib/lavagem/strategy
mkdir -p test/lavagem/strategy
```

Estrutura final que vamos montar:

```
lib/
  lavagem/
    calculadora_lavagem.dart
    strategy/
      lavagem_strategy.dart
      lavagem_simples.dart
      lavagem_completa.dart
      lavagem_premium.dart
test/
  lavagem/
    calculadora_lavagem_test.dart
    strategy/
      lavagem_simples_test.dart
      lavagem_completa_test.dart
      lavagem_premium_test.dart
```

> Os imports dos testes usam `package:cp_flutter/...`. Se o projeto for criado com outro nome, trocar `cp_flutter` pelo `name` que está no `pubspec.yaml`.

---

## 1. O contrato LavagemStrategy

Toda modalidade precisa ter o método `calcular(int qtd)`. A classe abstrata é o contrato que as três estratégias vão seguir.

`lib/lavagem/strategy/lavagem_strategy.dart`

```dart
// contrato que toda modalidade de lavagem precisa seguir
abstract class LavagemStrategy {
  double calcular(int qtd);
}
```

---

## 2. LavagemSimples

**Regra:** R$ 35,00 por veículo, sem desconto.

### 2.1 RED

`test/lavagem/strategy/lavagem_simples_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_simples.dart';

void main() {
  late LavagemSimples strategy;

  setUp(() {
    strategy = LavagemSimples();
  });

  group('LavagemSimples', () {
    test('deve retornar zero para quantidade zero', () {
      final resultado = strategy.calcular(0);

      expect(resultado, closeTo(0.0, 0.01));
    });

    test('deve calcular um veículo', () {
      final resultado = strategy.calcular(1);

      expect(resultado, closeTo(35.0, 0.01));
    });

    test('deve calcular dois veículos', () {
      final resultado = strategy.calcular(2);

      expect(resultado, closeTo(70.0, 0.01));
    });

    // 5 × 35 = 175
    test('deve calcular cinco veículos', () {
      final resultado = strategy.calcular(5);

      expect(resultado, closeTo(175.0, 0.01));
    });

    test('deve lançar exceção para quantidade negativa', () {
      expect(() => strategy.calcular(-1), throwsArgumentError);
    });
  });
}
```

```bash
flutter test test/lavagem/strategy/lavagem_simples_test.dart
```

Falha: `LavagemSimples` ainda não existe.

### 2.2 GREEN

`lib/lavagem/strategy/lavagem_simples.dart`

```dart
import 'lavagem_strategy.dart';

class LavagemSimples implements LavagemStrategy {
  @override
  double calcular(int qtd) {
    if (qtd < 0) {
      throw ArgumentError('A quantidade de veículos não pode ser negativa');
    }

    return qtd * 35.0;
  }
}
```

```bash
flutter test test/lavagem/strategy/lavagem_simples_test.dart
```

Resultado: `+5: All tests passed!`

---

## 3. LavagemCompleta

**Regra:** R$ 60,00 por veículo. A partir de 3 veículos tem 10% de desconto sobre o total. Para 1 ou 2 veículos não tem desconto.

### 3.1 RED

`test/lavagem/strategy/lavagem_completa_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_completa.dart';

void main() {
  late LavagemCompleta strategy;

  setUp(() {
    strategy = LavagemCompleta();
  });

  group('LavagemCompleta', () {
    test('deve retornar zero para quantidade zero', () {
      final resultado = strategy.calcular(0);

      expect(resultado, closeTo(0.0, 0.01));
    });

    test('deve calcular um veículo sem desconto', () {
      final resultado = strategy.calcular(1);

      expect(resultado, closeTo(60.0, 0.01));
    });

    test('deve calcular dois veículos sem desconto', () {
      final resultado = strategy.calcular(2);

      expect(resultado, closeTo(120.0, 0.01));
    });

    // 3 × 60 = 180 → com 10% de desconto = 162
    test('deve aplicar desconto a partir de três veículos', () {
      final resultado = strategy.calcular(3);

      expect(resultado, closeTo(162.0, 0.01));
    });

    // 5 × 60 = 300 → com 10% de desconto = 270
    test('deve aplicar desconto em cinco veículos', () {
      final resultado = strategy.calcular(5);

      expect(resultado, closeTo(270.0, 0.01));
    });

    test('deve lançar exceção para quantidade negativa', () {
      expect(() => strategy.calcular(-2), throwsArgumentError);
    });
  });
}
```

```bash
flutter test test/lavagem/strategy/lavagem_completa_test.dart
```

Falha: `LavagemCompleta` ainda não existe.

### 3.2 GREEN

`lib/lavagem/strategy/lavagem_completa.dart`

```dart
import 'lavagem_strategy.dart';

class LavagemCompleta implements LavagemStrategy {
  @override
  double calcular(int qtd) {
    if (qtd < 0) {
      throw ArgumentError('A quantidade de veículos não pode ser negativa');
    }

    final subtotal = qtd * 60.0;

    // a partir de 3 veículos tem 10% de desconto sobre o total
    if (qtd >= 3) {
      return subtotal * 0.9;
    }

    return subtotal;
  }
}
```

O `subtotal` foi separado numa variável para não repetir `qtd * 60.0` nos dois `return`.

```bash
flutter test test/lavagem/strategy/lavagem_completa_test.dart
```

Resultado: `+6: All tests passed!`

---

## 4. LavagemPremium

**Regra:** R$ 100,00 por veículo + taxa fixa de R$ 20,00 cobrada uma vez só por compra. Se a quantidade for zero, a taxa não é cobrada.

### 4.1 RED

`test/lavagem/strategy/lavagem_premium_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_premium.dart';

void main() {
  late LavagemPremium strategy;

  setUp(() {
    strategy = LavagemPremium();
  });

  group('LavagemPremium', () {
    test('deve retornar zero sem cobrar taxa', () {
      final resultado = strategy.calcular(0);

      expect(resultado, closeTo(0.0, 0.01));
    });

    // 1 × 100 + 20 = 120
    test('deve calcular um veículo com taxa', () {
      final resultado = strategy.calcular(1);

      expect(resultado, closeTo(120.0, 0.01));
    });

    // 2 × 100 + 20 = 220
    test('deve calcular dois veículos com taxa única', () {
      final resultado = strategy.calcular(2);

      expect(resultado, closeTo(220.0, 0.01));
    });

    // 5 × 100 + 20 = 520
    test('deve calcular cinco veículos com taxa única', () {
      final resultado = strategy.calcular(5);

      expect(resultado, closeTo(520.0, 0.01));
    });

    test('deve lançar exceção para quantidade negativa', () {
      expect(() => strategy.calcular(-5), throwsArgumentError);
    });
  });
}
```

```bash
flutter test test/lavagem/strategy/lavagem_premium_test.dart
```

Falha: `LavagemPremium` ainda não existe.

### 4.2 GREEN

`lib/lavagem/strategy/lavagem_premium.dart`

```dart
import 'lavagem_strategy.dart';

class LavagemPremium implements LavagemStrategy {
  @override
  double calcular(int qtd) {
    if (qtd < 0) {
      throw ArgumentError('A quantidade de veículos não pode ser negativa');
    }

    // sem veículo a taxa não é cobrada
    if (qtd == 0) {
      return 0.0;
    }

    // taxa de R$ 20,00 cobrada uma vez só por compra
    return qtd * 100.0 + 20.0;
  }
}
```

O `if (qtd == 0)` precisa vir antes da conta. Sem ele, 0 veículos daria R$ 20,00 por causa da taxa.

```bash
flutter test test/lavagem/strategy/lavagem_premium_test.dart
```

Resultado: `+5: All tests passed!`

---

## 5. CalculadoraLavagem

A calculadora **não pode** ter `if`, `switch` nem conta de nenhuma modalidade. Ela recebe a estratégia pelo construtor e só chama o `calcular` dela.

Os testes usam as estratégias de verdade (sem mock).

### 5.1 RED

`test/lavagem/calculadora_lavagem_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:cp_flutter/lavagem/calculadora_lavagem.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_completa.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_premium.dart';
import 'package:cp_flutter/lavagem/strategy/lavagem_simples.dart';

void main() {
  group('CalculadoraLavagem', () {
    test('deve delegar o cálculo de lavagem simples', () {
      // Arrange
      final calculadora = CalculadoraLavagem(LavagemSimples());

      // Act
      final resultado = calculadora.calcular(2);

      // Assert
      expect(resultado, closeTo(70.0, 0.01));
    });

    test('deve delegar o cálculo de lavagem completa', () {
      final calculadora = CalculadoraLavagem(LavagemCompleta());

      final resultado = calculadora.calcular(3);

      expect(resultado, closeTo(162.0, 0.01));
    });

    test('deve delegar o cálculo premium', () {
      final calculadora = CalculadoraLavagem(LavagemPremium());

      final resultado = calculadora.calcular(2);

      expect(resultado, closeTo(220.0, 0.01));
    });

    test('deve propagar exceção de quantidade inválida', () {
      final calculadora = CalculadoraLavagem(LavagemSimples());

      expect(() => calculadora.calcular(-1), throwsArgumentError);
    });
  });
}
```

```bash
flutter test test/lavagem/calculadora_lavagem_test.dart
```

Falha: `CalculadoraLavagem` ainda não existe.

### 5.2 GREEN

`lib/lavagem/calculadora_lavagem.dart`

```dart
import 'strategy/lavagem_strategy.dart';

class CalculadoraLavagem {
  final LavagemStrategy strategy;

  CalculadoraLavagem(this.strategy);

  // a calculadora não conhece as regras, só repassa para a estratégia
  double calcular(int qtd) {
    return strategy.calcular(qtd);
  }
}
```

Como a calculadora só repassa a chamada, a exceção lançada pela estratégia chega direto em quem chamou a calculadora. Por isso o teste de quantidade inválida passa sem nenhum código a mais.

```bash
flutter test test/lavagem/calculadora_lavagem_test.dart
```

Resultado: `+4: All tests passed!`

---

## 6. Rodando todos os testes

```bash
flutter test
```

Resultado: `+20: All tests passed!`

| Classe | Testes |
|--------|-------:|
| LavagemSimples | 5 |
| LavagemCompleta | 6 |
| LavagemPremium | 5 |
| CalculadoraLavagem | 4 |
| **Total** | **20** |

### Matchers usados

- `closeTo(valor, 0.01)` → compara `double` com margem, porque conta com ponto flutuante pode dar diferença pequena (ex.: `180 * 0.9`).
- `throwsArgumentError` → verifica se a função lança `ArgumentError`. Por isso o teste usa `() => strategy.calcular(-1)`, passando uma função e não o resultado.

---

## 7. Entrega

```bash
flutter clean
```

Depois compactar a pasta do projeto em `.zip`.
