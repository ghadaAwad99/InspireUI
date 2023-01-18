part of '../coupon_card.dart';

abstract class CouponTranslate {
  CouponTranslate(this.context);
  BuildContext context;
  String get expired;
  String get useNow;
  String get saveForLater;
  String get discount;
  String get fixedCartDiscount;
  String get fixedProductDiscount;
  String get langCode;
  String expiringInTime(dynamic time);
  String validUntilDate(dynamic data);
}

class CouponItem extends StatelessWidget {
  final Coupon coupon;
  final Function(String couponCode)? onSelect;
  final String? email;
  final bool isFromCart;
  final CouponTranslate translate;
  final String Function(double coupon) getCurrencyFormatted;

  static const double _iconSize = 65.0;
  static const double _iconPadding = 24.0;

  static const _couponClipper = CouponClipper(
    borderRadius: 5.0,
    smallClipRadius: 4.0,
    numberOfSmallClips: 8,
  );

  const CouponItem({
    Key? key,
    required this.translate,
    required this.coupon,
    required this.getCurrencyFormatted,
    this.onSelect,
    this.email,
    this.isFromCart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = _getCouponCount(coupon, email);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final content = Container(
      color: isDarkTheme
          ? Theme.of(context).cardColor
          : Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _iconPadding),
            child: CouponIcon(
              coupon: coupon,
              size: _iconSize,
              getCurrencyFormatted: getCurrencyFormatted,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Container(
                      decoration: count.isNotEmpty
                          ? BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(9.0),
                                bottomRight: Radius.circular(9.0),
                              ),
                            )
                          : null,
                      margin: const EdgeInsets.only(right: 18.0),
                      padding: const EdgeInsets.only(
                        top: 6.0,
                        left: 8.0,
                        bottom: 6.0,
                        right: 8.0,
                      ),
                      child: Text(
                        count,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _getCouponTitle(context, coupon),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 16),
                  child: Text(
                    _getCouponDescription(context, coupon),
                    style: const TextStyle(
                      fontSize: 10.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    ..._getCouponExpireDateWidget(context, coupon),
                    if (coupon.isExpired)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          translate.expired,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    else
                      TextButton(
                        onPressed: () {
                          if (onSelect != null) {
                            onSelect!(coupon.code ?? '');
                          }
                        },
                        child: Text(
                          isFromCart
                              ? translate.useNow
                              : translate.saveForLater,
                        ),
                      ),
                    const SizedBox(width: 8.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return LayoutBuilder(builder: (context, constraint) {
      return Stack(
        children: [
          if (count.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(top: 4.0),
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              child: CustomPaint(
                painter: CouponPainter(
                  shadow: const Shadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 2.0,
                  ),
                  clipper: _couponClipper,
                ),
                child: ClipPath(
                  clipper: _couponClipper,
                  child: content,
                ),
              ),
            ),
          Container(
            padding:
                count.isNotEmpty ? const EdgeInsets.only(bottom: 4.0) : null,
            child: CustomPaint(
              painter: CouponPainter(
                shadow: Shadow(
                  color: Colors.black12,
                  offset: Offset(0, count.isNotEmpty ? 4 : 2),
                  blurRadius: count.isNotEmpty ? 4.0 : 2.0,
                ),
                clipper: _couponClipper,
              ),
              child: ClipPath(
                clipper: _couponClipper,
                child: content,
              ),
            ),
          ),
        ],
      );
    });
  }

  String _getCouponCount(Coupon coupon, String? email) {
    int? usageLimit;
    int? usageCount;

    if (email != null &&
        email.isNotEmpty &&
        coupon.usageLimitPerUser != null &&
        coupon.usedBy != null) {
      final usedByUser = List.castFrom(coupon.usedBy!)
        ..retainWhere((item) => item == email);
      usageLimit = coupon.usageLimitPerUser;
      usageCount = usedByUser.length;
    } else {
      usageLimit = coupon.usageLimit;
      usageCount = coupon.usageCount;
    }

    if (usageLimit != null &&
        usageCount != null &&
        (usageLimit - usageCount > 1)) {
      return 'x${usageLimit - usageCount}';
    }
    return '';
  }

  String _getCouponDescription(BuildContext context, Coupon coupon) {
    if (coupon.description != null &&
        coupon.description.toString().isNotEmpty) {
      return coupon.description.toString();
    }
    return '';
  }

  List<Widget> _getCouponExpireDateWidget(BuildContext context, Coupon coupon) {
    final locale = translate.langCode;
    final now = DateTime.now();
    final expiringSoon = coupon.dateExpires != null &&
        !coupon.dateExpires!.isAfter(now.add(const Duration(days: 3))) &&
        !coupon.isExpired;

    var title = '';

    if (coupon.dateExpires != null) {
      title = translate
          .validUntilDate(DateFormat('yyyy-MM-dd').format(coupon.dateExpires!));
    }

    if (expiringSoon) {
      final timeDif = now.difference(coupon.dateExpires!);
      title = translate.expiringInTime(
        timeago.format(
          now.subtract(timeDif),
          locale: locale,
          allowFromNow: true,
        ),
      );
    }

    return [
      if (expiringSoon)
        const Padding(
          padding: EdgeInsets.only(right: 2.0),
          child: Icon(
            Icons.access_time_sharp,
            color: Colors.red,
            size: 11,
          ),
        ),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            color:
                (expiringSoon || coupon.isExpired) ? Colors.red : Colors.grey,
            fontSize: 11,
            fontWeight: expiringSoon ? FontWeight.bold : FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  String _getCouponTitle(BuildContext context, Coupon coupon) {
    return '${_getCouponAmount(context, coupon, getCurrencyFormatted)} '
        '${_getCouponTypeTitle(context, coupon, translate)}';
  }
}

class CouponIcon extends StatelessWidget {
  final Coupon? coupon;
  final double? size;
  final CouponTranslate? translate;
  final String Function(double coupon) getCurrencyFormatted;

  const CouponIcon({
    Key? key,
    required this.getCurrencyFormatted,
    this.coupon,
    this.size,
    this.translate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size! * 1.1,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _getCouponTypeTitle(context, coupon!, translate)
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7,
                      letterSpacing: 1.1,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _getCouponAmount(context, coupon!, getCurrencyFormatted),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2, top: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      coupon!.code.toString().toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 7,
                        letterSpacing: 0.7,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _getCouponTypeTitle(
    BuildContext context, Coupon coupon, CouponTranslate? trans) {
  if (coupon.isPercentageDiscount) {
    return trans?.discount ?? 'Discount';
  }
  if (coupon.isFixedCartDiscount) {
    return trans?.fixedCartDiscount ?? 'Fixed Cart Discount';
  }
  if (coupon.isFixedProductDiscount) {
    return trans?.fixedProductDiscount ?? 'Fixed Product Discount';
  }
  return coupon.code.toString().toUpperCase();
}

String _getCouponAmount(
    BuildContext context, Coupon coupon, getCurrencyFormatted) {
  if (coupon.isPercentageDiscount) {
    return '${coupon.amount}%';
  }
  if (coupon.isFixedCartDiscount || coupon.isFixedProductDiscount) {
    return '${getCurrencyFormatted(coupon.amount)}';
  }
  return '${coupon.amount}'.toUpperCase();
}

class CouponPainter extends CustomPainter {
  final Shadow? shadow;
  final CustomClipper<Path>? clipper;

  CouponPainter({this.shadow, this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = shadow!.toPaint();
    final clipPath = clipper!.getClip(size).shift(shadow!.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CouponClipper extends CustomClipper<Path> {
  final double? borderRadius;
  final double? smallClipRadius;
  final int? numberOfSmallClips;

  const CouponClipper({
    this.borderRadius,
    this.smallClipRadius,
    this.numberOfSmallClips,
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      // draw rect
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius!),
      ));

    // draw small clip circles
    final clipContainerSize = size.height - smallClipRadius!;
    final smallClipSize = smallClipRadius! * 2;
    final smallClipBoxSize = clipContainerSize / numberOfSmallClips!;
    final smallClipPadding = (smallClipBoxSize - smallClipSize) / 2;
    final smallClipStart = smallClipRadius! / 2;

    final clipPath = Path();

    List.generate(numberOfSmallClips!, (index) {
      final boxX = smallClipStart + smallClipBoxSize * index;
      final centerX = boxX + smallClipPadding + smallClipRadius!;

      return Offset(0, centerX);
      // ignore: avoid_function_literals_in_foreach_calls
    }).forEach((centerOffset) {
      clipPath.addOval(Rect.fromCircle(
        center: centerOffset,
        radius: smallClipRadius!,
      ));
    });

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(CouponClipper oldClipper) => true;
}
