import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/kategori.dart';
import 'package:flutter_application_1/components/colors.dart';
import 'package:flutter_application_1/tambah.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AppColors.dark50,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.dark25.withOpacity(0.8),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(null),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
          ],
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return TambahPage();
      case 2:
        return KategoriPage();
      default:
        return HomePage();
    }
  }

  Widget _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
        child: Icon(Icons.add, size: 32, color: AppColors.light100),
        backgroundColor: Colors.blue,
        elevation: 2,
      ),
    );
  }
}
