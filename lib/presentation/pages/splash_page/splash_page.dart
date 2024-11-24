import 'package:thousand_melochey/contstants/jwt_token.dart';
import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    jwtToken();
    goNextPage();
    super.initState();
  }

  Future<void> jwtToken() async {
    Token.jwtToken = await SP.readJWT();
  }

  goNextPage() async {
    final String jwt = await SP.readJWT();
    await Future.delayed(Duration(seconds: await isLogin() ? 1 : 2));

    if (context.mounted) {
      if (jwt.isEmpty) {
        AppNavigator.pushAndPopUntil(const WelcomeRoute());
      } else {
        AppNavigator.pushAndPopUntil(const MainRoute());
      }
    }
  }
  Future<bool> isLogin()async{

    return await SP.readJWT() != "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        curve: Curves.easeInToLinear,
        duration: const Duration(seconds: 1),
        child: const Center(
          child: Text(
            "1000 MELOCHEY",
            style: TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }
}
