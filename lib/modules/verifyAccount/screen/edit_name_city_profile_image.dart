import 'dart:io';

import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_event.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_state.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditNameCityAndProfileImage extends StatelessWidget {
  const EditNameCityAndProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController exprienceController = TextEditingController();
    File? selectedProfileImage;
    final ImagePicker picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit name, city & Profile Picture",
          style: AppTextStyles.style18w500(),
        ),
      ),
      body: BlocBuilder<MyprofileBloc, MyprofileState>(
        builder: (context, state) {
          if (state is MyProfileLoaded) {
            nameController.text = state.myProfile.name ?? "";
            cityController.text = state.myProfile.city ?? "";
            exprienceController.text = state.myProfile.experience != null
                ? state.myProfile.experience.toString()
                : "0";
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      BlocBuilder<VerifyAccountBloc, VerifyAccountState>(
                        builder: (context, stateV) {
                          if ((stateV is SelectProfileImageState ||
                                  stateV is UpdateProfileLoading) &&
                              selectedProfileImage != null) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CommonImageView(
                                  height: 200,
                                  width: 200,
                                  file: selectedProfileImage,
                                ));
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: (state.myProfile.profileImage != null &&
                                      state.myProfile.profileImage!.isNotEmpty)
                                  ? CommonImageView(
                                      height: 200,
                                      width: 200,
                                      url: state.myProfile.profileImage,
                                    )
                                  : CommonImageView(
                                      height: 200,
                                      width: 200,
                                      imagePath: Assets.imagesDefaultUser,
                                    ),
                            );
                          }
                        },
                      ),
                      Positioned(
                        bottom: 6,
                        right: 20,
                        child: InkWell(
                          onTap: () async {
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              selectedProfileImage = File(image.path);
                              // ignore: use_build_context_synchronously
                              context.read<VerifyAccountBloc>().add(
                                  SelectProfileImageEvent(
                                      selectedImage: selectedProfileImage!));
                            } else {
                              SnackbarUtils.showErrorSnackBar(
                                  message: "Field to select image");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: AppColors.myBlue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.myWhite, width: 4)),
                            child: Center(
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  hintText: "Enter your name",
                  label: "Name",
                  keyboardType: TextInputType.text,
                  borderRadius: 3,
                  textEditingController: nameController,
                ),
                MyTextFormField(
                  hintText: "Enter your city",
                  label: "City",
                  keyboardType: TextInputType.text,
                  borderRadius: 3,
                  textEditingController: cityController,
                ),
                MyTextFormField(
                  hintText: "Enter your exprience (years)",
                  label: "Exprience",
                  borderRadius: 3,
                  keyboardType: TextInputType.number,
                  textEditingController: exprienceController,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<VerifyAccountBloc, VerifyAccountState>(
                    builder: (context, state) {
                      return SubmitButton(
                        onTap: () {
                          if (nameController.text.trim().isNotEmpty &&
                              cityController.text.trim().isNotEmpty &&
                              exprienceController.text.trim().isNotEmpty) {
                            context.read<VerifyAccountBloc>().add(
                                UpdateProfileNameCityImageSubmitEvent(
                                    name: nameController.text.trim(),
                                    city: cityController.text.trim(),
                                    exprience: int.parse(
                                        exprienceController.text.trim()),
                                    selectedImage: selectedProfileImage,
                                    context: context));
                          } else {
                            SnackbarUtils.showErrorSnackBar(
                                message: "Please add all the data");
                          }
                        },
                        lable: "Save",
                        borderRadius: 6,
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return CentreLoading();
          }
        },
      ),
    );
  }
}
