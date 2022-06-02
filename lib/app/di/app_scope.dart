import 'package:elementary_bloc_weather/data/api/repository.dart';
import 'package:elementary_bloc_weather/navigation/services/coordinator.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/bloc.dart';

abstract class IAppScope {
  Coordinator get coordinator;
  ApiRepository get apiRepository;
  MainBloc get mainBloc;
}

class AppScope implements IAppScope {
  late final Coordinator _coordinator;
  late final ApiRepository _apiRepository;
  late final MainBloc _mainBloc;
  @override
  Coordinator get coordinator => _coordinator;

  @override
  ApiRepository get apiRepository => _apiRepository;

  @override
  MainBloc get mainBloc => _mainBloc;

  AppScope() {
    _coordinator = Coordinator();
    _apiRepository = ApiRepository();
    _mainBloc = MainBloc(apiRepository: _apiRepository);
  }
}
