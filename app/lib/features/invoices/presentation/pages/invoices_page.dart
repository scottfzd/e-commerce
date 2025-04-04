import 'package:app/features/invoices/presentation/blocs/invoices_cubit.dart';
import 'package:app/features/invoices/presentation/blocs/invoices_state.dart';
import 'package:app/features/invoices/presentation/pages/invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:intl/intl.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels ||
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9) {
      context.read<InvoicesCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InvoicesCubit, InvoicesState>(
        builder: (context, state) {
          List<InvoiceEntity> invoices = [];

          if (state is InvoicesLoading) {
            return _buildLoadingIndicator();
          } else if (state is InvoicesLoaded) {
            invoices = state.invoices;
          } else if (state is InvoicesLoadingMore) {
            invoices = state.invoices;
          } else if (state is InvoicesError) {
            return Center(child: Text(state.message));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: invoices.length + 1,
            itemBuilder: (context, index) {
              if (index == invoices.length) {
                return state is InvoicesLoadingMore
                    ? _buildLoadingIndicator()
                    : const SizedBox.shrink();
              }
              final invoice = invoices[index];
              DateTime orderedDateFormat = DateTime.parse(invoice.orderedDate!);
              DateFormat dateFormat =
                  DateFormat("yyyy-MM-dd 'à' HH'h'mm", 'fr_FR');
              String formattedDate = dateFormat.format(orderedDateFormat);

              return ListTile(
                title: Text('Commande n°${invoice.id}'),
                subtitle: Text(
                    'Total: ${invoice.total} €\nEffectuée le $formattedDate'),
                trailing: invoice.orderStatus == 'ordered' &&
                        invoice.paymentStatus == 'paid'
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.close, color: Colors.red),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InvoicePage(invoice: invoice);
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
