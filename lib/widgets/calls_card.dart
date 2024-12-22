import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/services/calculation_util.dart';
import 'package:cabswalle/widgets/shimmer_container.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CallsCard extends StatelessWidget {
  const CallsCard({super.key, required this.call});
  final Map<String, dynamic> call;

  @override
  Widget build(BuildContext context) {
    Timestamp tp = call["createdAt"];
    DateTime dt = tp.toDate();
    bool isIncoming = call["type"] == 'incoming';
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: AppColors.myGrey)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 66,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 44,
                                          width: 44,
                                          decoration: BoxDecoration(
                                              image: call["profile_image"] ==
                                                          null ||
                                                      call["profile_image"] ==
                                                          ""
                                                  ? DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/default_user.jpg"))
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                          "${call["profile_image"]}")),
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              196),
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        call["name"] == "" ||
                                                                call["name"] ==
                                                                    null
                                                            ? "${call['phoneNo']}"
                                                            : "${call["name"]}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    call["fraud"] ?? false
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 4),
                                                            child: Image.asset(
                                                              "assets/images/fr.png",
                                                              width: 70,
                                                            ))
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 4),
                                                            child: Image.asset(
                                                              call["verified"] ??
                                                                      false
                                                                  ? "assets/images/ve.png"
                                                                  : "assets/images/nv.png",
                                                              width: 70,
                                                            )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  call["city"] == "" ||
                                                          call["city"] == null
                                                      ? "India"
                                                      : "${call["city"]}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                // Text(
                                                //   call["connections"] == 0 ||
                                                //           call["connections"] ==
                                                //               null
                                                //       ? "No Connections"
                                                //       : "${call["connections"]} Connections",
                                                //   style: TextStyle(
                                                //       color: Colors.black,
                                                //       fontSize: 12,
                                                //       fontWeight:
                                                //           FontWeight.w400),
                                                // ),
                                                // Text(
                                                //   "200 connectons",
                                                //   style: TextStyle(
                                                //       color: Colors.black,
                                                //       fontSize: 16,
                                                //       fontWeight: FontWeight.w400),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: -6,
                          child: Container(
                              height: 20,
                              width: 60,
                              margin: EdgeInsets.only(top: 26),
                              decoration: BoxDecoration(
                                  color: AppColors.myBlue,
                                  borderRadius: BorderRadius.circular(3)),
                              child: Center(
                                child: Text(
                                  'View Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              )),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    // Text(
                    //   call.phoneNo ?? '',
                    //   style: textstyle17,
                    // ),
                  ],
                ),
              ),

              // Icon(CupertinoIcons.arrow_down_left),
              if (!isIncoming)
                const Icon(
                  CupertinoIcons.arrow_up_right,
                  color: AppColors.myGreen,
                ),
              if (isIncoming)
                const Icon(
                  CupertinoIcons.arrow_down_left,
                  color: Colors.red,
                ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                CalculationUtil.getTimeAgo(dt),
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            height: 9,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubmitButton(
                    onTap: () async {},
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.43,
                    lable: "Whatsapp",
                    icon: SvgPicture.asset(
                      'assets/icons/whatsapp.svg',
                      height: 22,
                    ),
                  ),
                  SubmitButton(
                    onTap: () async {},
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.43,
                    lable: isIncoming ? 'Call Back' : 'Call Again',
                    icon: Icon(
                      Icons.call,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SubmitButton(
          //   onTap: () {
          //     FirebaseFirestore.instance
          //         .collection('drivers')
          //         .doc(FirebaseAuth.instance.currentUser!.uid)
          //         .get()
          //         .then((value) async {
          //       if (value.exists &&
          //           value.call()!.containsKey('membership') &&
          //           value['membership']['active']) {
          //         launchUrl(Uri.parse("tel:${call.phoneNo}"));
          //       } else {
          //         Navigator.of(context).push(new MaterialPageRoute<Null>(
          //             builder: (BuildContext context) {
          //               return new QRPayment();
          //             },
          //             fullscreenDialog: true));
          //       }
          //     });
          //   },
          //   lable: isIncoming ? 'Call Back' : 'Call Again',
          //   height: 35,
          //   // width: 150,
          // )
        ],
      ),
    );
  }
}

class CallsCardShimmer extends StatelessWidget {
  const CallsCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: AppColors.myGrey)),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(height: 20, width: 180),
                    SizedBox(
                      height: 6,
                    ),
                    ShimmerContainer(height: 20, width: 150),
                  ],
                ),
              ),

              // Icon(CupertinoIcons.arrow_down_left),

              ShimmerContainer(height: 40, width: 40),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: ShimmerContainer(
                height: 20,
                width: 80,
              )),
          SizedBox(
            height: 9,
          ),
          ShimmerContainer(height: 35, width: double.infinity)
        ],
      ),
    );
  }
}
