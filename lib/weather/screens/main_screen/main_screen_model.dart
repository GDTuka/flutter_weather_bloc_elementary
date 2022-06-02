import 'package:elementary/elementary.dart';
import 'package:elementary_bloc_weather/data/api/repository.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/bloc.dart';
import 'package:elementary_bloc_weather/weather/screens/main_screen/bloc/states.dart';

class MainScreenModel extends ElementaryModel {
  final ApiRepository apiRepository;
  final MainBloc mainBloc;

  Stream<MainStates> get mainStateStream => mainBloc.stream;
  MainStates get currentState => mainBloc.state;
  MainScreenModel(
    this.apiRepository,
    this.mainBloc,
  );
}
