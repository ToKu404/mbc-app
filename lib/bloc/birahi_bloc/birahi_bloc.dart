import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/repositories/birahi_repo.dart';

part 'birahi_event.dart';
part 'birahi_state.dart';

class BirahiBloc extends Bloc<BirahiEvent, BirahiState> {
  final BirahiRepository repository;

  BirahiBloc(this.repository) : super(BirahiInitial());

  @override
  Stream<BirahiState> mapEventToState(BirahiEvent event) async* {
    if (event is BirahiStoreEvent) {
      try {
        yield BirahiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.birahiStore(
            event.notifId, event.result, event.tanggal);
        if (data.responsecode == "1") {
          yield BirahiSuccessState(data.responsemsg);
        } else {
          yield BirahiErrorState("Something Error");
        }
      } catch (e) {
        yield BirahiErrorState(e.toString());
      }
    }
  }
}
