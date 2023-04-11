import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../layout/homeLayout/cubit/state.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/resources/color_manager.dart';


class EditProfileScreen extends StatelessWidget {

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context,state) {},
      builder: (context,state)
      {
        var  profileImage = HomeCubit.get(context).userData.avatar;
        var userModel = HomeCubit.get(context).userData;

        fullNameController.text = userModel.name;
        emailController.text = userModel.email;
        phoneController.text = userModel.phone;
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
                        name: fullNameController.text ,
                        phone: phoneController.text,
                        email: emailController.text);
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
                                backgroundImage: NetworkImage(userModel.avatar)
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                HomeCubit.get(context).getPostImage();
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
                  if(HomeCubit.get(context).postImage != null )
                      Row(
                        children:
                        [
                          if(HomeCubit.get(context).postImage != null)
                            Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                 /*   SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioCtroller.text,
                                    );*/
                                  },
                                  text: 'update profile',
                                ),
                                if(state is LoadingUpdateUSERState)
                                    const SizedBox(
                                  height: 5.0,
                                ),
                                if(state is LoadingUpdateUSERState)
                                    const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                  if(HomeCubit.get(context).postImage != null)
                      const SizedBox(
                        height: 20,
                      ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.supervised_user_circle, color: ColorManager.gery,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )
                    ),
                    controller: fullNameController,
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
                    controller: emailController,
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
                    controller: phoneController,
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
