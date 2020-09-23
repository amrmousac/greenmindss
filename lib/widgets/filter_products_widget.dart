import 'package:flutter/material.dart';
import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/providers/filter_product.dart';
import 'package:greenminds/widgets/product_card.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';

class FilterProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<ProductsFilterProvider>(context);
    bool check = (filterProvider.name == '' &&
        filterProvider.address == '' &&
        filterProvider.ownerName == '' &&
        filterProvider.description == '');
    print(
        'name = ${filterProvider.name} address = ${filterProvider.address} owner name = ${filterProvider.ownerName} description = ${filterProvider.description}');
    return check
        ? Container()
        : Container(
            child: PaginationView<ProductModel>(
              paginationViewType: PaginationViewType.gridView,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7),
              bottomLoader: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              initialLoader: Center(
                child: CircularProgressIndicator(),
              ),
              onError: (dynamic error) => Center(
                child: Center(child: Text('Some error occured ')),
              ),
              onEmpty: Center(
                child: Text('No Data'),
              ),
              pageFetch: filterProvider.productsFilterList,
              itemBuilder:
                  (BuildContext context, ProductModel product, int index) {
                return ProductCard(product: product);
              },
            ),
          );
  }
}
