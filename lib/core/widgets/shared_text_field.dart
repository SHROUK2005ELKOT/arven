import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class SharedTextField extends StatefulWidget {
  final String textFieldName;
  final String hintTextField;
  final Icon? passwordIcon;
  final Widget? textButton;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const SharedTextField({super.key,
   required this.textFieldName,
   required this.hintTextField,
   this.passwordIcon,
   this.textButton,
   required this.controller,
   this.validator});

  @override
  State<SharedTextField> createState() => _SharedTextFieldState();
}

class _SharedTextFieldState extends State<SharedTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.textFieldName,style: AppTextStyles.text14Medium.copyWith(
                color: AppColors.textsecondary
              ),
              ),
              Spacer(),
              if (widget.textButton != null)widget.textButton!,
            ],
          ),
          SizedBox(height: 5,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator:widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintTextField,
              suffixIcon: widget.passwordIcon,
              filled: true,
              fillColor: AppColors.textfield
              ,border: 
              OutlineInputBorder(
                
                borderRadius: BorderRadius.circular(15)
                ,borderSide: BorderSide.none
                )
            ),
          ),
        ],
      ),
    );
  }
}