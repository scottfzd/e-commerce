import 'package:app/features/carts/presentation/pages/cart_page.dart';
import 'package:app/features/invoices/presentation/blocs/invoices_cubit.dart';
import 'package:app/features/invoices/presentation/pages/invoices_page.dart';
import 'package:app/features/profile/presentation/pages/profile_page.dart';
import 'package:app/features/products/presentation/pages/products_page.dart';
import 'package:app/features/shops/presentation/blocs/shops_cubit.dart';
import 'package:app/features/shops/presentation/pages/shops_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/home/presentation/blocs/bottom_navigation_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [
    ProductsPage(),
    CartPage(),
    ShopsPage(),
    InvoicesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => ShopsCubit()..fetchShops(),
        ),
        BlocProvider(
          create: (context) => InvoicesCubit()..fetchInvoices(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.home),
        ),
        body: BlocBuilder<BottomNavigationBloc, int>(
          builder: (context, currentIndex) {
            return _pages[currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavigationBloc, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              unselectedItemColor: Theme.of(context).primaryColorLight,
              selectedItemColor: Theme.of(context).primaryColor,
              onTap: (index) {
                final event = BottomNavigationEvent.values[index];
                context.read<BottomNavigationBloc>().add(event);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_bag),
                  label: AppLocalizations.of(context)!.products,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart),
                  label: AppLocalizations.of(context)!.cart,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.store),
                  label: AppLocalizations.of(context)!.shops,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.receipt),
                  label: AppLocalizations.of(context)!.invoices,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
