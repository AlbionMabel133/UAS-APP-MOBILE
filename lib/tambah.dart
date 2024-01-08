import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahPage extends StatelessWidget {
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void resetForm() {
    keteranganController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Catat\nPengeluaran",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons
                            .arrow_back, // Change this icon to your desired back button
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Go back to the previous page
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: keteranganController,
                  label: "Keterangan",
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: amountController,
                  label: "Jumlah Pengeluaran",
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  onPressed: () async {
                    await Supabase.instance.client.from('expense').insert({
                      'amount': int.parse(amountController.text),
                      'description': keteranganController.text
                    });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Bottom()));
                  },
                  text: "Simpan",
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5,
                ),
                AppButton(
                  text: "Reset",
                  color: Colors.grey.shade200,
                  textColor: Colors.black,
                  onPressed: () {
                    resetForm();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
