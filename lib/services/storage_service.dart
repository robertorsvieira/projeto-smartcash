import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transacao.dart';

class StorageService {
  static const String chave = "transacoes";

  static Future<void> salvarTransacoes(List<Transacao> transacoes) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> lista = transacoes.map((t) {
      return jsonEncode({
        "descricao": t.descricao,
        "valor": t.valor,
        "entrada": t.entrada,
      });
    }).toList();

    await prefs.setStringList(chave, lista);
  }

  static Future<List<Transacao>> carregarTransacoes() async {
    final prefs = await SharedPreferences.getInstance();

    final lista = prefs.getStringList(chave);

    if (lista == null) {
      return [];
    }

    return lista.map((item) {
      final json = jsonDecode(item);

      return Transacao(
        descricao: json["descricao"],
        valor: json["valor"],
        entrada: json["entrada"],
      );
    }).toList();
  }
}
