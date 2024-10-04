import 'package:app_desk_task/globle/responsive/responsive.dart';
import 'package:app_desk_task/models/hospital_model.dart';
import 'package:app_desk_task/screens/hospital_detail/hospital_detail_desktop.dart';
import 'package:app_desk_task/screens/hospital_detail/hospital_detail_mobile.dart';
import 'package:flutter/material.dart';

class HospitalDetailScreen extends StatelessWidget {
  const HospitalDetailScreen({super.key, required this.hospitalModelDetail});
  final HospitalModel hospitalModelDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Responsive.isMobile(context)
              ? HospitalDetailMobile(
                  hospitalModelDetail: hospitalModelDetail,
                )
              : HospitalDetailDesktop(hospitalModelDetail: hospitalModelDetail),
        ),
      ),
    );
  }
}
