import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/pages/saved/widget/saved_favorite_car_card.dart';
import 'package:flutter_rent/core/presentation/presenters/enums/status_saved_page.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_saved_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/search_text.dart';
import 'package:get/get.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({ Key? key }) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {

  final GetxSavedPresenter savedPresenter = Get.put(Modular.get<GetxSavedPresenter>());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savedPresenter.loadFavoritesCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 25),
                    child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Saved", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            children: [
                              SearchText(
                                onSubmitted: (String search){
                                  savedPresenter.searchList(search);
                                },
                              ),
                              SizedBox(height: 20,),
                            ],
                          )
                        ),
                      ],
                    ),
                  )
                ]
              )
            ),
            SliverPadding(
                padding: EdgeInsets.zero,
                sliver: Obx(() { 
                  switch(savedPresenter.statusGetFavoritesCar.value){
                    case StatusGetFavoritesCar.loading:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]
                        )
                      );
                
                    case StatusGetFavoritesCar.error:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: Text("Failed on load favorites cars"),
                            )
                          ]
                        )
                      );
                    
                    case StatusGetFavoritesCar.noInternetConnection:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: Text("No internet connection"),
                            )
                          ]
                        )
                      );
        
                    case StatusGetFavoritesCar.completed:
                      if(savedPresenter.filteredFavoritesCarList.isNotEmpty){
                        return Obx(
                          () => 
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index){
                                return SavedFavoriteCarCard(
                                  carModel: savedPresenter.filteredFavoritesCarList[index],
                                  onPressedBookMarker: (CarModel carModel) {
                                    savedPresenter.removeFavoriteCarOfList(carModel);
                                  },
                                  onPressButton: (CarModel carModel) {
                                    savedPresenter.goToPickRentDate(carModel);
                                  },
                                );
                              },
                              childCount: savedPresenter.favoritesPresenter.favoritesList.length
                            )
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child:
                                Text("You don't own any saved car")
                            )
                          ]
                        )
                      );
                  }
                })
              )
          ],
        )
      ),
    );
  }
  
}