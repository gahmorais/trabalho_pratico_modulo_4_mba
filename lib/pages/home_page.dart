import 'package:app/models/address.dart';
import 'package:app/services/postal_code_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  final cepService = PostalCodeService();
  Future<Address>? cepFuture;
  @override
  void initState() {
    super.initState();
  }

  Text titleText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    );
  }

  Text descriptionText(String text) {
    return Text(style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic), text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar CEP"),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(hintText: "Digite o CEP", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final cep = _controller.text;
                final addressResult = cepService.getAddress(cep);
                setState(() {
                  cepFuture = addressResult;
                });
              },
              child: Text("Buscar"),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder<Address>(
                future: cepFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Ocorreu um erro");
                  }
                  if (snapshot.hasData) {
                    final address = snapshot.data!;
                    return Column(
                      children: [
                        Row(
                          children: [
                            titleText("Endereço:"),
                            SizedBox(
                              width: 10.0,
                            ),
                            descriptionText(address.street)
                          ],
                        ),
                        Row(
                          children: [
                            titleText("Bairro:"),
                            SizedBox(
                              width: 10.0,
                            ),
                            descriptionText(address.district)
                          ],
                        ),
                        Row(
                          children: [
                            titleText("Cidade:"),
                            SizedBox(
                              width: 10.0,
                            ),
                            descriptionText(address.city)
                          ],
                        ),
                        Row(
                          children: [
                            titleText("Estado:"),
                            SizedBox(
                              width: 10.0,
                            ),
                            descriptionText(address.state)
                          ],
                        ),
                        Row(
                          children: [
                            titleText("CEP:"),
                            SizedBox(
                              width: 10.0,
                            ),
                            descriptionText(address.postalCode)
                          ],
                        )
                      ],
                    );
                  }
                  return Text("");
                })
          ],
        ),
      )),
    );
  }
}
