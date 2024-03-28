import 'package:flutter/material.dart';

import 'botom_bar_widget.dart';

class HomePage extends StatelessWidget {
 const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          Center(child: Text('Home Page')),
          Center(child: Text('Income Page')),
          Center(child: Text('Expense Page')),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        pageController: pageController,
      ),
    );
  
  }
}
