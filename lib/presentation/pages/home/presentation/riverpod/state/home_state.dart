
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/electronic_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/gloves_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/screwdrivers_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/tools_response.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({

    @Default(false) bool isLoading,
    @Default(false) bool isResponseError,
    @Default(false) bool isNotEmpty,
    @Default(false) bool isCollapse,
    @Default(false) bool isError,
    @Default(false) bool isProductLoading,
    @Default("") String selectedCategory,
    @Default("") String jwt,

    ProductsResponse? products,
    GlovesCategoryResponse? glovesCategory,
    ScrewdriversResponse? screwdriversCategory,
    ElectronicResponse? electronicCategory,
    ToolsResponse? toolsCategory,
    String? errorMessage,

  }) = _HomeState;
}
