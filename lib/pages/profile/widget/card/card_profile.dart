import 'package:csid_mobile/pages/main/state/state_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csid_mobile/pages/main/bloc/bloc_main.dart';
import 'package:csid_mobile/utils/asset/asset.dart';
import 'package:csid_mobile/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({super.key});

  @override
  Widget build(BuildContext context) {
    BlocMain blocMain = context.read<BlocMain>();

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: CardClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                color: ThemeApp.color.dark,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(Asset.imgBanner3),
                ),
              ),
            ),
          ),

          // Avatar bulat di atas lekukan
          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      colors: [const Color.fromRGBO(87, 44, 220, 1), ThemeApp.color.light],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ThemeApp.color.dark,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: BlocBuilder<BlocMain, StateMain>(
                        bloc: blocMain,
                        builder: (context, state) {
                          final currentState = state as MainLoaded;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              currentState.auth?.avatar ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.account_circle, size: 50, color: Colors.grey);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Clipper untuk membuat lekukan setengah lingkaran di atas
class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double centerX = size.width / 2;

    final Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(centerX - 60, size.height);

    path.arcToPoint(
      Offset(centerX - 45, size.height - 15),
      radius: Radius.circular(20),
      clockwise: false,
    );

    path.arcToPoint(
      Offset(centerX + 45, size.height - 15),
      radius: Radius.circular(40),
      clockwise: true,
    );

    path.arcToPoint(
      Offset(centerX + 60, size.height),
      radius: Radius.circular(20),
      clockwise: false,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
