// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter_rent/core/presentation/presenters/getx_pick_rent_date_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PickRentDate extends StatefulWidget {
  const PickRentDate({ Key? key }) : super(key: key);

  @override
  State<PickRentDate> createState() => _PickRentDateState();
}

class _PickRentDateState extends State<PickRentDate> {

  GetxPickRentDatePresenter pickRentDatePresenter = Modular.get<GetxPickRentDatePresenter>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '#%:&*',
      filter: {"#": RegExp(r'[0-1]'), "%": RegExp(r'[0-9]'), "&": RegExp(r'[0-5]'), "*": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    SfDateRangePicker(
                      view: DateRangePickerView.month,
                      selectionMode: DateRangePickerSelectionMode.range,
                      enablePastDates: false,
                      monthViewSettings: DateRangePickerMonthViewSettings(),
                      onSelectionChanged: pickRentDatePresenter.onSelectionChanged,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("From", style: TextStyle(fontWeight: FontWeight.w600),),
                                Container(
                                  height: 27,
                                  width: 65,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF3D964),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Obx(() => Text(pickRentDatePresenter.fromDate.value)),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("To", style: TextStyle(fontWeight: FontWeight.w600),),
                                Container(
                                  height: 27,
                                  width: 65,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF3D964),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Obx(() => Text(pickRentDatePresenter.toDate.value)),
                                ),
                              ],
                            ),
                            Obx(() => Visibility(
                                  visible: pickRentDatePresenter.messageErrorDate.value != "",
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(pickRentDatePresenter.messageErrorDate.value, style: TextStyle(color: Colors.red),),
                                      ),
                                    ),
                                  ),
                            ),
                            SizedBox(height: 15,),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Time", style: TextStyle(fontWeight: FontWeight.w600),),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 27,
                                            width: 65,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF3D964),
                                              borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: TextFormField(
                                              inputFormatters: [maskFormatter],
                                              controller: pickRentDatePresenter.controllerHour,
                                              textAlignVertical: TextAlignVertical.center,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none
                                              )
                                            )
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            height: 28,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF3D964),
                                              borderRadius: BorderRadius.circular(4)
                                            ),
                                            padding: EdgeInsets.all(2),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){pickRentDatePresenter.changeSelectAmOrPm(0);},
                                                  child: Obx(() => Container(
                                                    width: 40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2),
                                                      color: pickRentDatePresenter.amOrpm.value == 0 ? Colors.white : Colors.transparent,
                                                    ),
                                                    padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                                    child: Text("AM", style: TextStyle(fontSize: 14),),
                                                  ),)
                                                ),
                                                SizedBox(width: 5,),
                                                GestureDetector(
                                                  onTap: (){pickRentDatePresenter.changeSelectAmOrPm(1);},
                                                  child: Obx(() => Container(
                                                    width: 40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(2),
                                                      color: pickRentDatePresenter.amOrpm.value == 1 ? Colors.white : Colors.transparent,
                                                    ),
                                                    padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                                                    child: Text("PM", style: TextStyle(fontSize: 14),),
                                                  ),)
                                                )
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => Visibility(
                                  visible: pickRentDatePresenter.messageErrorTime.value != "",
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(pickRentDatePresenter.messageErrorTime.value, style: TextStyle(color: Colors.red),),
                                      ),
                                    ),
                                  )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ),
              SizedBox(height: 50,),
              customButton("Checkout", (){
                pickRentDatePresenter.validateFields();
                pickRentDatePresenter.goToCheckout();
              })
            ],
          )
        )
      )
    );
  }
}