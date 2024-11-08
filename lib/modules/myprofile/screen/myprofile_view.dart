import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/show_image_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyprofileScreen extends StatefulWidget {
  const MyprofileScreen({super.key});

  @override
  State<MyprofileScreen> createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyprofileBloc>().add(MyProfileLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: AppTextStyles.style18w500(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: BlocBuilder<MyprofileBloc, MyprofileState>(
            builder: (context, state) {
              if (state is MyProfileLoading) {
                return SizedBox(
                    height: context.screenHeight - 200,
                    width: context.screenWidth,
                    child: const CentreLoading());
              } else if (state is MyProfileLoaded) {
                UserProfileDataModel user = state.myProfile;
                return Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (user.profileImage != null &&
                                      user.profileImage!.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShowImageService(
                                                  imageUrl: user.profileImage!),
                                        ));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: (user.profileImage != null &&
                                          user.profileImage!.isNotEmpty)
                                      ? CommonImageView(
                                          url: user.profileImage,
                                          height: 70,
                                          width: 70,
                                        )
                                      : CommonImageView(
                                          imagePath: Assets.imagesDefaultUser,
                                          height: 70,
                                          width: 70,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                193),
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            (user.name != null &&
                                                    user.name!.isNotEmpty)
                                                ? user.name!
                                                : "Cabswale Partner",
                                            style: AppTextStyles.style16w600(
                                                height: 1.5)),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Image.asset(
                                            (user.verified ?? false)
                                                ? Assets.imagesVe
                                                : Assets.imagesNv,
                                            width: 70,
                                          )),
                                    ],
                                  ),
                                  Text(
                                      (user.city != null &&
                                              user.city!.isNotEmpty)
                                          ? user.city!
                                          : "India",
                                      style: AppTextStyles.style15w400(
                                          height: 1.5)),
                                  Text(
                                    (user.connectionCount != null)
                                        ? user.connectionCount == 0
                                            ? "No Connections"
                                            : "${user.connectionCount}"
                                        : "No Connections",
                                    style:
                                        AppTextStyles.style15w400(height: 1.5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                              right: 10,
                              top: 19,
                              child: SubmitButton(
                                height: 20,
                                width: 70,
                                onTap: () {
                                  context.pushNamed(Names.verifyAccount);
                                },
                                lable: "Edit",
                                borderRadius: 3,
                                labelsize: 12,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Experience : ",
                          style: AppTextStyles.style16w700(),
                        ),
                        Text(
                          "${user.experience ?? 0} Years",
                          style: AppTextStyles.style16w500(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.myprimaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Calls Received",
                                  style: AppTextStyles.style16w500(height: 1.5),
                                ),
                                Text(
                                  "${user.callReceivedCount ?? 0}",
                                  style: AppTextStyles.style18w500(height: 1.5),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              width: 1,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Calls Done  ",
                                  style: AppTextStyles.style16w500(height: 1.5),
                                ),
                                Text(
                                  "${user.callDoneCount ?? 0}",
                                  style: AppTextStyles.style18w500(height: 1.5),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Text("Leads Added : ",
                            style: AppTextStyles.style20w600()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.myprimaryColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Duties",
                                  style: AppTextStyles.style16w500(height: 1.5),
                                ),
                                Text(
                                  "${user.dutyCount ?? 0}",
                                  style: AppTextStyles.style18w600(height: 1.5),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              width: 1,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Exchange",
                                  style: AppTextStyles.style16w500(height: 1.5),
                                ),
                                Text(
                                  "${user.exchangeCount ?? 0}",
                                  style: AppTextStyles.style18w600(height: 1.5),
                                ),
                              ],
                            ),
                            Container(
                              height: 70,
                              width: 1,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Available",
                                  style: AppTextStyles.style16w500(height: 1.5),
                                ),
                                Text(
                                  "${user.availableCount ?? 0}",
                                  style: AppTextStyles.style18w600(height: 1.5),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    if (user.vehicles != null && user.vehicles!.isNotEmpty)
                      Row(
                        children: [
                          Text("Vehicles : ",
                              style: AppTextStyles.style20w600()),
                        ],
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (user.vehicles != null && user.vehicles!.isNotEmpty)
                      ...user.vehicles!.map(
                        (e) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${e["model"]}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              if (e["images"].isNotEmpty)
                                SizedBox(
                                  height: 400,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: e["images"].length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowImageService(
                                                              imageUrl: e[
                                                                      "images"]
                                                                  [index])));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: CommonImageView(
                                                url: e["images"][index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        },
                      ),
                    if (user.routes != null && user.routes!.isNotEmpty)
                      Row(
                        children: [
                          Text("Routes : ", style: AppTextStyles.style20w600()),
                        ],
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (user.routes != null && user.routes!.isNotEmpty)
                      ...user.routes!.map((e) => Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.myprimaryColor),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          40,
                                      child: Text(
                                        "${e["from"]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                              0.5 -
                                          40,
                                      child: Text(
                                        "${e["to"]}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          )),
                  ],
                );
              } else {
                return SizedBox(
                  height: context.screenHeight - 200,
                  width: context.screenWidth,
                  child: Center(
                    child: Text(
                        "Something went wrong!\nError: ${(state is MyProfileError) ? state.errorMessage : "Null"}"),
                  ),
                );
              }
            },
          ),
        ));
  }
}
