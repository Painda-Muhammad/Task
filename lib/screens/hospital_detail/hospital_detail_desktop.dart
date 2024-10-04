import 'package:app_desk_task/globle/extensions/size_ext.dart';
import 'package:app_desk_task/models/hospital_model.dart';
import 'package:flutter/material.dart';

class HospitalDetailDesktop extends StatelessWidget {
  const HospitalDetailDesktop({super.key, required this.hospitalModelDetail});
  final HospitalModel hospitalModelDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: context.width * .40),
          width: double.infinity,
          child: Image.network(
            hospitalModelDetail.imageUrl.toString(),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          children: [
            const Text(
              'Short Discription About Hospital',
              style: TextStyle(
                  fontSize: 25, wordSpacing: 1.2, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: context.width*.40,
              child: Expanded(
                child: Text(hospitalModelDetail.description.toString()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
