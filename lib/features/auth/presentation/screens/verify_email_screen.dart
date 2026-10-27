
import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:arven/core/widgets/custom_appbar.dart';
import 'package:arven/core/widgets/shared_button.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:arven/features/auth/data/data%20source/auth_remote_data_source.dart';
import 'package:arven/features/auth/data/models/verify_email_request_model.dart';
import 'package:dio/dio.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController otpController =TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRemoteDataSource authRemoteDataSource =AuthRemoteDataSource(Dio());

  bool isLoading = false;


Future<void> verifyEmail() async {
  setState(() {
    isLoading = true;
  });

  try {
    final model = VerifyEmailRequestModel(
      email: widget.email,
      otp: otpController.text.trim(),
    );

    final response = await authRemoteDataSource.verifyEmail(model);

    log('Verify Email status: ${response.statusCode}');
    log('Verify Email response: ${response.data}');

    if (!mounted) return;

    if (response.statusCode == 200 || response.statusCode == 204) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  } on DioException catch (e) {
    log('Verify Email error: ${e.response?.statusCode}');
    log('Verify Email response: ${e.response?.data}');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.response?.data is Map
              ? e.response?.data['message']?.toString() ??
                  'Verification failed'
              : 'Verification failed. Please check your code.',
        ),
      ),
    );
  } catch (e, stackTrace) {
    log('Unexpected Verify Email error: $e');
    log('Stack trace: $stackTrace');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something went wrong'),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}

 
Future<void> resendOtp() async {
  try {
    final response =
        await authRemoteDataSource.resendOtp(widget.email);

    if (!mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A new verification code has been sent.'),
        ),
      );
    }
  } on DioException catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.response?.data is Map
              ? (e.response?.data['message']?.toString() ??
                  'Could not resend the code.')
              : 'Could not resend the code.',
        ),
      ),
    );
  }
}


  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:CustomAppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    const Icon(
                      Icons.mark_email_read_outlined,
                      size: 75,
                      color: AppColors.black,
                    ),

                    const SizedBox(height: 25),

                    Text(
                      'Verify Your Email',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.text24Medium
                          .copyWith(
                        color: AppColors.textprimary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "We've sent a verification code to your "
                      "email address. Enter the code below "
                      "to verify your account.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.text16Regular
                          .copyWith(
                        color: AppColors.textsecondary,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.textfield,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: AppColors.textprimary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.email,
                              style: AppTextStyles.text14Medium
                                  .copyWith(
                                color: AppColors.textprimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      'VERIFICATION CODE',
                      style: AppTextStyles.text14Medium
                          .copyWith(
                        color: AppColors.textsecondary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      style: AppTextStyles.text24Medium
                          .copyWith(
                        color: AppColors.textprimary,
                        letterSpacing: 12,
                      ),
                      decoration: InputDecoration(
                        hintText: '------',
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.textfield,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.lightGray,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.lightGray,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^\d{6}$').hasMatch(value)) {
                          return 'Enter the 6-digit code';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),
                    if (isLoading)
                    const CircularProgressIndicator()
                    else
                    SharedButton(
                    buttonName: 'VERIFY EMAIL',
                     onPressed: () {
                    if (formKey.currentState!.validate()) {
                    verifyEmail();
      }
    },
  ),
                    const SizedBox(height: 15),

                    TextButton(
                    onPressed: isLoading
    ? null
    : () async {
        await resendOtp();
      },
                      child: Text(
                        'Resend Code',
                        style: AppTextStyles.text14Medium
                            .copyWith(
                          color: AppColors.textprimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
