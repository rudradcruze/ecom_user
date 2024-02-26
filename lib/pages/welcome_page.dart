import 'package:ecom_user/pages/login_page.dart';
import 'package:ecom_user/pages/register_page.dart';
import 'package:ecom_user/theme/theme.dart';
import 'package:ecom_user/widgets/custom_scaffold_background_widget.dart';
import 'package:ecom_user/widgets/welcome_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = '/welcome';

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Super Shop!\n',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '\nEnter personal details to your user account',
                          style: TextStyle(
                            fontSize: 20,
                            // height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      routeName: LoginPage.routeName,
                      backgroundColor: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign Up',
                      routeName: RegistrationPage.routeName,
                      backgroundColor: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
