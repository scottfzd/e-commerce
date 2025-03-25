import 'dart:async';

import 'package:app/features/auth/auth_service_locator.dart';
import 'package:app/features/payment/presentation/blocs/payment_cubit.dart';
import 'package:app/features/payment/presentation/blocs/payment_state.dart';
import 'package:app/shared/widgets/webview_widget.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _listenToDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _listenToDeepLinks() {
    final appLinks = sl<AppLinks>();
    _linkSubscription = appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null && mounted) {
        if (uri.path == '/success') {
          String token = uri.queryParameters['token'] ?? '';
          //String payerId = uri.queryParameters['PayerID'] ?? '';
          context.read<PaymentCubit>().pay(token);
        } else if (uri.path == '/cancel') {
          context.read<PaymentCubit>().cancel();
        } else {
          debugPrint('Unknown deeplink: $uri');
        }
      }
    }, onError: (err) {
      debugPrint('Deeplink Error: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentCubit()..getWebviewUrl(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paiement'),
        ),
        body: BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Succès'),
                    content: const Text('Le paiement a été effectué.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else if (state is PaymentCanceled) {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Annulation'),
                    content: const Text('Le paiement a été annulé.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else if (state is PaymentError) {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Erreur'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              if (state is PaymentUrlLoaded) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      WebviewWidget.launchURL(
                        context,
                        state.paypalWebviewResponse.url,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: const Text('Payer avec paypal'),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
