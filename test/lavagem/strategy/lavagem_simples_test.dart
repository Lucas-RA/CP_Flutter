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
