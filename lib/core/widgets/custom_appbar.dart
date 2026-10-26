import 'package:arven/core/theme/app_colors.dart';
import 'package:arven/core/theme/text_style.dart';
import 'package:flutter/material.dart';




class  CustomAppBar extends StatelessWidget 
implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  
  @override
 
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 7),
      child: AppBar(
        centerTitle: true,
      actions: [
        Icon(Icons.shopping_bag_outlined)
      ],
      leading: Icon(Icons.menu),
      title: Text("ARVEN",
          style: AppTextStyles.text32Medium.copyWith(
            color: AppColors.textprimary
          ),),
    )
    );
  }

}