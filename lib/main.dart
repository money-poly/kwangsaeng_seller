import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:kwangsaeng_seller/firebase_options.dart';
import 'package:kwangsaeng_seller/screens/home/home_view_model.dart';
import 'package:kwangsaeng_seller/screens/navigation/nav_view.dart';
import 'package:kwangsaeng_seller/screens/navigation/nav_view_model.dart';
import 'package:kwangsaeng_seller/screens/start/start_view.dart';
import 'package:kwangsaeng_seller/screens/start/start_view_model.dart';
import 'package:kwangsaeng_seller/screens/start/waiting_view.dart';
import 'package:kwangsaeng_seller/services/auth_service.dart';
import 'package:kwangsaeng_seller/styles/color.dart';
import 'package:kwangsaeng_seller/styles/theme.dart';
import 'package:kwangsaeng_seller/styles/txt.dart';
import 'package:kwangsaeng_seller/utils.dart/valid_token.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  final service = AuthService();
  final PageType pageType;
  if (await checkValidToken()) {
    if (await service.getStoreRegisterStatus() == StoreRegisterStatus.done) {
      pageType = PageType.home;
    } else {
      pageType = PageType.wait;
    }
  } else {
    pageType = PageType.start;
  }
  FlutterNativeSplash.remove();
  runApp(MyApp(pageType: pageType));
}

enum PageType { start, home, wait }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.pageType});

  final PageType pageType;
  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('ko', 'KR'),
      textStyle: KwangStyle.btn3.copyWith(color: KwangColor.grey100),
      backgroundColor: KwangColor.grey800.withOpacity(0.8),
      toastPositions: StyledToastPosition.bottom,
      borderRadius: BorderRadius.circular(20),
      duration: const Duration(milliseconds: 1500),
      toastAnimation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      child: MaterialApp(
        title: '광생 사장님',
        theme: KwangTheme.kwangTheme,
        home: switch (pageType) {
          PageType.start => ChangeNotifierProvider(
              create: (_) => StartViewModel(), child: const StartView()),
          PageType.wait => const WaitingView(),
          PageType.home => MultiProvider(providers: [
              ChangeNotifierProvider(create: (_) => NavViewModel()),
              ChangeNotifierProvider(create: (_) => HomeViewModel()),
            ], child: const NavView()),
        },
      ),
    );
  }
}
