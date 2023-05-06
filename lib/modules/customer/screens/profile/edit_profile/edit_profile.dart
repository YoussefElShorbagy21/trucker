import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../layout/homeLayout/cubit/state.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../../../../../shared/resources/select_photo_options_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userData;

        HomeCubit.get(context).fullNameController.text = userModel.name;
        HomeCubit.get(context).emailController.text = userModel.email;
        HomeCubit.get(context).phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile'.tr(context),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    HomeCubit.get(context).updateUserData(
                      name: HomeCubit.get(context).fullNameController.text,
                      phone: HomeCubit.get(context).phoneController.text,
                      email: HomeCubit.get(context).emailController.text,
                      avatar: HomeCubit.get(context).profileImage,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update'.tr(context),
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is LoadingUpdateUSERState)
                    const LinearProgressIndicator(),
                  if (state is LoadingUpdateUSERState)
                    const SizedBox(
                      height: 8,
                    ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            if (HomeCubit.get(context).profileImage != null)
                              CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(
                                      HomeCubit.get(context).profileImage!),
                                ),
                              ),
                            if (HomeCubit.get(context).profileImage == null)
                              CircleAvatar(
                                radius: 55,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: HomeCubit.get(context).userData.avatar.isNotEmpty ? NetworkImage(HomeCubit.get(context).userData.avatar) :
                                  const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                                  child: HomeCubit.get(context).userData.avatar.isNotEmpty ? null : Text(
                                    HomeCubit.get(context).userData.name[0].toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                              ),
                            IconButton(
                              onPressed: () {
                                _showSelectPhotoOptions(context);
                              },
                              icon: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_enhance_rounded,
                                    size: 20,
                                    color: Colors.blue,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name'.tr(context),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle,
                          color: ColorManager.gery,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                    controller: HomeCubit.get(context).fullNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'email'.tr(context),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ColorManager.gery,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                    controller: HomeCubit.get(context).emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'phone'.tr(context),
                        prefixIcon: Icon(
                          Icons.call,
                          color: ColorManager.gery,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                    controller: HomeCubit.get(context).phoneController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showSelectPhotoOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectPhotoOptionsScreen(
              onTap: HomeCubit.get(context).getProfileImage,
            ),
          );
        }),
  );
}
