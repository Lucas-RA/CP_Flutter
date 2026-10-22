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
