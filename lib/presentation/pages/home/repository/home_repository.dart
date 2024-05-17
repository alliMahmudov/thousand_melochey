import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/electronic_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/gloves_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/screwdrivers_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/tools_response.dart';

abstract class HomeRepository{
  Future<ApiResult<ProductsResponse>> getProducts({required String? jwtToken});


/*  Future<ApiResult<ProductsResponse>> getProductsByCategory(
      {required String? category});*/

  Future<ApiResult<GlovesCategoryResponse>> getGlovesCategory();
  Future<ApiResult<ScrewdriversResponse>> getScrewdriversCategory();
  Future<ApiResult<ElectronicResponse>> getElectronicsCategory();
  Future<ApiResult<ToolsResponse>> getToolsCategory();



}