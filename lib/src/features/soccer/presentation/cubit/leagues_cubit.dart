import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/league.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/use_cases/leagues_usecase.dart';
import 'leagues_state.dart';

/// Represents the leagues cubit entity/model.
class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesUseCase leaguesUseCase;

  LeaguesCubit({required this.leaguesUseCase}) : super(LeaguesInitial());

  List<League> _availableLeagues = [];
  List<League> get availableLeagues => _availableLeagues;
  bool _isLoadingLeagues = false;

  Future<void> getLeagues({bool forceRefresh = false}) async {
    if (_isLoadingLeagues) return;

    if (!forceRefresh && _availableLeagues.isNotEmpty) {
      emit(LeaguesLoaded(_availableLeagues));
      return;
    }

    _isLoadingLeagues = true;
    try {
      if (forceRefresh) {
        _availableLeagues = [];
      }
      emit(LeaguesLoading());
      final leagues = await leaguesUseCase(NoParams());
      leagues.fold((left) => emit(LeaguesLoadFailure(left.message)), (right) {
        _availableLeagues = right;
        emit(LeaguesLoaded(_availableLeagues));
      });
    } finally {
      _isLoadingLeagues = false;
    }
  }
}
