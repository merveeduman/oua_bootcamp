import 'package:flutter/material.dart';
import 'package:lawyer/screens/ai_page.dart';
import 'package:lawyer/screens/appointment_page.dart';
import 'package:lawyer/screens/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _page,
          onPageChanged: ((value) {
            setState(() {
              currentPage = value;
            });
          }),
          children: <Widget>[
            const HomePage(),
            const AppointmentPage(),
            const AiPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (page) {
            setState(() {
              currentPage = page;
              _page.animateToPage(
                page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.scaleBalanced),
              label: 'Ana sayfa',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
              label: 'Randevular',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.message),
              label: 'Destek Al',
            ),
          ],
        ));
  }
}
