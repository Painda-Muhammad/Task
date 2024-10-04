
import 'package:app_desk_task/bloc/hospital/hospital_bloc.dart';
import 'package:app_desk_task/globle/utils/dateformat.dart';
import 'package:app_desk_task/models/hospital_model.dart';
import 'package:app_desk_task/screens/hospital_detail/hospital_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalTablet extends StatelessWidget {
  const HospitalTablet({super.key,required  this.hospitalModel});
 final List<HospitalModel> hospitalModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     padding: const EdgeInsets.all(10.0),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0, 
          childAspectRatio: 1, 
        ),
        itemCount:hospitalModel.length,
       itemBuilder: (context,index){
        final event = hospitalModel[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(event.hospitalName.toString()),
                      subtitle: Text(formatDate(event.openTime.toString())),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'check_in') {
                            context
                                .read<HospitalBloc>()
                                .add(CheckInEvent(event));
                          } else if (value == 'fetch_details') {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HospitalDetailScreen(
                                        hospitalModelDetail: event)));
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'check_in',
                            child: Text('Check In'),
                          ),
                          const PopupMenuItem(
                            value: 'fetch_details',
                            child: Text('Fetch Details'),
                          ),
                        ],
                      ),
                    ),
                  );
    });
  }
}

