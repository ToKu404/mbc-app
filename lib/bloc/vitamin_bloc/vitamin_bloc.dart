import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/vitamin_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_master_repo.dart';

part 'vitamin_event.dart';
part 'vitamin_state.dart';

class VitaminBloc extends Bloc<VitaminEvent, VitaminState> {
  final PerlakuanMasterRepository repository;
  VitaminBloc(this.repository) : super(VitaminInitialState());

  @override
  Stream<VitaminState> mapEventToState(VitaminEvent event) async* {
    if (event is VitaminFetchDataEvent) {
      try {
        yield VitaminLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.vitaminFetchData();
        yield VitaminLoadedState(model: data);
      } catch (e) {
        yield VitaminErrorState(errorMsg: e.toString());
      }
    }
  }
}
