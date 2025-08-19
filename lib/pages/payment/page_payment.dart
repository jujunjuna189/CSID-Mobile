import 'package:csid_mobile/helpers/formatter/formatter_date.dart';
import 'package:csid_mobile/helpers/formatter/formatter_price.dart';
import 'package:csid_mobile/pages/payment/bloc/bloc_payment.dart';
import 'package:csid_mobile/pages/payment/state/state_payment.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:csid_mobile/widgets/atoms/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagePayment extends StatelessWidget {
  const PagePayment({super.key});

  @override
  Widget build(BuildContext context) {
    BlocPayment blocPayment = context.read<BlocPayment>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [ThemeApp.color.light, ThemeApp.color.primary, ThemeApp.color.secondary, ThemeApp.color.dark],
              center: const Alignment(0, 1),
              radius: 1.2,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Thank You",
                  style: ThemeApp.font.bold.copyWith(color: ThemeApp.color.white, fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  "For Your Order",
                  style: ThemeApp.font.regular.copyWith(color: ThemeApp.color.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ThemeApp.color.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID Transaksi",
                          style: ThemeApp.font.regular,
                        ),
                        Expanded(
                          child: BlocBuilder<BlocPayment, StatePayment>(
                            bloc: blocPayment,
                            builder: (context, state) {
                              final currentState = state as PaymentLoaded;
                              return Text(
                                currentState.invoice?.merchantRef ?? "",
                                textAlign: TextAlign.end,
                                style: ThemeApp.font.semiBold,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nama Pelanggan",
                          style: ThemeApp.font.regular,
                        ),
                        Expanded(
                          child: BlocBuilder<BlocPayment, StatePayment>(
                            bloc: blocPayment,
                            builder: (context, state) {
                              final currentState = state as PaymentLoaded;
                              return Text(
                                currentState.auth?.displayName ?? "",
                                textAlign: TextAlign.end,
                                style: ThemeApp.font.semiBold,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ThemeApp.color.white.withOpacity(0.1),
                        border: Border.all(width: 1, color: ThemeApp.color.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("No Virtual Account"),
                                    BlocBuilder<BlocPayment, StatePayment>(
                                      bloc: blocPayment,
                                      builder: (context, state) {
                                        final currentState = state as PaymentLoaded;
                                        return Text(
                                          currentState.invoice?.payCode ?? "",
                                          style: ThemeApp.font.bold,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              BlocBuilder<BlocPayment, StatePayment>(
                                bloc: blocPayment,
                                builder: (context, state) {
                                  final currentState = state as PaymentLoaded;
                                  return SizedBox(
                                    width: 50,
                                    child: Image.network(
                                      currentState.methodIcon ?? "",
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.payment);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Total Pembayaran"),
                          BlocBuilder<BlocPayment, StatePayment>(
                            bloc: blocPayment,
                            builder: (context, state) {
                              final currentState = state as PaymentLoaded;
                              return Text(
                                "Rp ${FormatterPrice.instance.formatCurrency((currentState.invoice?.amount ?? 0))}",
                                style: ThemeApp.font.bold.copyWith(fontSize: 16),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: ThemeApp.color.white.withOpacity(0.1),
                  border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selesaikan pembayaran sebelum",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: ThemeApp.font.light.copyWith(
                        fontSize: 14,
                        color: ThemeApp.color.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 1,
                      ),
                    ),
                    BlocBuilder<BlocPayment, StatePayment>(
                      bloc: blocPayment,
                      builder: (context, state) {
                        final currentState = state as PaymentLoaded;
                        return Text(
                          FormatterDate.instance.formatV1(currentState.invoice?.expiredTime ?? 0),
                          style: ThemeApp.font.bold.copyWith(fontSize: 16, color: ThemeApp.color.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: ThemeApp.color.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instruksi Pembayaran",
                      style: ThemeApp.font.semiBold.copyWith(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<BlocPayment, StatePayment>(
                      bloc: blocPayment,
                      builder: (context, state) {
                        final currentState = state as PaymentLoaded;
                        final initialExpanded = (currentState.invoice?.instructions ?? []).length == 1 ? true : false;
                        return Column(
                          children: (currentState.invoice?.instructions ?? []).asMap().entries.map((item) {
                            return Column(
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    visualDensity: const VisualDensity(vertical: -4),
                                    dividerColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    childrenPadding: EdgeInsets.zero,
                                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                    expandedAlignment: Alignment.centerLeft,
                                    initiallyExpanded: initialExpanded,
                                    title: Text(
                                      item.value.title,
                                      style: ThemeApp.font.medium,
                                    ),
                                    children: (item.value.steps).asMap().entries.map((child) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${child.key + 1}. ',
                                            style: ThemeApp.font.bold,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              child.value.replaceAll(RegExp(r'<[^>]*>'), ''),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                                (currentState.invoice?.instructions ?? []).length == 1 ? Container() : const Divider(),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onPress: () => Navigator.pushNamedAndRemoveUntil(context, RouteName.MAIN, (route) => false),
                      colors: const [
                        Color.fromRGBO(238, 73, 69, 1),
                        Color.fromRGBO(255, 219, 141, 1),
                      ],
                      isBorder: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          "Continue to Home",
                          textAlign: TextAlign.center,
                          style: ThemeApp.font.semiBold.copyWith(color: ThemeApp.color.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
