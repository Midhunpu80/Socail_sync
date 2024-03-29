import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:social_syn/main.dart';
import 'package:social_syn/view/screen/otherprofile/othersprofile.dart';
import 'package:social_syn/view/service/followingandunfollowing/following.dart';
import 'package:social_syn/view/utility/alltext.dart';
import 'package:social_syn/view/utility/buttons.dart';
import 'package:social_syn/view/utility/colors.dart';

class allusers_screen extends StatelessWidget {
  following_service newfollow = following_service();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('following')
            .snapshots(),
        builder: (context, snapshotss) {
          final snapsss = snapshotss.data?.docs;

          return !snapshotss.hasData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  backgroundColor: bl,
                  appBar: AppBar(
                    actions: [
                      messegebutton(context),
                      notificationbutton(),
                    ],
                    toolbarHeight: 10.h,
                    leading: Icon(
                      Icons.group,
                      color: wh,
                    ),
                    backgroundColor: bl,
                    title: alltext(
                        txt: "All users",
                        col: wh,
                        siz: 13.sp,
                        wei: FontWeight.bold,
                        max: 1),
                  ),
                  body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (context, snapshot) {
                        bool isexist = false;

                        return !snapshot.hasData
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                height: 100.h,
                                width: 100.w,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      /// final snapsss = snapshotss.data?.docs[index];
                                      final snap = snapshot.data?.docs[index];
                                      bool isdoc = false;
                                      if (snapsss != null) {
                                        for (var doc in snapsss) {
                                          if (doc.id == snap!.id) {
                                            isdoc = true;
                                            break;
                                          }
                                        }
                                      }
                                      return Container(
                                        height: 10.h,
                                        width: 100.w,
                                        child: ListTile(
                                          onTap: () async {
                                            Get.to(() => othersprofile_screen(
                                                  id: snap?['uid'],
                                                  followingsnap: snapsss,
                                                  thischange: isdoc,
                                                ));
                                          },
                                          trailing: InkWell(
                                            onTap: () async {
                                              await newfollow.followingtheuser(
                                                istru: isdoc,
                                                usersid: snap!.id,
                                                uid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              );
                                              ////////////////////////////////////////////////////////////////////////////////////////
                                              await notification_controll
                                                  .sendnotification(
                                                      condition: false,
                                                      uids: snap['uid'],
                                                      name: snap['name'],
                                                      profile: snap['profile'],
                                                      postid: null,
                                                      img: null,
                                                      isexist: isdoc);
                                              print(
                                                  "following-------------------------->");
                                            },
                                            child: Container(
                                              height: 4.h,
                                              width: 25.w,
                                              decoration: BoxDecoration(
                                                  color: isdoc ? gy : wh,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.h)),
                                              child: Center(
                                                child: isdoc
                                                    ? alltext(
                                                        txt: "following",
                                                        col: wh,
                                                        siz: 8.sp,
                                                        wei: FontWeight.bold,
                                                        max: 1)
                                                    : alltext(
                                                        txt: "FOLLOW",
                                                        col: bl,
                                                        siz: 7.sp,
                                                        wei: FontWeight.bold,
                                                        max: 1),
                                              ),
                                            ),
                                          ),
                                          subtitle: alltext(
                                              txt: "",
                                              col: wh.withOpacity(0.5),
                                              siz: 8.sp,
                                              wei: FontWeight.bold,
                                              max: 1),
                                          leading: CircleAvatar(
                                                backgroundColor: gy.withOpacity(0.3),
                                                  backgroundImage: NetworkImage(
                                                      snap?['profile']),
                                                  radius: 3.h,
                                                ),
                                          title: alltext(
                                              txt: snap?['name'],
                                              col: wh,
                                              siz: 11.sp,
                                              wei: FontWeight.bold,
                                              max: 1),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const SizedBox();
                                    },
                                    itemCount: snapshot.data!.docs.length),
                              );
                      }),
                );
        });
  }
}
