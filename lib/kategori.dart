import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/app_button.dart';
import 'package:flutter_application_1/components/app_text_field.dart';
import 'package:flutter_application_1/components/colors.dart';

class KategoriPage extends StatefulWidget {
  @override
  _KategoriPageState createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  List<String> kategoriList = [];
  TextEditingController kategoriController = TextEditingController();

  void tambahKategori() {
    if (kategoriController.text.isNotEmpty) {
      setState(() {
        kategoriList.add(kategoriController.text);
      });
      kategoriController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kategori Pengeluaran',
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: AppColors.dark100,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Add any action on the info icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: kategoriController,
              label: 'Nama Kategori',
              fillColor: AppColors.dark25,
              labelColor: AppColors.light60,
            ),
            const SizedBox(height: 16),
            AppButton(
              onPressed: () {
                tambahKategori();
              },
              text: 'Tambah Kategori',
              color: AppColors.blue100,
            ),
            const SizedBox(height: 16),
            Text(
              'Daftar Kategori:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.light100,
              ),
            ),
            const SizedBox(height: 8),
            if (kategoriList.isNotEmpty)
              Column(
                children: kategoriList
                    .map((kategori) => Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(kategori),
                            onTap: () {
                              // Example: Navigator.push(...);
                            },
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
      backgroundColor: AppColors.dark100,
    );
  }
}
