
import 'package:products_crud/feature/product/domain/entities/product.dart';
import 'package:products_crud/feature/product/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository ;

  GetProductById(this.repository);

  Future<Product> call(String id){
    return repository.getProductById(id);
  }
}






// import '../entities/product.dart';
// import '../repositories/product_repository.dart';

// class GetProductById {
//   final ProductRepository repository;

//   GetProductById(this.repository);

//   Future<Product> call(String id) {
//     return repository.getProductById(id);
//   }
// }
