import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/entities/car_model.dart';
import 'package:flutter_rent/core/presentation/pages/rents/widgets/dynamic_car_card.dart';
import 'package:flutter_rent/core/presentation/presenters/enums/status_rents_page.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rents_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/search_text.dart';
import 'package:get/get.dart';

class RentsPage extends StatefulWidget {
  const RentsPage({ Key? key }) : super(key: key);

  @override
  _RentsPageState createState() => _RentsPageState();
}

class _RentsPageState extends State<RentsPage> {

  final GetxRentsPresenter rentsPresenter = Get.put(Modular.get<GetxRentsPresenter>());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(rentsPresenter.rentCarModelList.isEmpty){
      rentsPresenter.getAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: rentsPresenter.getAll,
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
                          child: Text("Rents", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                            child: Column(
                              children: [
                                SearchText(
                                  onSubmitted: (String search){
                                    rentsPresenter.searchList(search);
                                  },
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: MediaQuery.of(context).size.width-40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFFF8E496),
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Obx(() => 
                                          GestureDetector(
                                            onTap: (){
                                              rentsPresenter.setSelectedItem(0);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: rentsPresenter.selectedItem.value == 0 ? Colors.white : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              width: 100,
                                              padding: EdgeInsets.all(3),
                                              child: Center(child: Text("Completed", style: TextStyle(fontWeight: FontWeight.w600),),),
                                            ),
                                          ),
                                        ),
                                        Obx(() => 
                                          GestureDetector(
                                            onTap: (){
                                              rentsPresenter.setSelectedItem(1);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: rentsPresenter.selectedItem.value == 1 ? Colors.white : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              width: 100,
                                              padding: EdgeInsets.all(3),
                                              child: Center(child: Text("In Progress", style: TextStyle(fontWeight: FontWeight.w600)),),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                ),
                                
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
                  switch(rentsPresenter.statusGetUserRentCars.value){
                    case StatusGetUserRentCars.loading:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]
                        )
                      );
                
                    case StatusGetUserRentCars.error:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: Text("Failed on load rental cars"),
                            )
                          ]
                        )
                      );
                    
                    case StatusGetUserRentCars.noInternetConnection:
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child: Text("No internet connection"),
                            )
                          ]
                        )
                      );
        
                    case StatusGetUserRentCars.completed:
                      if(rentsPresenter.filteredRentCarModelList.isNotEmpty){
                        return Obx(
                          () => 
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index){
                              if(rentsPresenter.selectedItem.value == 0){
                                return DynamicRentCarCard(
                                  onPressButton: (CarModel carModel) {
                                    rentsPresenter.goToPickRentDate(carModel);
                                  },
                                  rentCarModel: rentsPresenter.filteredRentCarModelList[index],
                                );
                              } else {
                                return DynamicRentCarCard(
                                  rentCarModel: rentsPresenter.filteredRentCarModelList[index],
                                );
                              }
                            },
                            childCount: rentsPresenter.filteredRentCarModelList.length
                          )
                        )
                        );
                      }
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Center(
                              child:
                                Text("You don't own any rental car")
                            )
                          ]
                        )
                      );
                  }
                })
              )
            ],
          ),
        )
      ),
    );
  }
}