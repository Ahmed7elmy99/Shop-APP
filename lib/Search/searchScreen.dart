
import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/favorite.dart';
import 'package:e_commerce1/Search/cubit.dart';
import 'package:e_commerce1/Search/states.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/widgets/Text%20Form%20Field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class searchScreen extends StatelessWidget {
  searchScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchshopCubit(),
        child: BlocConsumer<SearchshopCubit, SearchStates>(
            listener: (context, state) {},
            builder: (context, state) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: kMainColor,
                  ),
                  body: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        CustomTextField(
                            keyboardType: TextInputType.text,
                            icon: Icons.search_rounded,
                            onSubmit: (String text) {
                                if (formKey.currentState!.validate()){
                            SearchshopCubit.get(context).Search(text);
                                }
                            
                            },
                            hint: 'Search For Products',
                            controller: search),
                            SizedBox(height: 10,),
                            if(state is SearchshopLoadingStates)
                            LinearProgressIndicator(),
                             SizedBox(height: 10,),
                             if(state is SearchshopSuccessStates)
                             Expanded(
                               child: ListView.separated(
                                       itemBuilder: (context,index) => buildFavItem(shopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
                                       separatorBuilder: (context, index) => SizedBox(height: 5,),
                                       itemCount: shopCubit.get(context).favoritesModel!.data!.data!.length,
                                     ),
                             ),


                      ]),
                    ),
                  ),
                )));
  }


  
      
}


 