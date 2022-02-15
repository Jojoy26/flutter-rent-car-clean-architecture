// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/presentation/pages/categories/widgets/brand_card.dart';
import 'package:flutter_rent/core/presentation/pages/categories/widgets/car_card.dart';
import 'package:flutter_rent/core/presentation/pages/categories/widgets/shimmer_brand.dart';
import 'package:flutter_rent/core/presentation/pages/categories/widgets/shimmer_car.dart';
import 'package:flutter_rent/core/presentation/presenters/enums/status_categories_page.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_categories_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/search_text.dart';


import 'package:flutter_rent/utils/brands_list.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({ Key? key }) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>{

  GetxCategoriesPresenter categoriesPresenter = Get.put(Modular.get<GetxCategoriesPresenter>());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(categoriesPresenter.carsList.isEmpty){
      categoriesPresenter.getAll();
    }
  } 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context){
            return RefreshIndicator(
              onRefresh: categoriesPresenter.getAll,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                  SizedBox(height: 10,),
                                  SearchText(onSubmitted: categoriesPresenter.callGetCarsBySearch,)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[200],
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.auto_awesome_motion_rounded, color: Color(0xFFDBB51A), size: 21,),
                                SizedBox(width: 3,),
                                Text("Brands", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                              ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            SizedBox(
                              height: 60,
                              child: Obx(() {
                                switch(categoriesPresenter.statusGetBrands.value){
                                  case StatusGetBrands.loading:
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index){
                                        return (
                                          ShimmerBrand()
                                        );
                                      }
                                    );
            
                                  case StatusGetBrands.error:
                                    return Center(
                                      child: Text("Error on load brands"),
                                    );
            
                                  case StatusGetBrands.noConnectionInternet:
                                    return Center(
                                      child: Text("No internet connection"),
                                    );
            
                                  case StatusGetBrands.completed:
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categoriesPresenter.brandsList.length,
                                      itemBuilder: (context, index){
                                        return Obx(() =>
                                          BrandCard(
                                            brand: categoriesPresenter.brandsList[index], 
                                            onTap: () {
                                              categoriesPresenter.callGetCarsByBrand(categoriesPresenter.brandsList[index].brand, index);
                                            },
                                            index: index,
                                            currentSelectIndex: categoriesPresenter.brandSelectIndex.value
                                          )
                                        );
                                      }
                                    );
                                }
                              } 
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(10),
                    sliver: Obx(() {
                      switch(categoriesPresenter.statusGetCars.value){
                        case StatusGetCars.loading:
                        print("Eu loading");
                          return SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index){
                                return ShimmerCar();
                              },
                              childCount: 5,
                            ),
                          );
            
                        case StatusGetCars.error:
                          return SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Center(
                                  child: Text("Failed on load cars"),
                                )
                              ]
                            )
                          );
                        
                        case StatusGetCars.noConnectionInternet:
                          return SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Center(
                                  child: Text("No internet Connection"),
                                )
                              ]
                            )
                          );
            
                        case StatusGetCars.completed:
                          if(categoriesPresenter.carsList.length > 0){
                            return SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 1
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index){
                                  return CarCard(index: index, onTap: (){
                                    categoriesPresenter.goToCarDetails(categoriesPresenter.carsList[index]);
                                  }, carModel: categoriesPresenter.carsList[index],);
                                },
                                childCount: categoriesPresenter.carsList.length,
                              ),
                            );
                          }
                          return SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Center(
                                  child: Text("No results for your search"),
                                )
                              ]
                            )
                          ); 
                      }
                    })
                  )
                ],
              ),
            );
          }
        )
      ),
    );
  }
}