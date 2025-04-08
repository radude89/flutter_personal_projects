import 'package:provider/provider.dart';

import '../main.dart';
import '../services/database/database_provider.dart';
import '../themes/theme_provider.dart';

  class MainAppProviderHolder  {
    MultiProvider provider = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ],
      child: const MyApp(),
    );
  }