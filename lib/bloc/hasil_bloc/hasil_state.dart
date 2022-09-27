part of 'hasil_bloc.dart';

abstract class HasilState extends Equatable {
  const HasilState();

  @override
  List<Object> get props => [];
}

class HasilInitialState extends HasilState {}

class HasilLoadingState extends HasilState {}

class HasilErrorState extends HasilState {
  final String errorMsg;

  HasilErrorState(this.errorMsg);
}

class HasilSuccessState extends HasilState {
  final String successMsg;

  HasilSuccessState(this.successMsg);
}

class HasilLoadedState extends HasilState {
  final HasilModel hasilModel;

  HasilLoadedState(this.hasilModel);
}
