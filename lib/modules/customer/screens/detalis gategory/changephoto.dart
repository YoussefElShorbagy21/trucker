import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/select_photo_options_screen.dart';
import '../home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePhoto extends StatelessWidget {
  String id ;

  ChangePhoto({required this.id,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state){},
      builder: (context, state) {
        print(HomeScreenCubit.get(context).newPostImage);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                      height: 300,
                      margin: const EdgeInsets.all(5),
                      decoration: HomeScreenCubit.get(context).newPostImage != null ? BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image:  DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(HomeScreenCubit.get(context).newPostImage!),
                        ),
                      ) : BoxDecoration(
                        color: const Color(0XFF408080),
                        borderRadius: BorderRadius.circular(15.0),
                      )
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        _showSelectPhotoOptionsNew(context) ;
                      }
                        , icon:
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add,
                            size: 30,
                            color: Color(0XFF408080),),),),
                      const Text('Add Image',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width/35,
                ),
                child: TextButton(
                  onPressed:(){
                    HomeScreenCubit.get(context).updateImagePostData(id: id,
                        photo: HomeScreenCubit.get(context).newPostImage);

                    Navigator.pop(context);
                  } ,
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromRGBO(255, 188, 0,1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child:  Text("confirm".tr(context),
                    style: TextStyle(
                      color: ColorManager.white,
                      fontFamily: FontConstants.fontFamily,
                      fontSize: FontSize.s22,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
);
  }
}

void _showSelectPhotoOptionsNew(BuildContext context) {
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
            child:  SelectPhotoOptionsScreen(
              onTap: HomeScreenCubit.get(context).getNewPostImage,
            ),
          );
        }),
  );
}