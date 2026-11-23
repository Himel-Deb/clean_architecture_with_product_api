import 'package:products_crud/feature/product/domain/entities/product.dart';
import 'package:products_crud/feature/product/domain/entities/product_request.dart';
import 'package:products_crud/feature/product/domain/repositories/product_repository.dart';

class CreateProduct {
  final  ProductRepository repository ;

  CreateProduct(this.repository);

  Future<Product> call(ProductRequest request){
    return repository.createProduct(request);
  }

}