import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/metode_model.dart';
import 'package:mbc_mobile/repositories/metode_repo.dart';

part 'metode_event.dart';
part 'metode_state.dart';

class MetodeBloc extends Bloc<MetodeEvent, MetodeState> {
  MetodeRepository metodeRepository;
  MetodeBloc(this.metodeRepository) : super(MetodeInitialState());

  @override
  Stream<MetodeState> mapEventToState(MetodeEvent event) async* {
    if (event is MetodeFetchDataEvent) {}
    try {
      yield MetodeLoadingState();
      await Future.delayed(const Duration(milliseconds: 30));
      final data = await metodeRepository.metodeFetchData();
      yield MetodeLoadedState(data);
    } catch (e) {
      yield MetodeErrorState(e.toString());
    }
  }
}
