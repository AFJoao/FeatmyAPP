import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class WorkoutDetailScreen extends ConsumerStatefulWidget {
  final String workoutId;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutId,
  });

  @override
  ConsumerState<WorkoutDetailScreen> createState() =>
      _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends ConsumerState<WorkoutDetailScreen>
    with TickerProviderStateMixin {
  int _currentExerciseIndex = 0;
  bool _isWorkoutStarted = false;
  bool _isWorkoutCompleted = false;
  Timer? _restTimer;
  int _restTimeRemaining = 0;
  bool _isResting = false;

  late AnimationController _progressController;
  late TabController _tabController;

  final List<Map<String, dynamic>> _exercises = [
    {
      'name': 'Supino Reto',
      'sets': 3,
      'reps': '10-12',
      'rest': '45s',
      'tips': 'Mantenha os pés apoiados no chão',
      'muscle': 'Peito, Tríceps',
      'completed': false,
      'image': 'assets/images/supino.jpg',
    },
    {
      'name': 'Crucifixo Inclinado',
      'sets': 3,
      'reps': '12-15',
      'rest': '45s',
      'tips': 'Movimento controlado e amplitude completa',
      'muscle': 'Peito',
      'completed': false,
      'image': 'assets/images/crucifixo.jpg',
    },
    {
      'name': 'Tríceps Pulley',
      'sets': 4,
      'reps': '10',
      'rest': '60s',
      'tips': 'Extensão completa do braço',
      'muscle': 'Tríceps',
      'completed': false,
      'image': 'assets/images/triceps.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    _progressController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _startWorkout() {
    setState(() {
      _isWorkoutStarted = true;
    });
    _progressController.forward();
  }

  void _completeExercise() {
    setState(() {
      _exercises[_currentExerciseIndex]['completed'] = true;
    });

    if (_currentExerciseIndex < _exercises.length - 1) {
      _startRestTimer();
    } else {
      _completeWorkout();
    }
  }

  void _startRestTimer() {
    final restSeconds = int.parse(
      _exercises[_currentExerciseIndex]['rest'].replaceAll('s', ''),
    );

    setState(() {
      _isResting = true;
      _restTimeRemaining = restSeconds;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _restTimeRemaining--;
      });

      if (_restTimeRemaining <= 0) {
        timer.cancel();
        setState(() {
          _isResting = false;
          _currentExerciseIndex++;
        });
      }
    });
  }

  void _completeWorkout() {
    setState(() {
      _isWorkoutCompleted = true;
    });
    _showWorkoutCompletedDialog();
  }

  void _showWorkoutCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2D4A42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF22C55E),
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Parabéns!',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Treino concluído com sucesso!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Voltar',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B2B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B2B2A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Treino A: Peito e Tríceps',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!_isWorkoutStarted)
              _buildWorkoutPreview()
            else if (_isWorkoutCompleted)
              _buildWorkoutCompletedView()
            else
              _buildActiveWorkout(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutPreview() {
    return Column(
      children: [
        const SizedBox(height: 24),
        ..._exercises.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> exercise = entry.value;
          return _buildExercisePreviewCard(exercise, index);
        }).toList(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _startWorkout,
              child: Text(
                'Concluir Exercício',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildExercisePreviewCard(Map<String, dynamic> exercise, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4A42),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFD4A574),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image, color: Colors.grey, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name'],
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise['sets']} séries de ${exercise['reps']} reps',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (index == 0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.play_arrow, color: Color(0xFF22C55E), size: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveWorkout() {
    final currentExercise = _exercises[_currentExerciseIndex];

    return Column(
      children: [
        const SizedBox(height: 24),
        _buildCurrentExerciseCard(currentExercise),
        const SizedBox(height: 24),
        if (_isResting) _buildRestTimer() else _buildNextExercises(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _completeExercise,
              child: Text(
                'Concluir Exercício',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCurrentExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4A42),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A574),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, color: Colors.grey, size: 48),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise['name'],
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${exercise['sets']} séries de ${exercise['reps']} reps',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2A2A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tempo de Descanso',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  exercise['rest'],
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestTimer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2D4A42),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Descansando...',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '00:${_restTimeRemaining.toString().padLeft(2, '0')}',
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextExercises() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2D4A42),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRÓXIMOS EXERCÍCIOS',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              ..._exercises
                  .asMap()
                  .entries
                  .skip(_currentExerciseIndex + 1)
                  .map((entry) {
                int index = entry.key;
                Map<String, dynamic> exercise = entry.value;
                return _buildNextExerciseItem(exercise);
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextExerciseItem(Map<String, dynamic> exercise) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFD4A574),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.grey, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${exercise['sets']} séries de ${exercise['reps']} reps',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${exercise['rest']} Descanso',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCompletedView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF22C55E),
              size: 80,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Parabéns!',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Treino concluído com sucesso!',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
