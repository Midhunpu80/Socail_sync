import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_syn/main.dart';
import 'package:social_syn/view/utility/alltext.dart';
import 'package:social_syn/view/utility/colors.dart';

deleteandeditmodelsheet(BuildContext context,
    {required var postid, required var uid}) {
  FirebaseAuth currentuser = FirebaseAuth.instance;
  List<IconData> dataicons = [Icons.delete, Icons.edit, Icons.share];
  List buttons = ["Delete", "Edit", "Share"];
  return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 50.h,
          width: 100.w,
          color: bl.withOpacity(0.8),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 1.h,
                width: 10.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h), color: wh),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 8.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: wh),
                        borderRadius: BorderRadius.circular(
                          6.h,
                        ),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: wh,
                      ),
                    ),
                  ),
                  Container(
                    height: 8.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: wh),
                      borderRadius: BorderRadius.circular(
                        6.h,
                      ),
                    ),
                    child: Icon(
                      Icons.bookmark,
                      color: wh,
                    ),
                  ),
                ],
              ),
              Divider(
                color: gy,
              ),
              currentuser.currentUser.toString() != uid.toString()
                  ? SizedBox(
                      height: 32.h,
                      width: 100.w,
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                if (index == 0) {
                                  // ignore: avoid_single_cascade_in_expression_statements
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.rightSlide,
                                    title: 'Delete',
                                    desc: 'are you sure delte this post ',
                                    btnCancelOnPress: () {
                                      Get.back();
                                    },
                                    btnOkOnPress: () {
                                      print(
                                          "-----------------------${postid.toString()}");

                                      postcont.postdelete(
                                          id: postid.toString());
                                    },
                                  )..show();
                                }
                              },
                              leading: Icon(
                                dataicons[index],
                                color: index == 0 ? re : wh,
                              ),
                              title: alltext(
                                  txt: buttons[index],
                                  col: index == 0 ? re : wh,
                                  siz: 10.sp,
                                  wei: FontWeight.bold,
                                  max: 1),
                            );
                          }),
                    )
                  : SizedBox()
            ],
          ),
        );
      });
}