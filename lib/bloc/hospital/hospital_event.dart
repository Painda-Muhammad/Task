part of 'hospital_bloc.dart';



abstract class HospitalEvent extends Equatable {
  const HospitalEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends HospitalEvent {}

class CheckInEvent extends HospitalEvent {
  final HospitalModel hospitalModel;

  const CheckInEvent(this.hospitalModel);

  @override
  List<Object> get props => [hospitalModel];
}

class FetchEventDetails extends HospitalEvent {
  final HospitalModel hospitalModel;

  const FetchEventDetails(this.hospitalModel);

  @override
  List<Object> get props => [hospitalModel];
}

class SyncCheckIns extends HospitalEvent {}
