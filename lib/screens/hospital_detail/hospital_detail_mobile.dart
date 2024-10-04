import 'package:app_desk_task/globle/extensions/size_ext.dart';
import 'package:app_desk_task/models/hospital_model.dart';
import 'package:flutter/material.dart';

class HospitalDetailMobile extends StatelessWidget {
  const HospitalDetailMobile({super.key,required  this.hospitalModelDetail});
  final HospitalModel hospitalModelDetail;
  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: context.width*.70
                ),
                width: double.infinity,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(hospitalModelDetail.imageUrl.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Short Discription About Hospital',
                style: TextStyle(
                    fontSize: 25, wordSpacing: 1.2, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(hospitalModelDetail.description.toString())
            ],
          );
  }
}