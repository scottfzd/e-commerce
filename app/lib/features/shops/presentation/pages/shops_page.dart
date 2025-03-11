import 'package:app/features/auth/auth_service_locator.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/presentation/blocs/shops_cubit.dart';
import 'package:app/features/shops/presentation/blocs/shops_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  final ScrollController _scrollController = ScrollController();
  String? _shopIdSelected;

  @override
  void initState() {
    super.initState();
    getShopIdSelected();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  Future<void> getShopIdSelected() async {
    try {
      final shopIdSelected =
          await sl<FlutterSecureStorage>().read(key: 'shopId');
      setState(() {
        _shopIdSelected = shopIdSelected;
      });
    } catch (e) {
      // Gérer l'erreur, par exemple en affichant un message à l'utilisateur
      print('Erreur lors de la récupération de l\'ID du magasin : $e');
    }
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels ||
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ShopsCubit>().loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShopsCubit, ShopsState>(
        builder: (context, state) {
          List<ShopEntity> shops = [];

          if (state is ShopsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShopsLoaded) {
            shops = state.shops;
          } else if (state is ShopsLoadingMore) {
            shops = state.shops;
          } else if (state is ShopsError) {
            return Center(child: Text(state.message));
          } else if (state is ShopSelected) {
            shops = state.shops;
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: shops.length + 1,
            itemBuilder: (context, index) {
              if (index == shops.length) {
                return state is ShopsLoadingMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }
              final shop = shops[index];
              return ListTile(
                title: Text(shop.id.toString()),
                subtitle: Text(shop.name!),
                selected: shop.id.toString() == _shopIdSelected,
                onTap: () {
                  sl<FlutterSecureStorage>()
                      .write(key: 'shopId', value: shop.id.toString());
                  setState(() {
                    _shopIdSelected = shop.id.toString();
                  });
                  context.read<ShopsCubit>().selectShop(shop);
                },
              );
            },
          );
        },
      ),
    );
  }
}
