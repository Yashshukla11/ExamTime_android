import 'package:cached_network_image/cached_network_image.dart';
import 'package:examtime/screens/auth_screen/signin.dart';
import 'package:examtime/screens/auth_screen/signup.dart';
import 'package:examtime/screens/discussion/discussion.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/liked_notes/liked.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/liked_notes/liked.dart';
import 'package:examtime/screens/profile/profile.dart';
import 'package:examtime/screens/request_notes/request.dart';
import 'package:examtime/services/SharedServices/Preferences.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';
import 'package:examtime/services/notification_service.dart';
import 'package:examtime/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:examtime/screens/request_notes/request.dart';
import 'package:examtime/services/SharedServices/Preferences.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';
import 'package:examtime/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().init();
  preferences = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: const MyApp(),
    )
    );
}

Future<void> backgroundHandler() async {
  print("Handling a background message: ");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamTime',
      //themeMode: ThemeMode.system,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        DashboardPage.routeName: (context) => DashboardPage(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        LikedNotesPage.routeName: (context) => LikedNotesPage(),
        RequestNotesPage.routeName: (context) => RequestNotesPage(),
        DiscussionPage.routeName: (context) => DiscussionPage(),

        //OTPPage.routeName: (context) => OTPPage(),

      },
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // log(SharedServices.getLoginDetails()!.token!);
        if (SharedServices.isLoggedIn()) {
          Navigator.pushReplacementNamed(context, DashboardPage.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backgroundColorAnimation = ColorTween(
      begin: const Color(0xFF1F2937),
      end: Theme.of(context).primaryColor,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://i.postimg.cc/02pnpHXG/logo-1.png',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to ExamTime!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
