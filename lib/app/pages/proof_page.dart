import 'package:app_kaike_barbearia/app/pages/home_page.dart';
import 'package:app_kaike_barbearia/app/utils/convert_values.dart';
import 'package:flutter/material.dart';

class ProofPage extends StatelessWidget {
  final double saleTotal;
  final bool isSale;
  final Map<String, dynamic> payment;
  const ProofPage({required this.isSale,required this.payment, required this.saleTotal, super.key});

  @override
  Widget build(BuildContext context) {
    closeScreen() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprovante"),
        leading: IconButton(
          onPressed: () => closeScreen(),
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
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
                         Text(
                          isSale ? "Venda concluída com sucesso." : "Prestação de serviço concluído",
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          payment["date"],
                          style: const TextStyle(fontSize: 18),
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
                          style: TextStyle(
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
                            subtitle: payment["client"]
                                        .toString()
                                        .toLowerCase() ==
                                    "cliente avulso"
                                ? null
                                : Text(
                                    payment["client"].toString().split(" ")[0],
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
                onPressed: () => closeScreen(),
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
