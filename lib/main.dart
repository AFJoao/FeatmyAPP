import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

// Ajuste de caminhos de acordo com a sua estrutura
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'features/auth/presentation/screens/role_selection_screen.dart';
import 'features/personal/presentations/screens/personal_dashboard_screen.dart';
import 'features/personal/presentation/screens/personal_home_screen.dart';
import 'features/personal/presentation/screens/personal_students_screen.dart';
import 'features/personal/presentation/screens/personal_student_details_screen.dart';
import 'features/personal/presentation/screens/personal_exercise_library_screen.dart';
import 'features/personal/presentation/screens/personal_create_exercise_screen.dart';
import 'features/personal/presentation/screens/personal_foods_screen.dart';
import 'features/personal/presentation/screens/personal_add_food_screen.dart';
import 'features/personal/presentation/screens/personal_profile_screen.dart';
import 'features/personal/presentation/screens/personal_settings_screen.dart';
import 'features/student/presentation/screens/student_dashboard_screen.dart';
import 'features/workout/presentation/screens/workout_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    const ProviderScope(
      child: FitDayApp(),
    ),
  );
}

class FitDayApp extends ConsumerWidget {
  const FitDayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FitDay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}

// Core Theme Configuration
class AppTheme {
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color secondaryColor = Color(0xFF84CC16);
  static const Color accentColor = Color(0xFFF97316);
  static const Color surfaceColor = Color(0xFFFAFAFA);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFF59E0B);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      surface: surfaceColor,
      error: errorColor,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: GoogleFonts.inter(
        color: Colors.grey[600],
        fontSize: 16,
      ),
    ),
    cardTheme: CardThemeData(
      color: backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[200]!),
      ),
    ),
  );
}

// Router Configuration
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/role-selection',
    routes: [
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/personal-dashboard',
        builder: (context, state) => const PersonalDashboardScreen(),
      ),
      GoRoute(
        path: '/student-dashboard',
        builder: (context, state) => const StudentDashboardScreen(),
      ),
      GoRoute(
        path: '/workout/:id',
        builder: (context, state) => WorkoutDetailScreen(
          workoutId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/personal-home',
        builder: (context, state) => const PersonalHomeScreen(),
      ),
      GoRoute(
        path: '/personal-students',
        builder: (context, state) => const PersonalStudentsScreen(),
      ),
      GoRoute(
        path: '/personal-student-details',
        builder: (context, state) => const PersonalStudentDetailsScreen(),
      ),
      GoRoute(
        path: '/personal-exercise-library',
        builder: (context, state) => const PersonalExerciseLibraryScreen(),
      ),
      GoRoute(
        path: '/personal-create-exercise',
        builder: (context, state) => const PersonalCreateExerciseScreen(),
      ),
      GoRoute(
        path: '/personal-foods',
        builder: (context, state) => const PersonalFoodsScreen(),
      ),
      GoRoute(
        path: '/personal-add-food',
        builder: (context, state) => const PersonalAddFoodScreen(),
      ),
      GoRoute(
        path: '/personal-profile',
        builder: (context, state) => const PersonalProfileScreen(),
      ),
      GoRoute(
        path: '/personal-settings',
        builder: (context, state) => const PersonalSettingsScreen(),
      ),
    ],
  );
});
