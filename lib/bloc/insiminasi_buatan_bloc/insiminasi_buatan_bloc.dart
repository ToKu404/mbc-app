import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/insiminasi_buatan_model.dart';
import 'package:mbc_mobile/repositories/insiminasi_buatan_repo.dart';

part 'insiminasi_buatan_event.dart';
part 'insiminasi_buatan_state.dart';

class InsiminasiBuatanBloc
    extends Bloc<InsiminasiBuatanEvent, InsiminasiBuatanState> {
  final InsiminasiBuatanRepository repository;

  InsiminasiBuatanBloc(this.repository) : super(InsiminasiBuatanInitialState());

  @override
  Stream<InsiminasiBuatanState> mapEventToState(
      InsiminasiBuatanEvent event) async* {
    if (event is InsiminasiBuatanFetchDataEvent) {
      try {
        yield InsiminasiBuatanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.insiminasiBuatanFetchData(event.userId);
        yield InsiminasiBuatanLoadedState(data.insiminasiBuatan);
      } catch (e) {
        yield InsiminasiBuatanErrorState(e.toString());
      }
    } else if (event is InsiminasiBuatanStoreEvent) {
      try {
        yield InsiminasiBuatanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.insiminasiBuatanStore(
            event.file, event.insiminasiBuatan, event.notifId);
        if (data.responsecode == "1") {
          yield InsiminasiBuatanSuccessState(data.responsemsg);
        } else {
          yield InsiminasiBuatanErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is InsiminasiBuatanUpdateEvent) {
      try {
        yield InsiminasiBuatanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data =
            await repository.insiminasiBuatanUpdate(event.insiminasiBuatan);
        if (data.responsecode == "1") {
          yield InsiminasiBuatanSuccessState(data.responsemsg);
        } else {
          yield InsiminasiBuatanErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is InsiminasiBuatanDeleteEvent) {
      try {
        yield InsiminasiBuatanLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data =
            await repository.insiminasiBuatanDelete(event.insiminasiBuatan);
        if (data.responsecode == "1") {
          yield InsiminasiBuatanSuccessState(data.responsemsg);
        } else {
          yield InsiminasiBuatanErrorState(data.responsemsg);
        }
      } catch (e) {}
    }
  }
}
