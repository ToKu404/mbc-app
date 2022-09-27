import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/vaksin_model.dart';
import 'package:mbc_mobile/repositories/perlakuan_master_repo.dart';

part 'vaksin_event.dart';
part 'vaksin_state.dart';

class VaksinBloc extends Bloc<VaksinEvent, VaksinState> {
  final PerlakuanMasterRepository repository;

  VaksinBloc(this.repository) : super(VaksinInitialState());

  @override
  Stream<VaksinState> mapEventToState(VaksinEvent event) async* {
    if (event is VaksinFetchDataEvent) {
      try {
        yield VaksinLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.vaksinFetchData();
        yield VaksinLoadedState(model: data);
      } catch (e) {
        yield VaksinErrorState(errorMsg: e.toString());
      }
    }
  }
}
