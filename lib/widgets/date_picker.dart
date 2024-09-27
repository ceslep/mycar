import 'package:flutter/material.dart';
import 'package:mycar/functions/select_date.dart';

Widget buildDatePicker(
    BuildContext context, TextEditingController controller, String label) {
  return Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.green),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  selectDate(context, controller);
                },
                icon: const Icon(Icons.date_range),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
