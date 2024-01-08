import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'components/colors.dart';
import 'edit.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pengeluaranList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    dynamic response = await Supabase.instance.client
        .from('expense')
        .select<List<Map<String, dynamic>>>();
    setState(() {
      pengeluaranList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.dark100,
        primaryColor: AppColors.violet100,
        // ... other theme properties
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Catatan Pengeluaran",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: AppColors.red100,
                      ),
                      onPressed: () {
                        final box = GetStorage();
                        box.remove('username');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) => LoginPage()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildExpenseList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalExpenseCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.blue60,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Pengeluaran",
            style: TextStyle(
              color: AppColors.light100,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "Rp ${calculateTotalExpense()}",
            style: TextStyle(
              color: AppColors.light100,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList() {
    return Column(
      children: [
        _buildTotalExpenseCard(),
        SizedBox(height: 10),
        Text(
          "Daftar Pengeluaran",
          style: TextStyle(
            color: AppColors.light100,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        ...pengeluaranList.map(
          (pengeluaran) => Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildExpenseItem(pengeluaran),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> pengeluaran) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengeluaran['description'],
                      style: TextStyle(
                        color: AppColors.light100,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Rp ${pengeluaran['amount']}",
                      style: TextStyle(
                        color: AppColors.light100,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${formatDate(pengeluaran['created_at'])}",
                      style: TextStyle(
                        color: AppColors.light100,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.yellow100,
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (ctx) => EditPage(
                            id: pengeluaran['id'],
                            description: pengeluaran['description'],
                            amount: pengeluaran['amount'].toString(),
                          ),
                        ),
                      )
                          .then((value) {
                        fetchData();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: AppColors.red100,
                    ),
                    onPressed: () async {
                      await Supabase.instance.client
                          .from('expense')
                          .delete()
                          .match({"id": pengeluaran['id']});
                      fetchData();
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }

  String calculateTotalExpense() {
    double total = 0;
    for (var expense in pengeluaranList) {
      total += expense['amount'];
    }
    return total.toString();
  }
}
