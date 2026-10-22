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
