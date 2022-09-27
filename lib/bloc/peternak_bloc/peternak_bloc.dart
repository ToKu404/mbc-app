import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_event.dart';
import 'package:mbc_mobile/bloc/peternak_bloc/peternak_state.dart';
import 'package:mbc_mobile/repositories/peternak_repo.dart';

class PeternakBloc extends Bloc<PeternakEvent, PeternakState> {
  final PeternakRepository repository;

  PeternakBloc(this.repository) : super(PeternakInitialState());

  @override
  Stream<PeternakState> mapEventToState(PeternakEvent event) async* {
    if (event is PeternakFetchDataEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakFetchData(event.userId);
        yield PeternakLoadedState(data.peternak);
      } catch (e) {
        yield PeternakErrorState(e.toString());
      }
    } else if (event is PeternakStoreEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakStore(event.peternak);
        if (data.responsecode == "1") {
          yield PeternakSuccessState(data.responsemsg);
        } else {
          yield PeternakErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is PeternakUpdateEvent) {
      try {
        yield PeternakLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.peternakUpdate(event.peternak);
        if (data.responsecode == "1") {
          yield PeternakSuccessState(data.responsemsg);
        } else {
          yield PeternakErrorState(data.responsemsg);
        }
      } catch (e) {}
    }
  }
}
