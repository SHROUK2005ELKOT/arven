import 'dart:developer';
import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/core/utils/validators.dart'; 
import 'package:arven/core/widgets/shared_button.dart'; 
import 'package:arven/core/widgets/shared_text_field.dart';
import 'package:arven/features/auth/data/data%20source/auth_remote_data_source.dart';
import 'package:arven/features/auth/data/models/register_request_model.dart';
import 'package:dio/dio.dart'; 
import 'package:flutter/material.dart';
import 'package:arven/features/auth/presentation/screens/verify_email_screen.dart';


class RegisterScreen extends StatefulWidget {

   const RegisterScreen({super.key});

@override State<RegisterScreen> createState() => _RegisterScreenState(); }

class _RegisterScreenState extends State<RegisterScreen> {

   final TextEditingController emailController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
   final TextEditingController firstnameController = TextEditingController();
   final TextEditingController lastnameController = TextEditingController();
final GlobalKey<FormState> myKey = GlobalKey<FormState>();

final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource(Dio());
bool isloading = false;
Future<void> register() async { 
setState(() { isloading = true; });
try { log('Register: creating request model');
final model = RegisterRequestModel(
  email: emailController.text.trim(),
  password: passwordController.text,
  firstName: firstnameController.text.trim(),
  lastName: lastnameController.text.trim(),
);

log('Register: sending request');

final response = await authRemoteDataSource.register(model);

log('Register status code: ${response.statusCode}');
log('Register response: ${response.data}');

if (!mounted) return;

log('Register successful - navigating to OTP screen');

await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => VerifyEmailScreen(
      email: emailController.text.trim(),
    ),
  ),
);

log('Returned from OTP screen');

} on DioException catch (e) { 
log('Register Dio error: ${e.type}'); 
log('Register status: ${e.response?.statusCode}'); 
log('Register response data: ${e.response?.data}'); 
log('Register error message: ${e.message}');
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      e.response?.data is Map
          ? (e.response?.data['message']?.toString() ??
              'Register failed')
          : 'Register failed: ${e.message}',
    ),
  ),
);
} catch (e, stackTrace) { 
  log('Register unexpected error: $e'); 
  log('Stack trace: $stackTrace');
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Something went wrong')),
);
} finally {
   if (mounted) {
     setState(() {
       isloading = false; });
        } } }
@override void dispose() { 
emailController.dispose();
 passwordController.dispose();
firstnameController.dispose();
lastnameController.dispose(); 
   super.dispose(); }
@override Widget build(BuildContext context) { 
  return SafeArea( child:
   Scaffold( appBar: AppBar( 
    centerTitle: false, title: 
    Text( 'ARVEN', style: AppTextStyles.text32Medium.copyWith( 
      color: AppColors.textprimary, ), ), ),
       body: Center( child: Form( key: myKey, child:
        SingleChildScrollView( child: 
        Column( children: [ 
          const SizedBox(height: 30),
              Text(
                'Join ARVEN',
                style: AppTextStyles.text24Medium.copyWith(
                  color: AppColors.textprimary,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                'Elevate your wardrobe. Enter the circle of \n'
                ' exclusive aesthetics.',
                textAlign: TextAlign.center,
                style: AppTextStyles.text16Regular.copyWith(
                  color: AppColors.textsecondary,
                ),
              ),

              const SizedBox(height: 20),

              SharedTextField(
                validator: (nameVal) {
                  return Validator.validateUserName(nameVal!);
                },
                textFieldName: 'FIRST NAME',
                hintTextField: 'ALEXANDER VOGUE',
                controller: firstnameController,
              ),

              const SizedBox(height: 15),

              SharedTextField(
                validator: (name2Val) {
                  return Validator.validateUserName(name2Val!);
                },
                textFieldName: 'LAST NAME',hintTextField: 'ELKOT',
                controller: lastnameController,
              ),

              const SizedBox(height: 15),

              SharedTextField(
                textFieldName: 'EMAIL ADDRESS',
                hintTextField: 'alexander@gang.com',
                controller: emailController,
                validator: (emailVal) {
                  return Validator.validateEmail(emailVal!);
                },
              ),

              const SizedBox(height: 15),

              SharedTextField(
                textFieldName: 'PASSWORD',
                hintTextField: '••••••••',
                passwordIcon: const Icon(
                  Icons.remove_red_eye_outlined,
                ),
                controller: passwordController,
                validator: (passVal) {
                  return Validator.validatePassword(passVal!);
                },
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_box_outline_blank,
                    ),
                  ),
                  Text(
                    'I AGREE TO THE PRIVACY POLICY AND\n'
                    'TERMS OF SERVICE.',
                    style: AppTextStyles.text16Medium,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (isloading)
                const CircularProgressIndicator()
              else
                SharedButton(
                  buttonName: 'SIGN UP',
                  onPressed: () async {
                 log('1 - Register button pressed');

                final isValid = myKey.currentState!.validate();

                log('2 - Validation result: $isValid');

                if (isValid) {
                  log('3 - Starting register request');
                  await register();
                 log('4 - Register request finished');
  }
},
                  ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Log In'),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  ),
);
} }