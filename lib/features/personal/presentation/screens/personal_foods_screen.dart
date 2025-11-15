import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalFoodsScreen extends StatefulWidget {
  const PersonalFoodsScreen({super.key});

  @override
  State<PersonalFoodsScreen> createState() => _PersonalFoodsScreenState();
}

class _PersonalFoodsScreenState extends State<PersonalFoodsScreen> {
  int _selectedIndex = 3;

  final List<Map<String, dynamic>> _foods = [
    {
      'name': 'Frango Grelhado',
      'calories': '165 kcal',
      'protein': 'P: 31g',
      'carbs': 'C: 0g',
      'fat': 'G: 3.6g',
      'icon': Icons.favorite,
    },
    {
      'name': 'Arroz Integral',
      'calories': '111 kcal',
      'protein': 'P: 2.6g',
      'carbs': 'C: 23g',
      'fat': 'G: 0.9g',
      'icon': Icons.grain,
    },
    {
      'name': 'Abacate',
      'calories': '160 kcal',
      'protein': 'P: 2g',
      'carbs': 'C: 9g',
      'fat': 'G: 15g',
      'icon': Icons.eco,
    },
    {
      'name': 'Whey Protein',
      'calories': '120 kcal',
      'protein': 'P: 24g',
      'carbs': 'C: 3g',
      'fat': 'G: 1g',
      'icon': Icons.local_drink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B2B2A),
        elevation: 0,
        title: Text(
          'Meus Alimentos',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF22C55E),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, color: Colors.black, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Adicionar Alimento',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _foods.length,
              itemBuilder: (context, index) {
                final food = _foods[index];
                return _buildFoodCard(food);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4A42),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(food['icon'],
                color: const Color(0xFF22C55E), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food['name'],
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${food['calories']} ${food['protein']}, ${food['carbs']}, ${food['fat']}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B2B2A),
        border: Border(
          top: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B2B2A),
        selectedItemColor: const Color(0xFF22C55E),
        unselectedItemColor: Colors.grey[600],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined),
            activeIcon: Icon(Icons.restaurant),
            label: 'Dietas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
