import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/panen_model.dart';
import 'package:mbc_mobile/repositories/panen_repo.dart';

part 'panen_event.dart';
part 'panen_state.dart';

class PanenBloc extends Bloc<PanenEvent, PanenState> {
  final PanenRepository repository;

  PanenBloc(this.repository) : super(PanenInitial());
  @override
  Stream<PanenState> mapEventToState(PanenEvent event) async* {
    if (event is PanenFetchDataEvent) {
      try {
        yield PanenLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.panenFetchData(event.id);
        yield PanenLoadeState(data);
      } catch (e) {
        yield PanenErrorState(e.toString());
      }
    } else if (event is PanenStoreEvent) {
      try {
        yield PanenLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data =
            await repository.panenStore(event.file, event.panen, event.notifId);
        if (data.responsecode == "1") {
          yield PanenSuccessState(data.responsemsg);
        } else {
          yield PanenErrorState(data.responsemsg);
        }
      } catch (e) {}
    }
  }
}
