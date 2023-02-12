import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/homeLayout/cubit/cubit.dart';
import '../../../layout/homeLayout/cubit/state.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/resources/color_manager.dart';


class NewPostScreen extends StatelessWidget {

  final textController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final ratingController = TextEditingController();

  NewPostScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context,state)
    {
      var pImage = HomeCubit.get(context).postImage;
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          title:  Text('Create Post',style: TextStyle(color: ColorManager.gery),),
          actions:
          [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: ()
                {
                  HomeCubit.get(context).postNewEquipment(
                      title: textController.text,
                      description: descriptionController.text,
                      photo: 'https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg',
                      price: int.parse(priceController.text),
                      rating: int.parse(ratingController.text),
                      type:HomeCubit.get(context).characters.toString() == 'SingingCharacter.Order'? 'Offer' : 'Order');
                  Navigator.pop(context);
                },
              child:  Text('Post',style: TextStyle(color: ColorManager.black),),
              ),
            )
          ],
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            },
            icon:  Icon(
                Icons.arrow_back_outlined,
              color: ColorManager.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                Row(
                  children:
                   [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        HomeCubit.get(context).userData.name,
                        style: const TextStyle(
                          height:1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller:  textController,
                  decoration:  const InputDecoration(
                    hintText: 'title',
                    labelText: 'Title',
                  ),
                ),
                TextFormField(
                  controller:  descriptionController,
                  decoration:  const InputDecoration(
                    hintText: 'Description',
                    labelText: 'Description',
                  ),
                ),
                TextFormField(
                  controller:  priceController,
                  decoration:  const InputDecoration(
                    hintText: 'price',
                    labelText: 'price',
                  ),
                ),
                TextFormField(
                  controller:  ratingController,
                  decoration:  const InputDecoration(
                    hintText: 'rating',
                    labelText: 'rating',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                if(HomeCubit.get(context).postImage != null)
                Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(pImage!),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).removePostImage() ;
                        },
                        icon: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close,
                              size: 20,
                              color: Colors.blue,)),
                      ),
                    ],
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                TextButton(
                  onPressed: () {
                  HomeCubit.get(context).getPostImage() ;
                },
                 child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                       [
                        Icon(Icons.image,color: ColorManager.gery,),
                        const SizedBox(width: 8,),
                        Text('Add photo',style: TextStyle(color: ColorManager.gery),),
                      ],
                    ),
                ),
                ListTile(
                  title: const Text('Offer'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Offer,
                    groupValue: cubit.characters,
                    activeColor: ColorManager.gery,
                    onChanged: (SingingCharacter? value) {
                      cubit.changeRadio(value!);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Order'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Order,
                    activeColor: ColorManager.gery,
                    groupValue: cubit.characters,
                    onChanged: (SingingCharacter? value) {
                      cubit.changeRadio(value!);
                    },
                  ),
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
