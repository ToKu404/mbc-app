import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_event.dart';
import 'package:mbc_mobile/bloc/kabupaten_bloc/kabupaten_state.dart';
import 'package:mbc_mobile/repositories/kabupaten_repo.dart';

class KabupatenBloc extends Bloc<KabupatenEvent, KabupatenState> {
  final KabupatenRepository repository;

  KabupatenBloc(this.repository) : super(KabupatenInitialState());

  @override
  Stream<KabupatenState> mapEventToState(KabupatenEvent event) async* {
    if (event is KabupatenFetchDataEvent) {
      try {
        yield KabupatenLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.kabupatenFetchData();
        // print("KabupatenBloc ${data.kabupaten}");
        yield KabupatenLoadedState(data.kabupaten);
      } catch (e) {}
    }
  }
}
