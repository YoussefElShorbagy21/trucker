import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../layout/homeLayout/cubit/state.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/resources/color_manager.dart';


class EditProfileScreen extends StatelessWidget {


  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context,state) {},
      builder: (context,state)
      {
        var userModel = HomeCubit.get(context).userData;

        HomeCubit.get(context).fullNameController.text = userModel.name;
        HomeCubit.get(context).emailController.text = userModel.email;
        HomeCubit.get(context).phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: const Icon(
                 Icons.arrow_back
              ),
            ),
            actions:
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: ()
                  {
                    HomeCubit.get(context).updateUserData(
                        name: HomeCubit.get(context).fullNameController.text ,
                        phone: HomeCubit.get(context).phoneController.text,
                        email: HomeCubit.get(context).emailController.text,
                        avatar: HomeCubit.get(context).profileImage,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Update',style: TextStyle(color: Colors.blue),),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [
                  if(state is LoadingUpdateUSERState)
                    const LinearProgressIndicator(),
                  if(state is LoadingUpdateUSERState)
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(HomeCubit.get(context).profileImage!)
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                HomeCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.camera_enhance_rounded,
                                    size: 20,
                                    color: Colors.blue,)
                              ),
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
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.supervised_user_circle, color: ColorManager.gery,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )
                    ),
                    controller: HomeCubit.get(context).fullNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email_outlined, color: ColorManager.gery,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )
                    ),
                    controller: HomeCubit.get(context).emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'phone',
                        prefixIcon: Icon(Icons.call, color: ColorManager.gery,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )
                    ),
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
