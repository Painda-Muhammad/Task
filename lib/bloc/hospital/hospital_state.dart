part of 'hospital_bloc.dart';




abstract class HospitalState extends Equatable {
  const HospitalState();

  @override
  List<Object> get props => [];
}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<HospitalModel> hospitalModel;
  final List<CheckInModel> checkInModel;

  const HospitalLoaded({required this.hospitalModel, required this.checkInModel});

  @override
  List<Object> get props => [hospitalModel, checkInModel];
}

class HospitalError extends HospitalState {
  final String message;

  const HospitalError(this.message);

  @override
  List<Object> get props => [message];
}

class CheckInSuccess extends HospitalState {}

class CheckInAlreadyExist extends HospitalState{
  final String message;
 const CheckInAlreadyExist(this.message);
}

class CheckInFailure extends HospitalState {
  final String message;

  const CheckInFailure(this.message);

  @override
  List<Object> get props => [message];
}

class HospitalDetailsFetched extends HospitalState {
  final HospitalModel hospitalModel;

  const HospitalDetailsFetched(this.hospitalModel);

  @override
  List<Object> get props => [hospitalModel];
}
