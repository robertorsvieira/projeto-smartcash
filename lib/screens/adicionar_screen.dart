import 'package:flutter/material.dart';
import '../models/transacao.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class AdicionarScreen extends StatefulWidget {
  const AdicionarScreen({super.key});

  @override
  State<AdicionarScreen> createState() => _AdicionarScreenState();
}

class _AdicionarScreenState extends State<AdicionarScreen> {
  final descricaoController = TextEditingController();

  final valorController = TextEditingController();

  bool entrada = true;

  void salvar() {
    if (descricaoController.text.isEmpty || valorController.text.isEmpty) {
      return;
    }
    try {
      double valor = double.parse(valorController.text);

      if (valor <= 0) {
        return;
      }
    } catch (e) {
      return;
    }

    final transacao = Transacao(
      descricao: descricaoController.text,
      valor: double.parse(valorController.text),
      entrada: entrada,
    );

    Navigator.pop(context, transacao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              label: "Descrição",
              controller: descricaoController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Valor",
              controller: valorController,
            ),
            const SizedBox(height: 20),
            DropdownButton<bool>(
              value: entrada,
              items: const [
                DropdownMenuItem(
                  value: true,
                  child: Text("Entrada"),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text("Gasto"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  entrada = value!;
                });
              },
            ),
            const SizedBox(height: 30),
            CustomButton(
              texto: "Salvar",
              onPressed: salvar,
            )
          ],
        ),
      ),
    );
  }
}
