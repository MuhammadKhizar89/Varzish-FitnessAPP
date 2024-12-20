import 'package:flutter/material.dart';
import 'package:varzish/utils/screenConstraints.dart';
import 'package:varzish/widgets/CustomPicker.dart';
import 'package:varzish/widgets/heading.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({
    super.key,
    required this.age,
    required this.setAgeState,
  });
  final int age;
  final void Function(int weight) setAgeState;
  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final List<String> monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  final List<String> dateList =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> yearList = List.generate(
    DateTime.now().year - 10 - 1960 + 1,
    (index) => (1960 + index).toString(),
  );

  @override
  Widget build(BuildContext context) {
    var height = ScreenSize.height(context) * 0.20;
    return SizedBox(
      height: ScreenSize.height(context) * 0.60,
      child: Column(
        children: [
          const Heading(text: "Enter Your Age"),
          SizedBox(
            height: height * 0.80,
          ),
          SizedBox(
            height: height,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: height * 0.40,
                    margin: EdgeInsets.only(bottom: height * 0.14),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(80, 37, 37, 37),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CustomPicker(
                        data: monthList,
                        selectedData: (data) {
                          // print(data);
                        }),
                    Container(
                      width: 2,
                      color: Colors.white,
                    ),
                    CustomPicker(
                        data: dateList,
                        selectedData: (data) {
                          // print(data);
                        }),
                    Container(
                      width: 2,
                      color: Colors.white,
                    ),
                    CustomPicker(
                        data: yearList,
                        selectedData: (data) {
                          widget.setAgeState(int.parse(data));
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
