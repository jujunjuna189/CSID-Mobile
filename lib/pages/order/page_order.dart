import 'dart:convert';

import 'package:csid_mobile/helpers/formatter/formatter_date.dart';
import 'package:csid_mobile/helpers/formatter/formatter_price.dart';
import 'package:csid_mobile/pages/order/state/state_order.dart';
import 'package:csid_mobile/routes/route_name.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/order/bloc/bloc_order.dart';
import 'package:flutter/material.dart';

class PageOrder extends StatelessWidget {
  const PageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    BlocOrder blocOrder = context.read<BlocOrder>();

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
                  "Check Out",
                  style: ThemeApp.font.bold.copyWith(color: ThemeApp.color.white, fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  "Select a payment method",
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
                          "Tanggal",
                          style: ThemeApp.font.regular,
                        ),
                        Expanded(
                          child: Text(
                            FormatterDate.instance.formatNow(),
                            textAlign: TextAlign.end,
                            style: ThemeApp.font.semiBold,
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
                          child: BlocBuilder<BlocOrder, StateOrder>(
                            bloc: blocOrder,
                            builder: (context, state) {
                              final currentState = state as OrderLoaded;
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
                      height: 10,
                    ),
                    Text(
                      "Detail Kelas",
                      style: ThemeApp.font.semiBold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: ThemeApp.color.primary.withOpacity(0.1),
                        border: Border.all(width: 1, color: ThemeApp.color.primary.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<BlocOrder, StateOrder>(
                            bloc: blocOrder,
                            builder: (context, state) {
                              final currentState = state as OrderLoaded;
                              return Text(
                                currentState.course?.title ?? "",
                              );
                            },
                          ),
                          BlocBuilder<BlocOrder, StateOrder>(
                            bloc: blocOrder,
                            builder: (context, state) {
                              final currentState = state as OrderLoaded;
                              return Text(
                                "Rp ${FormatterPrice.instance.formatCurrency((currentState.course?.salePrice ?? 0))}",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pilih Metode Pembayaran",
                    style: ThemeApp.font.bold.copyWith(fontSize: 14, color: ThemeApp.color.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<BlocOrder, StateOrder>(
                bloc: blocOrder,
                builder: (context, state) {
                  final currentState = state as OrderLoaded;
                  return Column(
                    children: (currentState.paymentChannels ?? []).asMap().entries.map((item) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          RouteName.PAYMENT,
                          arguments: jsonEncode(
                            {
                              'course_id': currentState.course?.id,
                              'method': item.value.code,
                              'method_icon': item.value.iconUrl,
                            },
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: ThemeApp.color.white,
                            border: Border.all(width: 1, color: ThemeApp.color.white.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Image.network(
                                  item.value.iconUrl ?? '',
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.payment);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.value.name ?? '',
                                  textAlign: TextAlign.end,
                                  style: ThemeApp.font.medium,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: ThemeApp.color.primary.withOpacity(0.2),
                                  border: Border.all(width: 1, color: ThemeApp.color.primary.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
