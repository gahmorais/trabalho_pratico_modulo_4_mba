import 'package:app/models/address.dart';
import 'package:app/models/errors.dart';
import 'package:app/services/postal_code_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final cepService = PostalCodeService();
  Future<Address>? cepFuture;
  @override
  void initState() {
    super.initState();
  }

  Text titleText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  Text descriptionText(String? text) {
    return Text(style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic), text ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar CEP"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 18.0),
              decoration:
                  const InputDecoration(hintText: "Digite o CEP", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final cep = _controller.text;
                final addressResult = cepService.getAddress(cep);
                setState(() {
                  cepFuture = addressResult;
                });
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50.0)),
              child: const Text("Buscar"),
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder<Address>(
                future: cepFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      final error = snapshot.error as CepExpection;
                      return Text(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade400),
                          error.error);
                    }
                    if (snapshot.hasData) {
                      final address = snapshot.data!;
                      return Column(
                        children: [
                          Row(
                            children: [
                              titleText("Endereço:"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              descriptionText(address.street)
                            ],
                          ),
                          Row(
                            children: [
                              titleText("Bairro:"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              descriptionText(address.district)
                            ],
                          ),
                          Row(
                            children: [
                              titleText("Cidade:"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              descriptionText(address.city)
                            ],
                          ),
                          Row(
                            children: [
                              titleText("Estado:"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              descriptionText(address.state)
                            ],
                          ),
                          Row(
                            children: [
                              titleText("CEP:"),
                              const SizedBox(
                                width: 10.0,
                              ),
                              descriptionText(address.postalCode)
                            ],
                          )
                        ],
                      );
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return const Text("");
                })
          ],
        ),
      )),
    );
  }
}
