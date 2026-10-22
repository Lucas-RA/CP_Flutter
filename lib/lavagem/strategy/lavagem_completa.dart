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
