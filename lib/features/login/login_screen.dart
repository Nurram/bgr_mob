import 'package:bgr_logistik/core_imports.dart';
import 'package:bgr_logistik/features/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GetX(
          init: LoginController(),
          builder: (controller) => Form(
            key: controller.key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Image.asset(
                    Utils.getAssetPath(imageName: 'logo.png'),
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Silahkan login sebelum melanjutkan',
                    style: StyleText.textBlack(),
                  ),
                  const SizedBox(height: 48),
                  CustomTextFormField(
                    controller: controller.emailCtr,
                    hint: 'Email',
                    validator: (value) {
                      if (!value.isEmail) {
                        return 'Silahkan masukan email yang valid';
                      }
                    },
                  ),
                  CustomTextFormField(
                    controller: controller.passwordCtr,
                    hint: 'Password',
                    obscureText: true,
                  ),
                  LoadingButton(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    borderRadius: 16,
                    text: 'Login',
                    onPressed: controller.login,
                    isLoading: controller.isLoading.value,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
