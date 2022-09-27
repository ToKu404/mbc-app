import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbc_mobile/models/strow_model.dart';
import 'package:mbc_mobile/repositories/strow_repo.dart';

part 'strow_event.dart';
part 'strow_state.dart';

class StrowBloc extends Bloc<StrowEvent, StrowState> {
  final StrowRepository repository;

  StrowBloc(this.repository) : super(StrowInitialState());

  @override
  Stream<StrowState> mapEventToState(StrowEvent event) async* {
    if (event is StrowFetchDataEvent) {
      try {
        yield StrowLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.strowFetchData();
        yield StrowLoadedState(data.strow);
      } catch (e) {
          
      }
    }else if (event is StrowStoreEvent) {
      try {
        yield StrowLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.strowStore(event.strow);
        if (data.responsecode == "1") {
          yield StrowSuccessState(data.responsemsg, data.strow);
        } else {
          yield StrowErrorState(data.responsemsg, data.strow);
        }
      } catch (e) {
          
      }
    }else if (event is StrowUpdateEvent) {
      try {
        yield StrowLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.strowUpdate(event.strow);
        if (data.responsecode == "1") {
          yield StrowSuccessState(data.responsemsg, data.strow);
        } else {
          yield StrowErrorState(data.responsemsg, data.strow);
        }
      } catch (e) {
          
      }
    }else if (event is StrowDeleteEvent) {
      try {
        yield StrowLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.strowDelete(event.strow);
        if (data.responsecode == "1") {
          yield StrowSuccessState(data.responsemsg, data.strow);
        } else {
          yield StrowErrorState(data.responsemsg, data.strow);
        }
      } catch (e) {
      }
    }





  }
}