import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/master_sapi_model.dart';
import 'package:mbc_mobile/repositories/sapi_master_repo.dart';

part 'sapi_master_event.dart';
part 'sapi_master_state.dart';

class SapiMasterBloc extends Bloc<SapiMasterEvent, SapiMasterState> {
  final SapiMasterRepository repository;

  SapiMasterBloc(this.repository) : super(SapiMasterInitial());

  @override
  Stream<SapiMasterState> mapEventToState(SapiMasterEvent event) async* {
    if (event is SapiMasterFetchDataEvent) {
      try {
        yield SapiMasterLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.sapiMasterFetchData();
        yield SapiMasterLoadedState(model: data);
      } catch (e) {
        yield SapiMasterErrorState(errorMsg: e.toString());
      }
    }
  }
}
