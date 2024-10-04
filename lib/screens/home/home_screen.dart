import 'package:app_desk_task/bloc/hospital/hospital_bloc.dart';
import 'package:app_desk_task/globle/responsive/responsive.dart';

import 'package:app_desk_task/globle/utils/toast_message.dart';
import 'package:app_desk_task/screens/home/hospital_destop.dart';
import 'package:app_desk_task/screens/home/hospital_mobile.dart';
import 'package:app_desk_task/screens/home/hospital_tablet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Check-In'),
      ),
      body: BlocConsumer<HospitalBloc, HospitalState>(
        listener: (context, state) {
          if (state is CheckInSuccess) {
            showSnackBar(context, 'Check-in successful!');
          } else if (state is CheckInAlreadyExist) {
            showSnackBar(context, state.message);
          } else if (state is CheckInFailure) {
            showSnackBar(context, state.message);
          } else if (state is HospitalError) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is HospitalLoading || state is HospitalError) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HospitalLoaded) {
            if (Responsive.isMobile(context)) {
              return HospitalMobile(hospitalModel: state.hospitalModel);
            } else if (Responsive.isDesktop(context)) {
              return HospitalDestop(hospitalModel: state.hospitalModel);
            } else {
              return HospitalTablet(hospitalModel: state.hospitalModel);
            }
          } else if (state is HospitalError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
