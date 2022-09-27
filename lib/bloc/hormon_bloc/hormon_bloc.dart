import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/hormon_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_master_repo.dart';

part 'hormon_event.dart';
part 'hormon_state.dart';

class HormonBloc extends Bloc<HormonEvent, HormonState> {
  final PerlakuanMasterRepository repository;

  HormonBloc(this.repository) : super(HormonInitialState());

  @override
  Stream<HormonState> mapEventToState(HormonEvent event) async* {
    if (event is HormonFetchDataEvent) {
      try {
        yield HormonLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.hormonFetchData();
        yield HormonLoadedState(model: data);
      } catch (e) {
        yield HormonErrorState(errorMsg: e.toString());
      }
    }
  }
}
