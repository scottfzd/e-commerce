import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/presentation/blocs/products_cubit.dart';
import 'package:app/features/products/presentation/blocs/products_state.dart';
import 'package:app/features/products/presentation/widgets/product_card_widget.dart';
import 'package:app/features/products/presentation/widgets/product_dialog.dart';
import 'package:app/features/products/presentation/widgets/scanner_widget.dart';
import 'package:app/shared/widgets/no_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit()..fetchProducts(),
        ),
      ],
      child: Scaffold(
        body: BlocListener<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ProductLoaded) {
              showDialog(
                context: context,
                builder: (context) => ProductDialog(product: state.product),
              );
            }
          },
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              List<ProductEntity> products = [];
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductsLoaded ||
                  state is ProductsLoadingMore) {
                products = state is ProductsLoaded
                    ? state.products
                    : (state as ProductsLoadingMore).products;

                return products.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCardWidget(product: product);
                        },
                      )
                    : NoContentWidget(
                        message:
                            AppLocalizations.of(context)!.no_products_found);
              } else if (state is ProductsError) {
                return Center(child: Text(state.message));
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: const ScannerWidget(),
      ),
    );
  }
}
