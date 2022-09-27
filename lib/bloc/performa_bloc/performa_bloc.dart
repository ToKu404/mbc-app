import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/repositories/performa_repo.dart';

part 'performa_event.dart';
part 'performa_state.dart';

class PerformaBloc extends Bloc<PerformaEvent, PerformaState> {
  final PerformaRepository repository;

  PerformaBloc(this.repository) : super(PerformaInitialState());

  @override
  Stream<PerformaState> mapEventToState(PerformaEvent event) async* {
    if (event is PerformaFetchDataEvent) {
      try {
        yield PerformaLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.performaFetchData(event.id);
        yield PerformaLoadedState(data.performa);
      } catch (e) {
        yield PerformaErrorState(e.toString());
      }
    } else if (event is PerformaStoreEvent) {
      try {
        yield PerformaLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.performaStore(event.file, event.performa);
        if (data.responsecode == "1") {
          yield PerformaSuccessState(data.responsemsg);
        } else {
          yield PerformaErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is PerformaUpdateEvent) {
      try {
        yield PerformaLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.performaUpdate(event.performa);
        if (data.responsecode == "1") {
          yield PerformaSuccessState(data.responsemsg);
        } else {
          yield PerformaErrorState(data.responsemsg);
        }
      } catch (e) {}
    } else if (event is PerformaDeleteEvent) {
      try {
        yield PerformaLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.performaDelete(event.performa);
        if (data.responsecode == "1") {
          yield PerformaSuccessState(data.responsemsg);
        } else {
          yield PerformaErrorState(data.responsemsg);
        }
      } catch (e) {}
    }
  }
}
