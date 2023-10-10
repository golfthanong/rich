import 'package:chatty/pages/contact/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/entities/contact.dart';
import '../../../common/values/colors.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget _buildListItem(ContactItem item) {
    return Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 32, 32, 200),
          borderRadius: BorderRadius.all(Radius.circular(22.w)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ));
  }

  // Widget _buildListItem(ContactItem item) {
  //   return Container(
  //     padding: EdgeInsets.only(
  //       top: 10.h,
  //     ),
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           width: 1,
  //           color: AppColors.primarySecondaryBackground,
  //         ),
  //       ),
  //     ),
  //     child: InkWell(
  //       onTap: () {},
  //       child: Row(
  //         children: [
  //           Container(
  //             width: 44.w,
  //             height: 44.w,
  //             decoration: BoxDecoration(
  //               color: AppColors.primarySecondaryBackground,
  //               borderRadius: BorderRadius.all(Radius.circular(22.w)),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.1),
  //                   spreadRadius: 1,
  //                   blurRadius: 2,
  //                   offset: Offset(0, 1),
  //                 ),
  //               ],
  //             ),
  //             child: CachedNetworkImage(
  //               imageUrl: item.avatar!,
  //               height: 44.w,
  //               width: 44.w,
  //               imageBuilder: (context, imageProvider) => Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(22.w)),
  //                   image: DecorationImage(
  //                     image: imageProvider,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //            Container(
  //              width: 275.w,
  //              child: Row(
  //                children: [
  //                  SizedBox(
  //                    width: 200.w,
  //                    height: 42.w,
  //                    child: Text('golf'),
  //                  ),
  //                ],
  //              ),
  //            ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 0.w,
              horizontal: 20.w,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var item = controller.state.contactList[index];
                  //print(controller.state.contactList.length);
                  //print(controller.state.contactList.length);

                  //_buildListItem(item);
                  Container(
                    width: 44.w,
                    height: 44.w,
                    child: const Text('golf'),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 32, 32, 200),
                      borderRadius: BorderRadius.all(Radius.circular(22.w)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  );
                },
                childCount: controller.state.contactList.length,
                //childCount: 1,
              ),
            ),
          ),
        ],
      );
    });
  }
}
