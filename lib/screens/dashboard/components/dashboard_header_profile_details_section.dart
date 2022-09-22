import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_text.dart';

class DashboardHeaderProfileDetailsSection extends StatelessWidget {
  const DashboardHeaderProfileDetailsSection({
    Key? key,
    required this.userFirstName,
    required this.userProfileImage,
  }) : super(key: key);

  final String userFirstName, userProfileImage;

  @override
  Widget build(BuildContext context) {
    final currentHour = DateTime.now().hour;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text:
              'Good ${currentHour < 12 ? 'Morning' : currentHour >= 12 && currentHour < 16 ? 'Afternoon' : 'Evening'}, $userFirstName',
          textSize: 20.sp,
          textColor: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w200,
        ),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(
        //     100.0,
        //   ),
        //   child: Container(
        //     color: Colors.white.withOpacity(
        //       0.3,
        //     ),
        //     padding: const EdgeInsets.all(
        //       5.0,
        //     ),
        //     child: CircleAvatar(
        //       backgroundImage: AssetImage(
        //         userProfileImage,
        //       ),
        //       radius: kDefaultPadding.w * 1.5,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
