import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/presentation/rivepod/provider/otp_provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:pinput/pinput.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

@RoutePage()
class OTPPage extends ConsumerStatefulWidget {
  final String email;

  const OTPPage({required this.email, super.key});

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      ref.read(otpProvider.notifier).resentCodeDuration();
      timer(context, success: () {
        ref.read(otpProvider.notifier).resentCodeDuration();

      });
    });
  }

  timer(BuildContext context, {required Function() success}) async {
    if(context.mounted) {
      await Future.delayed(
          Duration(minutes: ref.watch(otpProvider).resendCodeDuration));
    }
    success.call();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(otpProvider.notifier);
    final state = ref.watch(otpProvider);

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: const TextStyle(fontSize: 20, color: AppColors.primaryColor),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryColor)
      ),
    );

    timer(BuildContext context, {required Function() success}) async {
      await Future.delayed(
          Duration(minutes: ref.watch(otpProvider).resendCodeDuration));
      success.call();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.h.verticalSpace,
            CustomTitleWidget(title: "${AppLocalization.getText(context)?.enter_code}"),
            12.h.verticalSpace,

            Text.rich(TextSpan(
              style: const TextStyle(color: Colors.black),
              text: "${AppLocalization.getText(context)?.sent_SMS_title} ",
              children: [
                TextSpan(
                  text: widget.email,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                ),
              ],
            ),),

            35.h.verticalSpace,
            Pinput(
              length: 6,
              controller: notifier.controller,
              focusNode: notifier.focusNode,
              autofillHints: const [AutofillHints.oneTimeCode],
              toolbarEnabled: false,
              autofocus: true,
              validator: (value) {
                if (value?.length == 6) {}
                return null;
              },
              separatorBuilder: (index) => Container(
                height: 64,
                width: 20,
                color: Colors.white,
              ),
              onCompleted: (verificationCode) async {
                await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
                      notifier.otpPost(
                      email: widget.email,
                      otpCode: verificationCode,
                      success: () {
                        AppNavigator.pushAndPopUntil(
                          const MainRoute(),
                        );
                      });
                });
              },
              onSubmitted: (String verificationCode) async {
                notifier.setOtpCode(verificationCode);
                notifier.otpPost(
                    email: widget.email,
                    otpCode: verificationCode,
                    success: () {
                      AppNavigator.pushAndPopUntil(
                        const MainRoute(),
                      );
                    });
              },
              defaultPinTheme: defaultPinTheme,
              showCursor: true,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primaryColor)
                ),
              ),
            ),
            20.verticalSpace,
            state.resendCodeActive
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SlideCountdownSeparated(
                    key: GlobalKey(),
                    duration: Duration(minutes: state.resendCodeDuration),
                    decoration: const BoxDecoration(
                      color: AppColors.transparent,
                    ),
                    //style: const TextStyle(fontSize: 18),
                    showZeroValue: true,
                    shouldShowDays: (value) => false,
                    shouldShowHours: (value) => false,
                  ),

                )
                // 20.horizontalSpace,
              ],
            )
                : const SizedBox(),
            10.verticalSpace,
            !state.resendCodeActive
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          notifier.resendOTP(
                              email: widget.email,
                              success: () {
                                notifier.resentCodeDuration();
                                timer(context, success: () {
                                  notifier.resentCodeDuration();
                                });
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${AppLocalization.getText(context)?.send_code_again}',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
            )
                : const SizedBox(),
            /*20.h.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideCountdownSeparated(
                  key: GlobalKey(),
                  duration: Duration(minutes: state.resendCodeDuration),
                  decoration: const BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  style: const TextStyle(
                      color: AppColors.primaryColor, fontSize: 18),
                )
                // 20.horizontalSpace,
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
