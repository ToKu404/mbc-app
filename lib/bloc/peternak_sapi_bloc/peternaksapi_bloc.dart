import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/peternak_sapi_model.dart';
import 'package:mbc_mobile/repositories/peternak_sapi_repo.dart';

part 'peternaksapi_event.dart';
part 'peternaksapi_state.dart';

class PeternaksapiBloc extends Bloc<PeternaksapiEvent, PeternaksapiState> {
  final PeternakSapiRepository repository;

  PeternaksapiBloc({required this.repository})
      : super(PeternaksapiInitialState());

  @override
  Stream<PeternaksapiState> mapEventToState(PeternaksapiEvent event) async* {
    if (event is PeternakSapiFetchDataEvent) {
      try {
        yield PeternaksapiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakSapiFetchData(event.id);
        yield PeternaksapiLoadedState(model: data);
      } catch (e) {
        yield PeternaksapiErrorState(errorMsg: e.toString());
      }
    }
  }
}
