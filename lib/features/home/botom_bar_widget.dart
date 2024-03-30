import 'package:flutter/material.dart';
import 'package:itracker/l10n/app_loc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final PageController pageController;

  const CustomBottomNavigationBar({
    super.key,
    required this.pageController,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        _currentIndex = widget.pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: Adaptive.h(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                widget.pageController.jumpToPage(0);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.wallet,
                    color: _currentIndex == 0 ? Colors.white : Colors.grey,
                  ),
                  if (_currentIndex == 0)
                    Text(
                      context.loc.income,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                widget.pageController.jumpToPage(1);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: _currentIndex == 1 ? Colors.white : Colors.grey,
                  ),
                  if (_currentIndex == 1)
                    Text(
                      context.loc.expense,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                widget.pageController.jumpToPage(2);
              },
              child: Column(
                children: [
                  Icon(
                    Icons.pie_chart,
                    color: _currentIndex == 2 ? Colors.white : Colors.grey,
                  ),
                  if (_currentIndex == 2)
                    Text(
                      context.loc.statistics,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
