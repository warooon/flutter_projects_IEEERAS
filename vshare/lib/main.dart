import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vshare/firebase_options.dart";
import "package:vshare/services/auth_gate.dart";
import "package:vshare/services/auth_service.dart";
import "package:vshare/services/data_model.dart";
import "package:vshare/services/food_available_modal.dart";
import "package:vshare/services/food_donate_modal.dart";
import "package:vshare/services/previous_donate_modal.dart";
import "package:vshare/services/track_beneficiary_modal.dart";
import "package:vshare/services/track_food_modal.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
        ChangeNotifierProvider<DataModel>(create: (context) => DataModel()),
        ChangeNotifierProvider<FoodDonateModal>(
            create: (context) => FoodDonateModal()),
        ChangeNotifierProvider<PreviousDonateModal>(
            create: (context) => PreviousDonateModal()),
        ChangeNotifierProvider<FoodAvailableModal>(
            create: (context) => FoodAvailableModal()),
        ChangeNotifierProvider<TrackFoodModal>(
            create: (context) => TrackFoodModal()),
        ChangeNotifierProvider<TrackBeneficiaryModal>(
            create: (context) => TrackBeneficiaryModal()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
