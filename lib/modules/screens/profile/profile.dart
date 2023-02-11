import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {} ,
          builder: (context, state)
          {

            return  Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [
                  SizedBox(
                    height: 190,
                   child:  CircleAvatar(
                     radius: 55,
                     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                     child: const CircleAvatar(
                       radius: 50,
                       backgroundImage: NetworkImage('https://bk.rentyourmachine.com/images/products/123.jpg',),
                     ),
                   ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  /*Row(
                    children:
                    [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: (){},
                          child: Text(
                            'Add photos',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      OutlinedButton(
                        onPressed: ()
                        {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          IconBroken.Edit_Square,
                          size: 20,
                        ),
                      ),
                    ],
                  ),*/
                  const SizedBox(
                    height: 15,
                  ),
                  defaultButton(function: ()
                  {
                    sinOut(context);
                  }
                      , text: 'LOGOUT'),
                ],
              ),
            );
          },
        );
  }
}
