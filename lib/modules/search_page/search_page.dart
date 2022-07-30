import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SearchScreen extends StatelessWidget {

const SearchScreen({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
  var searchController = TextEditingController();

  dynamic seachedFood=[];

  return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return  Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (food){
                      if(searchController.text.isEmpty){
                        showToast(
                          text: 'Please enter a word to search for',
                          success: false,
                        );
                      }else {
                        seachedFood=AppCubit.get(context).searchFood(
                            searchController.text);

                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const SizedBox(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if(searchController.text.isEmpty){
                              showToast(
                                  text: 'Please enter a word to search for',
                                success: false,
                              );
                            }else {
                              AppCubit.get(context).searchFood(
                                  searchController.text);
                            }
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              )),
          body: ConditionalBuilder(
            condition: state is! SearchFoodFailState,
            builder:(context)
            => GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (80/100),  //itemWidth / itemHeight
              children: List.generate(seachedFood.length, (index) {
                //AppCubit.get(context).foodObjects.length
                return Center(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: imageCreator(seachedFood[index]),
                    ));
              }),
            ) ,
            fallback:(context)=>const Text(
                "Please try something else",
            style: TextStyle(
            color: textColor, fontSize: 20.0
            ),
          )
          ),
        );
      });
}







}

