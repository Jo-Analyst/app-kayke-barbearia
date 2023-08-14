import 'package:app_kaike_barbearia/app/utils/month_slide.dart';
import 'package:flutter/material.dart';

class SlideDate extends StatefulWidget {
  const SlideDate({super.key});

  @override
  State<SlideDate> createState() => _SlideDateState();
}

class _SlideDateState extends State<SlideDate> {
  int indexMonth = int.parse(DateTime.now().month.toString()) - 1;
  int year = int.parse(DateTime.now().year.toString());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(17, 63, 81, 181),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (indexMonth == 0) {
                  indexMonth = 11;
                  year--;
                  return;
                }

                indexMonth--;
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),
          Text(
            "${date[indexMonth]} de $year",
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (indexMonth == 11) {
                  indexMonth = 0;
                  year++;
                  return;
                }
                indexMonth++;
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
