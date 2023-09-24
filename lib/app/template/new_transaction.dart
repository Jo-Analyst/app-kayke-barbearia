import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/client_form_page.dart';
import '../pages/product_form_page.dart';
import '../pages/provision_of_service_page.dart';
import '../pages/sale_page.dart';
import '../pages/service_form_page.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.withOpacity(.1),
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2 - 100,
        child: ListView(
          children: [
            const Text(
              "Novo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProvisionOfServicePage(),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(22),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cut,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Prestação de serviço",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SalePage(),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(22),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Realizar venda",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Cadastro",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ClientFormPage(
                          isEdition: false,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3 - 16,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              color: Colors.indigo,
                            ),
                            Text(
                              "Cliente",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProductFormPage(
                          isEdition: false,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3 - 16,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.box,
                              color: Colors.indigo,
                            ),
                            Text(
                              "Produto",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ServiceFormPage(
                          isEdition: false,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3 - 16,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.screwdriverWrench,
                              color: Colors.indigo,
                            ),
                            Text(
                              "Serviço",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
