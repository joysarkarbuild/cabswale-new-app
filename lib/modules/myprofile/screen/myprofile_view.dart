import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';

import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/community/screen/community_view.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/show_image_service.dart';

import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyprofileScreen extends StatelessWidget {
  const MyprofileScreen({super.key});

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
          child: Column(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowImageService(imageUrl: ""),
                                ));
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image:
                                        AssetImage(Assets.imagesDefaultUser)),
                                borderRadius: BorderRadius.circular(35)),
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
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              193),
                                  child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Cabswale Partner",
                                      style: AppTextStyles.style16w600(
                                          height: 1.5)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Image.asset(
                                      "assets/images/ve.png",
                                      width: 70,
                                    )),
                              ],
                            ),
                            Text("India",
                                style: AppTextStyles.style15w400(height: 1.5)),
                            Text(
                              "No Connections",
                              style: AppTextStyles.style15w400(height: 1.5),
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
                    "5 years",
                    style: AppTextStyles.style16w500(),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                            "10",
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
                            "4",
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
                  Text("Leads Added : ", style: AppTextStyles.style20w600()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                            "35",
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
                            "23",
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
                            "120",
                            style: AppTextStyles.style18w600(height: 1.5),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text("Vehicles : ", style: AppTextStyles.style20w600()),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ...[1, 2].map(
                (e) {
                  return Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Sadan",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      if ([1, 2, 3].isNotEmpty)
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ShowImageService(
                                                      imageUrl:
                                                          "https://www.induscarrental.com/wp-content/uploads/2021/10/WhatsApp-Image-2021-10-16-at-19.27.42-1-576x1024.jpeg")));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        "https://www.induscarrental.com/wp-content/uploads/2021/10/WhatsApp-Image-2021-10-16-at-19.27.42-1-576x1024.jpeg",
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
              Row(
                children: [
                  Text("Routes : ", style: AppTextStyles.style20w600()),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ...[1, 2, 3, 4].map((e) => Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.myprimaryColor),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 40,
                              child: const Text(
                                "Kolkata",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            const Icon(Icons.arrow_forward),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 40,
                              child: const Text(
                                "Pune",
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
          ),
        ));
  }
}
