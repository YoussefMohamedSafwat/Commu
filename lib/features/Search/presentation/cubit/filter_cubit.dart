import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<SearchFilter> {
  FilterCubit() : super(SearchFilter.users);

  void applyFilter(SearchFilter filter) => emit(filter);
}
