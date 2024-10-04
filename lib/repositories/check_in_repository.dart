
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/checkin_model.dart';


class CheckInRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userId = 'user_123';

  Future<void> syncCheckIns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> checkIns = prefs.getStringList('check_ins') ?? [];

    for (String checkInJson in checkIns) {
      CheckInModel checkIn = CheckInModel.fromJson(json.decode(checkInJson));
      if (!checkIn.synced) {
        await firestore.collection('check_ins').doc(checkIn.id).set({
          'hospitalId': checkIn.hospitalId,
          'eventName': checkIn.hospitalName,
          'userId': checkIn.userId,
          'timestamp': checkIn.timestamp!.toIso8601String(),
        });
        checkIn.synced = true;
        // Update local storage
        prefs.setStringList(
          'check_ins',
          checkIns.map((ci) {
            if (ci.contains(checkIn.id!)) {
              return json.encode(checkIn.toJson());
            }
            return ci;
          }).toList(),
        );
      }
    }
  }



  Future<List<CheckInModel>> getAllCheckIns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> checkIns = prefs.getStringList('check_ins') ?? [];
    return checkIns.map((ci) => CheckInModel.fromJson(json.decode(ci))).toList();
  }
}
