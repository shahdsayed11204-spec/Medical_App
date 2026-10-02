import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicalapp/splash_view.dart';

import 'core/get_it.dart';
import 'core/utils/cache_helper.dart';
import 'feature/home/presentation/cubit/home_cubit.dart';
import 'feature/local/locale_cubit.dart';
import 'feature/root/cubit/root_cubit.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(  create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => getIt<RootCubit>()),
        BlocProvider(create: (_) => getIt<HomeCubit>()..getClinics()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const SplashView(),
        ),
      ),
    );
  }
}