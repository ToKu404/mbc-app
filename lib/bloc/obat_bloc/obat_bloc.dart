import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/obat_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_master_repo.dart';

part 'obat_event.dart';
part 'obat_state.dart';

class ObatBloc extends Bloc<ObatEvent, ObatState> {
  PerlakuanMasterRepository repository;
  ObatBloc(this.repository) : super(ObatInitialState());

  @override
  Stream<ObatState> mapEventToState(ObatEvent event) async* {
    if (event is ObatFetchDataEvent) {
      try {
        yield ObatLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.obatFetchData();
        yield ObatLoadedState(model: data);
      } catch (e) {
        yield ObatErrorState(errorMsg: e.toString());
      }
    }
  }
}
