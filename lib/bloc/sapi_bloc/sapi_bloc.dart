import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/performa_model.dart';
import 'package:mbc_mobile/models/sapi_model.dart';
import 'package:mbc_mobile/repositories/sapi_repo.dart';

part 'sapi_event.dart';
part 'sapi_state.dart';

class SapiBloc extends Bloc<SapiEvent, SapiState> {
  final SapiRepository repository;

  SapiBloc(this.repository) : super(SapiInitialState());

  @override
  Stream<SapiState> mapEventToState(SapiEvent event) async* {
    if (event is SapiFetchDataEvent) {
      try {
        yield SapiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.sapiFetchData(event.userId);
        yield SapiLoadedState(data.sapi);
      } catch (e) {
        yield SapiErrorState(e.toString());
      }
    } else if (event is SapiStoreEvent) {
      try {
        yield SapiLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.sapiStore(
            event.fotoDepan,
            event.fotoSamping,
            event.fotoPeternak,
            event.fotoRumah,
            event.sapi,
            event.fotoPerforma,
            event.performa);

        if (data.responsecode == "1") {
          yield SapiSuccessState(data.responsemsg);
        } else {
          yield SapiErrorState(data.responsemsg);
        }
      } catch (e) {
        yield SapiErrorState(e.toString());
      }
    }
  }
}
