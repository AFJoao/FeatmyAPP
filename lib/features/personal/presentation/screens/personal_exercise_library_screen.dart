import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalExerciseLibraryScreen extends StatefulWidget {
  const PersonalExerciseLibraryScreen({super.key});

  @override
  State<PersonalExerciseLibraryScreen> createState() =>
      _PersonalExerciseLibraryScreenState();
}

class _PersonalExerciseLibraryScreenState
    extends State<PersonalExerciseLibraryScreen> {
  int _selectedIndex = 2;

  final Map<String, List<String>> _exercises = {
    'Peito': ['Supino Reto', 'Flexão de Braços', 'Crucifixo com Halteres'],
    'Costas': ['Remada Curvada', 'Puxada Alta (Pulley)'],
    'Pernas': ['Agachamento Livre', 'Leg Press'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B2B2A),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biblioteca de',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Exercícios',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.grid_view, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _exercises.entries.map((entry) {
              return _buildExerciseCategory(entry.key, entry.value);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF22C55E),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildExerciseCategory(String category, List<String> exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        ...exercises.map((exercise) {
          return _buildExerciseItem(exercise);
        }).toList(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildExerciseItem(String exerciseName) {
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
            child: const Icon(Icons.fitness_center,
                color: Color(0xFF22C55E), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              exerciseName,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: const Color(0xFF22C55E),
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.black, size: 20),
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
