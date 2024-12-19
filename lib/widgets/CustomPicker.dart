import 'package:flutter/material.dart';

class CustomPicker extends StatefulWidget {
  CustomPicker({required this.data});
  final List<Object> data;
  @override
  State<CustomPicker> createState() {
    return _CustomPickerState();
  }
}

class _CustomPickerState extends State<CustomPicker> {
  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListWheelScrollView.useDelegate(
        perspective: 0.010,
        itemExtent: 60,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: widget.data.length,
          builder: (context, index) {
            return Text(
              "${widget.data[index]}",
              style: TextStyle(
                  color: selectedValue == index
                      ? Color.fromARGB(255, 195, 255, 120)
                      : Color.fromARGB(255, 166, 166, 166),
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            );
          },
        ),
      ),
    );
  }
}
