import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_bloc.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_event.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_state.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLeadScreen extends StatelessWidget {
  const AddLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<AddleadBloc>()
        .add(ChangeLeadTypeEvent(leadType: "commission"));
    TextEditingController pickupLocationController = TextEditingController();
    TextEditingController dropLocationController = TextEditingController();
    TextEditingController vehicleController = TextEditingController();
    TextEditingController extraMessageController = TextEditingController();
    return Scaffold(
      appBar: myAppBar(
          context: context, title: AppLocalizations.of(context)!.addLeads),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "${AppLocalizations.of(context)!.pick} ${AppLocalizations.of(context)!.location}",
                style: AppTextStyles.style16w500(),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.myBlack45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    toFromDots(),
                    Expanded(
                        child: TextFormField(
                      controller: pickupLocationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnter('pickup location');
                        } else {
                          return null;
                        }
                      },
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${AppLocalizations.of(context)!.drop} ${AppLocalizations.of(context)!.location}",
                style: AppTextStyles.style16w500(),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.myBlack45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    toFromDots(postion: 2),
                    Expanded(
                        child: TextFormField(
                      controller: dropLocationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnter('drop location');
                        } else {
                          return null;
                        }
                      },
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.vehicle,
                style: AppTextStyles.style16w500(),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.myBlack45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: vehicleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnter('car type');
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.leadtype,
                style: AppTextStyles.style16w500(),
              ),
              const SizedBox(
                height: 2,
              ),
              BlocBuilder<AddleadBloc, AddleadState>(
                builder: (context, state) {
                  if (state is ChangeLeadType) {
                    return Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.spaceBetween,
                      children: TextData.leadType.map((lead) {
                        return GestureDetector(
                            onTap: () {
                              context
                                  .read<AddleadBloc>()
                                  .add(ChangeLeadTypeEvent(leadType: lead));
                            },
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: ShowImage(
                                boxFit: BoxFit.contain,
                                imagelink: TextData.leadTypeData[lead][
                                    (state).leadType == lead
                                        ? 'iconfilled'
                                        : 'icon'],
                              ),
                            ));
                      }).toList(),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                AppLocalizations.of(context)!.extraMsg,
                style: AppTextStyles.style15w600(),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.myBlack45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: extraMessageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(

          // tapable: canUpload(leads.processingLead),
          borderRadius: 6,
          onTap: () {
            context.read<AddleadBloc>().add(UploadLeadEvent(
                context: context,
                dropLocation: dropLocationController.text.trim(),
                extraMessage: extraMessageController.text.trim(),
                pickupLocation: pickupLocationController.text.trim(),
                vehicle: vehicleController.text.trim()));
          },
          isAtBottom: true,
          lable: AppLocalizations.of(context)!.addLeads),
    );
  }
}

Padding toFromDots({int postion = 1}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: postion == 1 ? AppColors.myprimaryColor : AppColors.myGrey,
              shape: BoxShape.circle),
        ),
        Container(
            height: 8,
            width: 7,
            alignment: Alignment.center,
            child: const Divider(
              color: AppColors.myBlack45,
              thickness: 1,
            )),
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
              color: postion == 2 ? AppColors.myprimaryColor : AppColors.myGrey,
              shape: BoxShape.circle),
        ),
      ],
    ),
  );
}
