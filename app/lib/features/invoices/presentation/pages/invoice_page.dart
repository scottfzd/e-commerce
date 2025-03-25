import 'package:app/features/cart_products/presentation/widgets/cart_product_card_widget.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/presentation/blocs/invoices_cubit.dart';
import 'package:app/features/invoices/presentation/blocs/invoices_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatefulWidget {
  final InvoiceEntity invoice;
  const InvoicePage({super.key, required this.invoice});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              InvoicesCubit()..fetchInvoiceCart(widget.invoice.id!),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Commande n°${widget.invoice.id}'),
        ),
        body: BlocBuilder<InvoicesCubit, InvoicesState>(
          builder: (context, state) {
            if (state is InvoiceDetailedLoading) {
              return _buildLoadingIndicator();
            } else if (state is InvoiceDetailedLoaded) {
              final invoice = state.invoice;
              final cart = invoice.cart;
              final cartProducts = cart!.products;
              DateTime orderedDateFormat = DateTime.parse(invoice.orderedDate!);
              DateFormat dateFormat =
                  DateFormat("yyyy-MM-dd 'à' HH'h'mm", 'fr_FR');
              String formattedDate = dateFormat.format(orderedDateFormat);

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.cart.toUpperCase()} (${cart.products?.length} ${AppLocalizations.of(context)!.products})',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total: ${invoice.total} €',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cartProducts != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          var product = cartProducts[index];
                          return CartProductCardWidget(
                              cartProduct: product, isModifiable: false);
                        },
                      ),
                    ),
                ],
              );
            } else if (state is InvoiceDetailedError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
