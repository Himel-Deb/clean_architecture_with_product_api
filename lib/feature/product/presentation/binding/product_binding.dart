import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:products_crud/feature/product/data/data_sources/product_remote_data_source.dart';
import 'package:products_crud/feature/product/domain/usecase/create_product.dart';
import 'package:products_crud/feature/product/domain/usecase/delete_product.dart';
import 'package:products_crud/feature/product/domain/usecase/get_product.dart';
import 'package:products_crud/feature/product/domain/usecase/get_product_by_id.dart';
import 'package:products_crud/feature/product/domain/usecase/update_product.dart';
import 'package:products_crud/feature/product/presentation/controller/product_controller.dart';
import 'package:products_crud/feature/product/presentation/controller/product_form_controller.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/repositories/product_repository_impl.dart';

import '../../domain/repositories/product_repository.dart';



class ProductBinding extends Bindings {
  @override
  void dependencies() {

    // Dio

    Get.lazyPut<Dio>(
      () => DioClient().dio,
    );

    // Data Source

    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSource(
        Get.find<Dio>(),
      ),
    );

    // Repository

    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        Get.find<ProductRemoteDataSource>(),
      ),
    );

    // Use Cases

    Get.lazyPut<GetProducts>(
      () => GetProducts(
        Get.find<ProductRepository>(),
      ),
    );

    Get.lazyPut<GetProductById>(
      () => GetProductById(
        Get.find<ProductRepository>(),
      ),
    );

    Get.lazyPut<CreateProduct>(
      () => CreateProduct(
        Get.find<ProductRepository>(),
      ),
    );

    Get.lazyPut<UpdateProduct>(
      () => UpdateProduct(
        Get.find<ProductRepository>(),
      ),
    );

    Get.lazyPut<DeleteProduct>(
      () => DeleteProduct(
        Get.find<ProductRepository>(),
      ),
    );

    // Controller

    Get.lazyPut<ProductController>(
      () => ProductController(
        getProducts: Get.find<GetProducts>(),
        getProductById: Get.find<GetProductById>(),
        createProduct: Get.find<CreateProduct>(),
        updateProduct: Get.find<UpdateProduct>(),
        deleteProduct: Get.find<DeleteProduct>(),
      ),
    );

    Get.lazyPut<ProductFormController>(
      () => ProductFormController(
        createProduct: Get.find<CreateProduct>(),
        updateProduct: Get.find<UpdateProduct>(),

      ),
    );

  }
}
