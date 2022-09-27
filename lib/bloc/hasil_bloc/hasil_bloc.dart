import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/hasil_model.dart';
import 'package:mbc_mobile/repositories/hasil_repo.dart';

part 'hasil_event.dart';
part 'hasil_state.dart';

class HasilBloc extends Bloc<HasilEvent, HasilState> {
  HasilRepository metodeRepository;
  HasilBloc(this.metodeRepository) : super(HasilInitialState());

  @override
  Stream<HasilState> mapEventToState(HasilEvent event) async* {
    if (event is HasilFetchDataEvent) {}
    try {
      yield HasilLoadingState();
      await Future.delayed(const Duration(milliseconds: 30));
      final data = await metodeRepository.hasilFetchData();
      yield HasilLoadedState(data);
    } catch (e) {
      yield HasilErrorState(e.toString());
    }
  }
}
