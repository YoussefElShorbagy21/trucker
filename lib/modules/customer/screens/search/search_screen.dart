import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:login/modules/customer/screens/home/cubit/cubit.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';

import '../../../../shared/components/components.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic list = HomeScreenCubit
            .get(context)
            .search;
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
                  enabled: true,
                  onChanged: (value) {
                    HomeScreenCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search)
                  ),
                ),
              ),
              Expanded(child: articleBuilder(
                  list, list.length, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}