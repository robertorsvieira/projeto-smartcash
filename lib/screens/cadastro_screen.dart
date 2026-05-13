import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void cadastrar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastro realizado"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              label: "Nome",
              controller: nomeController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Senha",
              controller: senhaController,
              obscure: true,
            ),
            const SizedBox(height: 30),
            CustomButton(
              texto: "Cadastrar",
              onPressed: cadastrar,
            )
          ],
        ),
      ),
    );
  }
}
