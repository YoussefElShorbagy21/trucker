import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/profile/setting_widget/settings_widget.dart';
import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/resources/color_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                             CircleAvatar(
                              radius: 80,
                              backgroundImage: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? NetworkImage(HomeCubit.get(context).oneUserData.userData.avatar) :
                              const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                              child: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? null : Text(
                                HomeCubit.get(context).oneUserData.userData.name[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 80,
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      HomeCubit.get(context).oneUserData.userData.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      HomeCubit.get(context).oneUserData.userData.email,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Card(
                          color: Colors.white, elevation: 2, child: buildMyOrder(context),),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                          color: Colors.white,
                          elevation: 2,
                          child: buildFavorite(context)),
                      Card(
                          color: Colors.white,
                          elevation: 2,
                          child: buildPaymentMethod()),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                          color: Colors.white,
                          elevation: 2,
                          child: buildSupport(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
);
  }
}
