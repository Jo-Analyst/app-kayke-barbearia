import 'package:app_kaike_barbearia/app/pages/home_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class SaleCompleted extends StatelessWidget {
  final double saleTotal;
  final Map<String, dynamic> payment;
  const SaleCompleted(
      {required this.payment, required this.saleTotal, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprovante"),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.close, size: 30,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    color: Colors.indigo.withOpacity(.1),
                    child: Column(
                      children: [
                        const Text(
                          "Venda concluída com sucesso.",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        Icon(
                          Icons.check_circle_outline,
                          size: 70,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 15),
                       const Text(
                          "Valor Total",
                          style:  TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          numberFormat.format(saleTotal),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          color: const Color.fromARGB(28, 0, 0, 0),
                          child: ListTile(
                            minLeadingWidth: 0,
                            leading: Icon(
                              payment["icon"],
                              color: Colors.black,
                              size: 25,
                            ),
                            title: Text(
                              payment["specie"].toString().toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              payment["client"].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 66, 65, 65),
                              ),
                            ),
                            trailing: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                numberFormat.format(payment["amount_received"]),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Fechar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
