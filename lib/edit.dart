import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPage extends StatefulWidget {
  final String description;
  final String amount;
  final int id;

  const EditPage({
    Key? key,
    required this.amount,
    required this.description,
    required this.id,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController keteranganController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    keteranganController.text = widget.description;
    amountController.text = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Set dark theme globally
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
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
                      "Edit Page",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back, // Change this icon to your desired back button
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Go back to the previous page
                      },
                    ),
                  ], // Tambah kurung kurawal untuk menutup children
                ),
                const SizedBox(
                  height: 30,
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
                  text: "Simpan",
                  color: Color(0xFF323232),
                  onPressed: () async {
                    await Supabase.instance.client.from('expense').update(
                      {
                        'description': keteranganController.text,
                        'amount': amountController.text
                      },
                    ).match(
                      {'id': widget.id},
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ], // Tambah kurung kurawal untuk menutup children
            ),
          ),
        ),
      ),
    );
  }
}
