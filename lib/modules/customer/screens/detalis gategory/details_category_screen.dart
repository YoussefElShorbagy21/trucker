import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/shared/resources/app_localizations.dart';

import '../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../home/cubit/state.dart';
class DetailsCategoryScreen extends StatelessWidget {
  String id ;
  DetailsCategoryScreen(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeScreenCubit()..getDetailsCategoryData(id),
  child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = HomeScreenCubit.get(context).getDetailsEquipment.equipment ;
    return Scaffold(
      appBar: AppBar(
        title: Text(cubit.category),
        toolbarHeight: 70,
        elevation: 0,
        leading: IconButton(
            onPressed: (){
          Navigator.pop(context);
        },
            icon:  Icon(Icons.arrow_back_sharp,size: 30,color: ColorManager.black,)) ,
        actions:  [IconButton(
            onPressed: (){
          Navigator.pop(context);
        },
            icon:  Icon(Icons.share,size: 30,color: ColorManager.black,)) ,],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                cubit.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: ColorManager.black
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(cubit.photo,),
                    fit: BoxFit.cover,),
                  borderRadius: BorderRadius.circular(20)
                  ,)
                ),
              Text(
                'Overview',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: ColorManager.black
                ),
              ),
              Text(
                cubit.description,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: ColorManager.gery
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:  [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                          decoration: BoxDecoration(
                            color: ColorManager.blueGrey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(Icons.location_pin,size: 35,),
                        ),
                        Text(cubit.government,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                          fontSize: 15,
                        ),),
                      ],

                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:  [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                          decoration: BoxDecoration(
                            color: ColorManager.blueGrey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(Icons.category,size: 35,),
                        ),
                        Text(cubit.category,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                          fontSize: 15,
                        ),),
                      ],

                    ),
                  ),
                ],
              ),
              Text(
                'Trucker',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: ColorManager.black
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage('https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg'),
                    ),
                  ),
                  Text(
                    HomeCubit.get(context).userData.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ColorManager.blueGrey
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                      color: ColorManager.blueGrey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.message,size: 20,),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 18,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                      color: ColorManager.blueGrey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.call,size: 20,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          color: ColorManager.blueGrey,
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                '\$ ${cubit.price.toString()}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: ColorManager.black
                ),
              ),
              const Spacer(),
              Container(
              width: 180,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width/50,
              ),
              child: TextButton(
                onPressed:(){},
                style: TextButton.styleFrom(
                  shape:  BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: ColorManager.black,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child:  Text('rent-title'.tr(context),
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
        ),
      ),
    );
  },
),
);
  }
}

