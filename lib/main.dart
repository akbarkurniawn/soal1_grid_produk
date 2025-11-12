import 'package:flutter/material.dart';

void main() {
  runApp(DayanaCafeApp());
}

class DayanaCafeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dayana Coffee & Eatery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF7F3EF),
      ),
      home: MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Makanan', 'Minuman', 'Camilan'];

  final List<List<Map<String, String>>> _menuData = [
    [
      {'name': 'Nasi Goreng', 'image': 'assets/images/nasi_goreng.jpg', 'price': 'Rp20.000'},
      {'name': 'Kwetiau Seafood', 'image': 'assets/images/kwetiau_goreng.jpeg', 'price': 'Rp23.000'},
      {'name': 'Ayam Goreng Lengkuas', 'image': 'assets/images/ayam_lengkuas.jpg', 'price': 'Rp20.000'},
      {'name': 'Sop Konro', 'image': 'assets/images/sop_konro.jpg', 'price': 'Rp45.000'},
    ],
    [
      {'name': 'Latte', 'image': 'assets/images/latte.jpg', 'price': 'Rp17.000'},
      {'name': 'Es Teh Manis', 'image': 'assets/images/es_teh.jpg', 'price': 'Rp8.000'},
      {'name': 'Jus Alpukat', 'image': 'assets/images/jus_alpukat.jpg', 'price': 'Rp17.000'},
      {'name': 'Milkshake', 'image': 'assets/images/milkshake.jpg', 'price': 'Rp15.000'},
    ],
    [
      {'name': 'Kentang Goreng', 'image': 'assets/images/kentang_goreng.jpg', 'price': 'Rp15.000'},
      {'name': 'Pisang Coklat', 'image': 'assets/images/pisang_goreng.jpg', 'price': 'Rp10.000'},
      {'name': 'Roti Bakar', 'image': 'assets/images/roti_bakar.jpeg', 'price': 'Rp15.000'},
      {'name': 'Tahu Walik', 'image': 'assets/images/tahu_walik.jpg', 'price': 'Rp13.000'},
    ],
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = _titles[_selectedIndex];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4E342E), Color(0xFF6D4C41)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: SafeArea(
            child: Center(
              child: Text(
                'Menu Dayana Coffee & Eatery - $title',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: MenuPage(
          key: ValueKey(title),
          items: _menuData[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D4C41), Color(0xFF3E2723)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[200],
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Makanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_cafe),
              label: 'Minuman',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Camilan',
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Map<String, String>> items;

  const MenuPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // dua kolom
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          shadowColor: Colors.brown.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF3E0), Color(0xFFD7CCC8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 1, // pastikan ukuran gambar persegi dan konsisten
                    child: Image.asset(
                      items[index]['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.brown, size: 50),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        items[index]['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E2723),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['price']!,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
