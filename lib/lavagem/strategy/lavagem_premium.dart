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
