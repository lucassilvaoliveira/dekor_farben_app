import 'package:dekor_farben_app/global/constants.dart';
import 'package:flutter/material.dart';

class PointsMarkupWidget extends StatelessWidget {
  const PointsMarkupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 377,
      height: 37,
      child: Stack(
        children: [
          const Positioned(
            left: 26,
            top: 23,
            child: Text(
              '100',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 73,
            top: 23,
            child: Text(
              '200',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 123,
            top: 23,
            child: Text(
              '300',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 170,
            top: 23,
            child: Text(
              '400',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 220,
            top: 23,
            child: Text(
              '500',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 268,
            top: 23,
            child: Text(
              '600',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Positioned(
            left: 324,
            top: 23,
            child: Text(
              '700',
              style: TextStyle(
                color: kDefaultSubtitleColor,
                fontSize: 12,
                fontFamily: 'Chivo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: Container(
              width: 377,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFF838383),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 29,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 76,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 126,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 173,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 223,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(colors: kDefaultPrimaryGradient),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 271,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 327,
            top: 0,
            child: Container(
              width: 17,
              height: 16,
              decoration: const ShapeDecoration(
                color: Color(0xFFEFEFEF),
                shape: OvalBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF838383)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
