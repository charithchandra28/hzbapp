import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'blocs/guest/guest_bloc.dart';
import 'blocs/guest/guest_event.dart';
import 'data/database_initializer.dart';
import 'data/repositories/guest_repository.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iuwqyyoriitqlkcuhiba.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1d3F5eW9yaWl0cWxrY3VoaWJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE2NzkyMDUsImV4cCI6MjA0NzI1NTIwNX0.uLGKDuTLLpK4oN9NSWupheL-Z0eBExe91nwz54jL_CA',
  );

  // Initialize the database
  // final databaseInitializer = DatabaseInitializer();
  // await databaseInitializer.initializeDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Design size based on your Figma/Sketch design
      builder: (context, child) {
        return MaterialApp(
          title: 'Local Delivery App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocProvider(
            create: (context) => GuestBloc(GuestRepository())..add(LoadGuestData()),
            child: HomeScreen(),
          ),
        );
      },
    );
  }
}

