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
