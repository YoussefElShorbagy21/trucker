import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/homeLayout/cubit/cubit.dart';
import '../../../layout/homeLayout/cubit/state.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener:(context , state) {},
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'search must not be empty';
                        }
                        return null ;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}