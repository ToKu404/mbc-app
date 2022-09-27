import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/laporan_model.dart';
import 'package:mbc_mobile/repositories/laporan_repo.dart';

part 'laporan_event.dart';
part 'laporan_state.dart';

class LaporanBloc extends Bloc<LaporanEvent, LaporanState> {
  final LaporanRepository repository;
  LaporanBloc(this.repository) : super(LaporanInitialState());

  @override
  Stream<LaporanState> mapEventToState(LaporanEvent event) async* {
    if (event is LaporanFetchDataEvent) {
      try {
        yield LaporanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.laporanFetchByUserId(event.userId);
        yield LaporanLoadedState(data);
      } catch (e) {
        yield LaporanErrorState(e.toString());
      }
    }
  }
}
