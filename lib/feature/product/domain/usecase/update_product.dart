import 'package:products_crud/feature/product/domain/entities/product.dart';
import 'package:products_crud/feature/product/domain/entities/product_request.dart';
import 'package:products_crud/feature/product/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository ;

  UpdateProduct(this.repository);

  Future<Product>call (String id, ProductRequest request){
    return repository.updateProduct(id, request);
  }
  
}