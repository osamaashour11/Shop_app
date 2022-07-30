import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/search_model/search_model.dart';
import 'package:flutter_shop_app/modules/home_screens/search/search_cubit/states.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/constants/end_points.dart';
import 'package:flutter_shop_app/shared/network/remote/dio/dio_helper.dart';

class SearchShopAppCubit extends Cubit<SearchShopAppStates> {
  SearchShopAppCubit() : super(InitializeSearchShopAppState());

  static SearchShopAppCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchData(String text) {
    emit(LoadingSearchShopAppState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchShopAppState());
    }).catchError((error) {
      emit(ErrorSearchShopAppState(error));
    });
  }
}
