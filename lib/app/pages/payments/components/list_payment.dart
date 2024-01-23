import 'package:app_kayke_barbearia/app/pages/payments/components/details_payments.dart';
import 'package:app_kayke_barbearia/app/utils/convert_datetime.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/loading.dart';
import 'package:app_kayke_barbearia/app/utils/modal.dart';
import 'package:flutter/material.dart';


class ListPayment extends StatelessWidget {
  final List<Map<String, dynamic>> payments;
  final String typePayment;
  final bool isService;
  final bool isLoading;

  const ListPayment({
    required this.isLoading,
    required this.isService,
    required this.typePayment,
    required this.payments,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: loading(context, 50),
          )
        : payments.isEmpty
            ? Center(
                child: Text(
                  typePayment == "vendas"
                      ? "Não há registro da venda."
                      : "Não há registro do serviço.",
                  style: const TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: payments.length,
                itemBuilder: (_, index) {
                  final nameCompleted =
                      payments[index]["client_name"].toString().split(" ");

                  String nameClient = nameCompleted.length > 1
                      ? "${nameCompleted[0]} ${nameCompleted[nameCompleted.length - 1]}"
                      : payments[index]["client_name"].toString();
                  return Column(
                    children: [
                      ListTile(
                        onTap: () => showModal(
                          context,
                          DetailsPayment(
                            isService: isService,
                            payment: payments[index],
                          ),
                        ),
                        leading: Chip(
                          backgroundColor: Colors.indigo.withOpacity(.2),
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              numberFormat
                                  .format(payments[index]["value_total"]),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            changeTheDateWriting(payments[index]["date"]),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        subtitle: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            nameClient,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        trailing: Text(
                          payments[index]["situation"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  );
                },
              );
  }
}
