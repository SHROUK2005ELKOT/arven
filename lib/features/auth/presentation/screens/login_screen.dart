import 'dart:developer';
import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/core/utils/cache_helper.dart'; 
import 'package:arven/core/utils/validators.dart'; 
import 'package:arven/core/widgets/shared_button.dart'; 
import 'package:arven/core/widgets/shared_text_field.dart'; 
import 'package:arven/features/auth/data/data%20source/auth_remote_data_source.dart'; 
import 'package:arven/features/auth/data/models/login_request_model.dart';
import 'package:arven/features/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart'; 
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
@override State<LoginScreen> createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> myKey = GlobalKey<FormState>();
final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource(Dio());
bool isloading = false;

Future<void> login() async {
  setState(() {
    isloading = true;
  });

  try {
    final LoginRequestModel model = LoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    final response = await authRemoteDataSource.login(model);

    log('Login status: ${response.statusCode}');
    log('Login response: ${response.data}');

    // تحويل الـ response لموديل
    final loginResponse = LoginResponseModel.fromJson(
      Map<String, dynamic>.from(response.data),
    );

    // حفظ الـ tokens
    await CacheHelper.saveData(
      key: 'accessToken',
      value: loginResponse.accessToken,
    );

    await CacheHelper.saveData(
      key: 'refreshToken',
      value: loginResponse.refreshToken,
    );

    log('Tokens saved successfully');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful'),
      ),
    );

  } on DioException catch (e) {
    log('Login error: ${e.response?.data ?? e.message}');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login failed'),
      ),
    );

  } catch (e, stackTrace) {
    log('Login error: $e');
    log('$stackTrace');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong'),
      ),
    );

  } finally {
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }
}
@override void dispose() { emailController.dispose(); passwordController.dispose(); super.dispose(); }
@override Widget build(BuildContext context) { return SafeArea( child: Scaffold( appBar: AppBar( title: Text( 'ARVEN', style: AppTextStyles.text32Medium.copyWith( color: AppColors.textprimary, ), ), ), body: SizedBox( width: double.infinity, child: Form( key: myKey, child: Column( crossAxisAlignment: CrossAxisAlignment.center, children: [ const SizedBox(height: 70),
            Text(
              'Welcome Back',
              style: AppTextStyles.text32Medium.copyWith(
                color: AppColors.textprimary,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              'Access your exclusive profile.',
              style: AppTextStyles.text14Medium.copyWith(
                color: AppColors.textsecondary,
              ),
            ),

            const SizedBox(height: 40),

            SharedTextField(
              textFieldName: 'EMAIL ADDRESS',
              hintTextField: 'name@example.com',
              controller: emailController,
              validator: (emailVal) {
                return Validator.validateEmail(emailVal!);
              },
            ),

            const SizedBox(height: 10),

            SharedTextField(
              textFieldName: 'PASSWORD',
              hintTextField: '••••••••',
              controller: passwordController,
              validator: (passVal) {
                return Validator.validatePassword(passVal!);
              },
              textButton: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.text12Regular.copyWith(
                    color: AppColors.textprimary,
                  ),
                ),
              ),
              passwordIcon: const Icon(
                Icons.remove_red_eye_outlined,
              ),
            ),const SizedBox(height: 10),

            SharedButton(
              buttonName: isloading ? 'Loading...' : 'LOGIN',
              onPressed: () async {
                if (isloading) return;

                if (myKey.currentState!.validate()) {
                  await login();
                }
              },
            ),

            const SizedBox(height: 20),

            Text(
              "Don't have an account?",
              style: AppTextStyles.text20Regular.copyWith(
                color: AppColors.textsecondary,
              ),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                // هنربطه بشاشة Register بعدين.
              },
              child: Text(
                'Create Account',
                style: AppTextStyles.text24Medium.copyWith(
                  color: AppColors.textprimary,
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    ),
  ),
);
} }