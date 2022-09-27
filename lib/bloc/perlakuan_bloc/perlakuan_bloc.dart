import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/perlakuan_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_repo.dart';

part 'perlakuan_event.dart';
part 'perlakuan_state.dart';

class PerlakuanBloc extends Bloc<PerlakuanEvent, PerlakuanState> {
  final PerlakuanRepository repository;

  PerlakuanBloc(this.repository) : super(PerlakuanInitialState());

  @override
  Stream<PerlakuanState> mapEventToState(PerlakuanEvent event) async* {
    if (event is PerlakuanFetchDataEvent) {
      try {
        yield PerlakuanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.perlakuanFetchData(event.userId);
        yield PerlakuanLoadedState(data.perlakuan);
      } catch (e) {}
    } else if (event is PerlakuanStoreEvent) {
      try {
        yield PerlakuanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.perlakuanStore(
            event.file, event.perlakuan, event.notifikasiId);
        if (data.responsecode == "1") {
          yield PerlakuanSuccessState(data.responsemsg);
        } else {
          yield PerlakuanErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is PerlakuanDeleteEvent) {
      try {
        yield PerlakuanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.perlakuanDelete(event.perlakuan);
        if (data.responsecode == "1") {
          yield PerlakuanSuccessState(data.responsemsg);
        } else {
          yield PerlakuanErrorState(data.responsemsg);
        }
      } catch (e) {}
    }
  }
}
