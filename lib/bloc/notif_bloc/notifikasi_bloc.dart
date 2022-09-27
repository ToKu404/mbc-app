import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/notifikasi_model.dart';
import 'package:mbc_mobile/repositories/notifikasi_repo.dart';

part 'notifikasi_event.dart';
part 'notifikasi_state.dart';

class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  NotifikasiRepository repository;

  NotifikasiBloc(this.repository) : super(NotifikasiInitialState());
  NotifikasiState get initialState => NotifikasiInitialState();

  @override
  Stream<NotifikasiState> mapEventToState(NotifikasiEvent event) async* {
    if (event is NotifFetchByUserId) {
      try {
        yield NotifikasiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.notifFetchByUserId(event.id);
        yield NotifikasiSuccessState(datas: data);
      } catch (e) {
        yield NotifikasiErrorState(error: e.toString());
      }
    }
  }
}
