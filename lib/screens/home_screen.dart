import 'package:flutter/material.dart';
import '../models/transacao.dart';
import '../services/storage_service.dart';
import '../widgets/grafico_widget.dart';
import 'adicionar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transacao> transacoes = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final dados = await StorageService.carregarTransacoes();

    setState(() {
      transacoes = dados;
    });
  }

  // SALDO TOTAL
  double get saldo {
    double total = 0;

    for (var transacao in transacoes) {
      if (transacao.entrada) {
        total += transacao.valor;
      } else {
        total -= transacao.valor;
      }
    }

    return total;
  }

  // TOTAL DE ENTRADAS
  double get totalEntradas {
    double total = 0;

    for (var t in transacoes) {
      if (t.entrada) {
        total += t.valor;
      }
    }

    return total;
  }

  // TOTAL DE GASTOS
  double get totalGastos {
    double total = 0;

    for (var t in transacoes) {
      if (!t.entrada) {
        total += t.valor;
      }
    }

    return total;
  }

  void adicionarTransacao(Transacao transacao) {
    setState(() {
      transacoes.add(transacao);
    });

    StorageService.salvarTransacoes(
      transacoes,
    );
  }

  void removerTransacao(int index) {
    setState(() {
      transacoes.removeAt(index);
    });

    StorageService.salvarTransacoes(
      transacoes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartCash"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdicionarScreen(),
            ),
          );

          if (resultado != null) {
            adicionarTransacao(resultado);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARD DO SALDO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Saldo Atual",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "R\$ ${saldo.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // GRAFICO
            GraficoWidget(
              entradas: totalEntradas,
              gastos: totalGastos,
            ),

            const SizedBox(height: 20),

            const Text(
              "Transações",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: transacoes.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhuma transação cadastrada",
                      ),
                    )
                  : ListView.builder(
                      itemCount: transacoes.length,
                      itemBuilder: (context, index) {
                        final t = transacoes[index];

                        return Card(
                          child: ListTile(
                            onLongPress: () {
                              removerTransacao(index);
                            },
                            leading: Icon(
                              t.entrada
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: t.entrada ? Colors.green : Colors.red,
                            ),
                            title: Text(
                              t.descricao,
                            ),
                            subtitle: Text(
                              t.entrada ? "Entrada" : "Gasto",
                            ),
                            trailing: Text(
                              "R\$ ${t.valor.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: t.entrada ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
