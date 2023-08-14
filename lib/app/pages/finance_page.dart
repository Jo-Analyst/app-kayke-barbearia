import 'package:app_kaike_barbearia/app/template/finance_sales.dart';
import 'package:app_kaike_barbearia/app/template/finance_services.dart';
import 'package:app_kaike_barbearia/app/template/finance_spending.dart';
import 'package:app_kaike_barbearia/app/template/slide_date.dart';
import 'package:flutter/material.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  List<Widget> components = [
    const FinanceSales(),
    const FinanceServices(),
    const FinanceSpending(),
  ];
  int indexSlide = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 10,
            width: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: components.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == indexSlide ? Colors.indigo : null,
                    border: index != indexSlide
                        ? Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
         const SlideDate(),
          SizedBox(
            height: MediaQuery.of(context).size.height - 30,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    indexSlide = value;
                  });
                },
                itemCount: components.length,
                itemBuilder: (_, index) {
                  return components[index];
                }),
          )
        ],
      ),
    );
  }
}
