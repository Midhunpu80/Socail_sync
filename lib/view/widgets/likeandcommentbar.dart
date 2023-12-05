import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:social_syn/main.dart';
import 'package:social_syn/view/service/posts/posts.service.dart';
import 'package:social_syn/view/utility/alltext.dart';
import 'package:social_syn/view/utility/colors.dart';
import 'package:social_syn/view/widgets/comments.dart';

// Widget userpostimage(BuildContext context, var index) {

// }

like_and_commentbar({
  required BuildContext context,
  var ind,
  required var likes,
  required var commentsa,
  required var postid,
  required List<dynamic> likess,
  required var uid,
  required var photourl,
  required var date,
  required var captions,
  required var username,
  required var profile,
  required  List comments
}) {
  createpost_service create = createpost_service();
  return Container(
    height: 7.h,
    color: bl,
    width: 100.w,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 19,
                  backgroundColor: wh.withOpacity(0.3),
                  child: IconButton(
                      onPressed: () async {
                        print(postid.toString());
                        print(likes.toString());
                        print(FirebaseAuth.instance.currentUser!.uid);
                        print(ind);

                        /// if (likess.contains(uid)){
                        await create.postlike(
                            postid: postid.toString(),
                            likes: likess,
                            uid: FirebaseAuth.instance.currentUser!.uid);
                      },
                      icon: likess
                              .contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Icon(
                              Icons.favorite,
                              color: re,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              size: 2.h,
                              color: wh,
                            ))),
              SizedBox(
                width: 2.w,
              ),
              alltext(
                  txt: likes.toString(),
                  col: wh,
                  siz: 9.sp,
                  wei: FontWeight.bold,
                  max: 1)
            ],
          ),
          SizedBox(
            width: 2.w,
          ),
          Row(
            children: [
              CircleAvatar(
                  radius: 19,
                  backgroundColor: wh.withOpacity(0.3),
                  child: IconButton(
                      onPressed: () {
                        commentsmessenger(
                          context,
                          uid: uid,
                          postid: postid,
                        );
                      },
                      icon: Icon(
                        Icons.messenger_outline_outlined,
                        size: 2.h,
                        color: wh,
                      ))),
              SizedBox(
                width: 2.w,
              ),
              alltext(
                  txt: commentsa.toString(),
                  col: bl,
                  siz: 9.sp,
                  wei: FontWeight.bold,
                  max: 1)
            ],
          ),
          Spacer(),
          CircleAvatar(
              radius: 19,
              backgroundColor: wh.withOpacity(0.3),
              child: IconButton(
                  onPressed: ()async {
                   await savedcont.savedtheposts(
                        photourl: photourl,
                        uid: uid,
                        postid: postid,
                        date: date.toString(),
                        captions: captions,
                        username: username,
                        profile: profile,
                        comments: comments,
                        likes: likes);
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: wh,
                    size: 2.h,
                  ))),
        ],
      ),
    ),
  );
}

Widget descriptionbar({required var des}) {
  return Padding(
    padding: EdgeInsets.only(left: 1.h),
    child: Container(
        width: 100.w,

        //  decoration: BoxDecoration(),
        child: ExpandableText(
          des,
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 1,
          style: TextStyle(color: wh, fontSize: 10.sp),
          linkColor: Colors.blue,
        )),
  );
}
