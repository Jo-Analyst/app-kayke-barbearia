import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ServiceFormPage extends StatefulWidget {
  final int? serviceId;
  final bool isEdition;
  final String? description;
  final double? price;
  final String? observation;
  const ServiceFormPage({
    this.serviceId,
    required this.isEdition,
    this.description,
    this.price,
    this.observation,
    super.key,
  });

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final serviceValueController = MoneyMaskedTextController(leftSymbol: "R\$ ");
  final descriptionController = TextEditingController();
  final observationController = TextEditingController();
  DateTime dateSelected = DateTime.now();
  TimeOfDay timeSelected = TimeOfDay.now();
  String _description = "";
  double priceService = 0;

  showCalendarPicker() {
    showDatePicker(
      context: context,
      initialDate: dateSelected,
      firstDate: DateTime(2014),
      lastDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null) {
          dateSelected = date;
        }
      }),
    );
  }

  // showTime() {
  //   showTimePicker(context: context, initialTime: timeSelected)
  //       .then((time) {
  //     setState(() {
  //       timeSelected = time ?? timeSelected;
  //     });
  //   });
  // }
  
  @override
  void initState() {
    super.initState();

    if (!widget.isEdition) return;
    _description = widget.description ?? "";
    descriptionController.text = _description;
    priceService = widget.price ?? 0.0;
    serviceValueController.updateValue(priceService);
    observationController.text = widget.observation ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serviço"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed:
                  _description.isNotEmpty && priceService > 0 ? () {} : null,
              icon: const Icon(
                Icons.check,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 18,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: descriptionController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: "Serviço*"),
              style: const TextStyle(fontSize: 18),
              onChanged: (description) {
                setState(() {
                  _description = description.trim();
                });
              },
            ),
            TextFormField(
              controller: serviceValueController,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Valor do serviço"),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                setState(() {
                  priceService = serviceValueController.numberValue;
                });
              },
            ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         IconButton(
            //           onPressed: () => showCalendarPicker(),
            //           icon: Icon(
            //             Icons.calendar_month_outlined,
            //             size: 35,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () => showCalendarPicker(),
            //           child: Text(
            //             dateFormat3.format(dateSelected),
            //             style: const TextStyle(fontSize: 20),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         IconButton(
            //           onPressed: () => showTime(),
            //           icon: Icon(
            //             Icons.timer_outlined,
            //             size: 35,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () => showTime(),
            //           child: Text(
            //             timeSelected.format(context),
            //             style: const TextStyle(fontSize: 20),
            //           ),
            //         ),
            //       ],
            //     )
            //   ],
            // ),
            TextFormField(
              controller: observationController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: "Observação (opcional)"),
              style: const TextStyle(fontSize: 18),
              maxLength: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
