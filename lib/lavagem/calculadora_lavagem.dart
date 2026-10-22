import 'strategy/lavagem_strategy.dart';

class CalculadoraLavagem {
  final LavagemStrategy strategy;

  CalculadoraLavagem(this.strategy);

  // a calculadora não conhece as regras, só repassa para a estratégia
  double calcular(int qtd) {
    return strategy.calcular(qtd);
  }
}
