import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mbc_mobile/models/user_model.dart';
import 'package:mbc_mobile/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetchSingleData) {
      try {
        yield UserLoadingState();
        await Future.delayed(const Duration(milliseconds: 30));
        final data = await repository.userGetById(event.id);
        yield UserSingleLoadedState(user: data);
      } catch (e) {
        yield UserErrorState(errorMsg: e.toString());
      }
    }
  }
}
