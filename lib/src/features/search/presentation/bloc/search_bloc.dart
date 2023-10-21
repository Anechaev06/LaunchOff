import 'package:flutter_bloc/flutter_bloc.dart';
import '../../search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchEvent>(_onSearch);
  }

  void _onSearch(SearchEvent event, Emitter<SearchState> emit) async {
    if (event is SearchQuerySubmitted) {
      emit(SearchLoading());

      try {
        final results = await searchRepository.search(event.query);
        emit(SearchLoaded(results));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }
}
