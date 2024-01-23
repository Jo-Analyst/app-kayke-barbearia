import 'package:app_kayke_barbearia/app/utils/month_slide.dart';
import 'package:flutter/material.dart';

class SlideDate extends StatefulWidget {
  final Function(int month, int year) onGetDate;
  final int? year;
  final int? month;
  const SlideDate({
    this.year,
    this.month,
    required this.onGetDate,
    super.key,
  });

  @override
  State<SlideDate> createState() => _SlideDateState();
}

class _SlideDateState extends State<SlideDate> {
  int _indexMonth = DateTime.now().month;
  int _year = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _year = widget.year!;
    _indexMonth = widget.month!;
    widget.onGetDate(
      _indexMonth,
      _year,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_indexMonth == 0) {
                  _indexMonth = 11;
                  _year--;
                  return;
                }

                _indexMonth--;
              });

              widget.onGetDate(_indexMonth, _year);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Theme.of(context).primaryColor,
              size: 40,
            ),
          ),
          Text(
            "${date[_indexMonth]} de $_year",
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (_indexMonth == 11) {
                  _indexMonth = 0;
                  _year++;
                  return;
                }
                _indexMonth++;
              });
              widget.onGetDate(_indexMonth, _year);
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
