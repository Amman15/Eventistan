import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventistan/flutter_flow/flutter_flow_theme.dart';
import 'package:eventistan/providers/future_providers.dart';
import 'package:eventistan/providers/payment_repo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PurchasesScreen extends ConsumerWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          kToolbarHeight,
        ),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          centerTitle: true,
          title: Text(
            'Purchased Tickets',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                ),
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final user = ref.watch(userProvider);

          return user.when(
            data: (data) {
              final tickets = ref.watch(ticketsProvider(data.id!));

              return tickets.when(
                data: (data) {
                  return SafeArea(
                    child: ListView.separated(
                      itemCount: data.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      itemBuilder: (_, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: CachedNetworkImage(
                                imageUrl: data[index].event.eventLogo!,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${data[index].id}',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ticket Status: ${data[index].status}',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ticket Price: ${data[index].event.price} PKR',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ticket Quantity: ${data[index].quantity}',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FilledButton(
                                  onPressed: data[index].status == 'active' &&
                                          data[index].paymentIntentId != null
                                      ? () async {
                                          final paymentRepository = ref
                                              .read(paymentRepositoryProvider);
                                          await paymentRepository.refundTicket(
                                              ticketId: data[index].id);
                                          ref.invalidate(ticketsProvider);
                                        }
                                      : null,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Refund Ticket',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const Divider(
                          height: 30,
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
