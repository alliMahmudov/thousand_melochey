
import 'package:thousand_melochey/core/imports/imports.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            const CustomTitleWidget(title: 'Welcome!'),
            SizedBox(
              height: 40.h,
            ),
            CustomButtonWidget(
              title: 'Log in',
              onTap: () {
                AppNavigator.push(const SignInRoute());
              },
              isLoading: false,
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: (){
                AppNavigator.push(const SignUpRoute());
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.r)),
                height: 0.06.sh,
                alignment: Alignment.center,
                child: Text(
                  "Create an account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
