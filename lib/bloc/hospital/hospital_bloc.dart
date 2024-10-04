import 'dart:async';
import 'dart:convert';

import 'package:app_desk_task/models/checkin_model.dart';
import 'package:app_desk_task/models/hospital_model.dart';
import 'package:app_desk_task/repositories/check_in_repository.dart';
import 'package:app_desk_task/repositories/event_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


part 'hospital_event.dart';
part 'hospital_state.dart';


class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final EventRepository eventRepository;
  final CheckInRepository checkInRepository;
  StreamSubscription? connectivitySubscription;

  HospitalBloc({required this.eventRepository, required this.checkInRepository})
      : super(HospitalInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<CheckInEvent>(_onCheckInEvent);
    on<FetchEventDetails>(_onFetchEventDetails);
    on<SyncCheckIns>(_onSyncCheckIns);

    // Listen to connectivity changes
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains( ConnectivityResult.none)) {
        add(SyncCheckIns());
      }
    });
  }

  Future<void> _onLoadEvents(
      LoadEvents event, Emitter<HospitalState> emit) async {
    emit(HospitalLoading());
    try {

      final events = await eventRepository.fetchHospitalsInfo();


      final checkIns = await checkInRepository.getAllCheckIns();
      emit(HospitalLoaded(hospitalModel: events, checkInModel: checkIns));
    } catch (e) {
      emit(HospitalError('Failed to load events: ${e.toString()}'));
    }
  }

  Future<void> _onCheckInEvent(
      CheckInEvent event, Emitter<HospitalState> emit) async {
    try {
  
    var uuid = const Uuid();

    CheckInModel checkIn = CheckInModel(
      id: uuid.v4(),
      hospitalId: event.hospitalModel.id.toString(),
      hospitalName:event.hospitalModel.hospitalName.toString(),
      // userId: userId,
      timestamp: DateTime.now(),
      synced: false,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> checkIns = prefs.getStringList('check_ins') ?? [];

     // Convert stored JSON check-ins to List<CheckInModel>
  final List<CheckInModel?> _hospitalInfo = checkIns.map((hospital) {
    final h = json.decode(hospital);
    return CheckInModel.fromJson(h);
  }).toList();

  print('_______savedList:$_hospitalInfo');

  // Check if hospital already exists
  CheckInModel? hospitalModel = _hospitalInfo.firstWhere(
    (hospital) => hospital!.hospitalId == event.hospitalModel.id.toString(),
    orElse: () => CheckInModel(),  // Return null if not found
  );

  print('_______savedList: ${hospitalModel!.id}');


  
  if(hospitalModel.id == null){

    checkIns.add(json.encode(checkIn.toJson()));
    await prefs.setStringList('check_ins', checkIns);

    // Try syncing immediately
   await checkInRepository.syncCheckIns();

   
      emit(CheckInSuccess());
      // Reload events to update check-ins
      add(LoadEvents());
  }
  else  {
     emit(const CheckInAlreadyExist('Already Hospital Exist'));
     add(LoadEvents());
    return;
  }


    } catch (e) {
      emit(CheckInFailure('Check-in failed: ${e.toString()}'));
    }
  }

  Future<void> _onFetchEventDetails(
      FetchEventDetails event, Emitter<HospitalState> emit) async {
    try {
      final detailedEvent =
          await eventRepository.fetchEventDetails(event.hospitalModel.id.toString());
      emit(HospitalDetailsFetched(detailedEvent));
      
      // Optionally, update the event list with detailed info
      add(LoadEvents());
    } catch (e) {
      emit(HospitalError('Failed to fetch event details: ${e.toString()}'));
    }
  }

  Future<void> _onSyncCheckIns(
      SyncCheckIns event, Emitter<HospitalState> emit) async {
    try {
      await checkInRepository.syncCheckIns();

      // Optionally, reload events/check-ins
      add(LoadEvents());
    } catch (e) {

      // Handle sync failure silently or emit a state
      emit(HospitalError('Failed to sync check-ins: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
