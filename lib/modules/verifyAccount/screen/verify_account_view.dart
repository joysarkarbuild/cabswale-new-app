import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key, required this.isFetchData});
  final bool isFetchData;

  @override
  Widget build(BuildContext context) {
    if (isFetchData) {
      context.read<MyprofileBloc>().add(MyProfileLoadEvent());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: AppTextStyles.style18w500(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MyprofileBloc, MyprofileState>(
        builder: (context, state) {
          if (state is MyProfileLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: VerificationOption(
                    isVerified: (state.myProfile.name != null &&
                        state.myProfile.name!.isNotEmpty &&
                        state.myProfile.city != null &&
                        state.myProfile.city!.isNotEmpty &&
                        state.myProfile.profileImage != null &&
                        state.myProfile.profileImage!.isNotEmpty),
                    onTap: () {
                      context.pushNamed(Names.editNameCityAndProfilePicture);
                    },
                    title: "Name, City & Profile Picture",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: VerificationOption(
                    isVerified: false,
                    onTap: () {},
                    title: "Aadhar & Licence",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: VerificationOption(
                    isVerified: state.myProfile.vehicles != null &&
                        state.myProfile.vehicles!.isNotEmpty,
                    onTap: () {
                      context.pushNamed(Names.vehicles);
                    },
                    title: "Vehicles",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: VerificationOption(
                    isVerified: state.myProfile.routes != null &&
                        state.myProfile.routes!.isNotEmpty,
                    onTap: () {
                      context.pushNamed(Names.editTopRoutes);
                    },
                    title: "Top Routes",
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SubmitButton(
                    onTap: () async {},
                    lable: "Submit for Verification",
                    borderRadius: 6,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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

class VerificationOption extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isVerified;

  const VerificationOption(
      {super.key,
      required this.isVerified,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.myprimaryColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  isVerified ? Icons.check_box : Icons.arrow_forward,
                  color: isVerified ? Colors.green : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
