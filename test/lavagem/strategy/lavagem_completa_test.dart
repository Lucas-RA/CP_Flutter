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
