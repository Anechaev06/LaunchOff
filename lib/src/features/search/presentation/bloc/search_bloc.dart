import 'package:flutter_bloc/flutter_bloc.dart';
import '../../search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchEvent>(_onSearch);
  }

  void _onSearch(SearchEvent event, Emitter<SearchState> emit) async {}
}
