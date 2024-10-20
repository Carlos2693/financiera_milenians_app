import 'package:financiera_milenians_app/presentation/screen/screens.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String nameProfitTab = 'Profit';
  static const String nameCardsTab = 'Cards';
  
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final Map<String, IconData> mapBottomNavigationData = {
    MainScreen.nameProfitTab: Icons.savings,
    MainScreen.nameCardsTab: Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: const [
            ProfitScreen(),
            CardsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: mapBottomNavigationData.entries
            .map(
              (entry) => BottomNavigationBarItem(
                icon: Icon(entry.value),
                label: entry.key,
              ),
            )
            .toList(),
      ),
    );
  }
}
