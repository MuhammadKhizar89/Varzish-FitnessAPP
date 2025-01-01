import 'package:flutter/material.dart';
import 'package:varzish/local_storage/user_info.dart';
import 'package:varzish/models/userInfo.dart';
import 'package:varzish/utils/AppColors.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  late Userinfo? userInfo = Userinfo(
      Plan: "Beginner",
      Height: "3'0",
      Weight: 50,
      age: DateTime.now().year - 1960);
  Future<void> getUser() async {
    Userinfo? user = await getUserInfo();
    setState(() {
      userInfo = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      color: const Color.fromARGB(255, 223, 223, 223),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Account Info",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26)),
          Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomLabel(
                      Icons.paste_outlined, "Select Plan", userInfo!.Plan),
                  const Divider(),
                  CustomLabel(Icons.cake, "Age", userInfo!.age),
                  const Divider(),
                  CustomLabel(Icons.height, "Height", "${userInfo!.Height} ft"),
                  const Divider(),
                  CustomLabel(Icons.monitor_weight_outlined, "Weight",
                      "${userInfo!.Weight} kg"),
                ],
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              deleteUserInfoLocal();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/onboarding', (Route<dynamic> route) => false);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restart_alt_sharp,
                  color: Colors.white,
                ),
                Text(
                  "Reset Plan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomLabel(IconData icon, String label, Object value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.black, size: 30),
        const SizedBox(width: 6),
        Text("${label}:",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        const SizedBox(width: 10),
        Text("$value",
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
      ],
    );
  }
}
