import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products_crud/feature/product/presentation/controller/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/product_form_dialog.dart';

import 'product_details_page.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  void openCreateDialog() {
    Get.dialog(const ProductFormDialog());
  }

  void openEditDialog(product) {
    Get.dialog(
      //problem : is this method default in getx
      ProductFormDialog(),
    );
  }

  Future<void> openDetails(String id) async {
    final product = await controller.fetchProductById(id);
    if (product == null) return;

    Get.to(() => ProductDetailsPage(product: product));
  }

  void confirmDelete(String id) {
    Get.defaultDialog(
      //problem : is this method default in getx
      title: 'Delete Product',

      middleText: 'Are you sure you want to delete this product?',

      textCancel: 'Cancel',

      textConfirm: 'Delete',

      confirmTextColor: Colors.white,

      onConfirm: () {
        Get.back();

        controller.removeProduct(id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),

        actions: [
          IconButton(
            onPressed: () {
              controller.fetchProducts(refresh: true);
            },

            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openCreateDialog,

        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty && controller.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(controller.errorMessage.value),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    controller.fetchProducts(refresh: true);
                  },

                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text('No products available'));
        }



        return RefreshIndicator(
          onRefresh: () {
            return controller.fetchProducts(refresh: true);
          },

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextField(
                  controller: controller.searchController,

                  onChanged: (value) {
                    controller.searchProducts(value);
                  },

                  decoration: InputDecoration(
                    labelText: "Search a Product",
                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.searchController.clear();
                        controller.searchProducts('');
                      },
                      icon: const Icon(Icons.clear),
                    ),

                    border: const OutlineInputBorder(),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),

                  itemCount:
                      controller.filteredProducts.length +
                      (controller.hasMore && controller.searchQuery.isEmpty
                          ? 1
                          : 0),

                  itemBuilder: (context, index) {
                    if (index == controller.filteredProducts.length &&
                        controller.searchQuery.isEmpty) {
                      if (!controller.hasMore) {
                        // problem : don't understand hasMore concept
                        return const SizedBox(height: 80);
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),

                        child: Center(
                          child: ElevatedButton(
                            onPressed: controller.isLoadingMore.value
                                ? null
                                : controller.loadMoreProducts,

                            child: controller.isLoadingMore.value
                                ? const CircularProgressIndicator()
                                : const Text('Load More'),
                          ),
                        ),
                      );
                    }

                    final product = controller.filteredProducts[index];

                    return ProductCard(
                      product: product,

                      onDetails: () {
                        openDetails(product.id);
                      },

                      onEdit: () {
                        openEditDialog(product);
                      },

                      onDelete: () {
                        confirmDelete(product.id);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
