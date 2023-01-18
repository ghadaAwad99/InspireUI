part of '../coupon_card.dart';

class Coupon {
  double? amount;
  String? code;
  String? message;
  String? id;
  String? discountType;
  DateTime? dateExpires;
  String? description;
  double? minimumAmount;
  double? maximumAmount;
  int? usageCount;
  bool? individualUse;
  late List<String> productIds;
  late List<String> excludedProductIds;
  int? usageLimit;
  int? usageLimitPerUser;
  bool? freeShipping;
  late List<String> productCategories;
  late List<String> excludedProductCategories;
  bool? excludeSaleItems;
  late List<String> emailRestrictions;
  List<String>? usedBy;

  /// Check whether the coupon is expired.
  /// If dateExpires is null, the coupon is never expired (return false).
  bool get isExpired => !(dateExpires?.isAfter(DateTime.now()) ?? true);

  bool get isFixedCartDiscount => discountType == 'fixed_cart';

  bool get isFixedProductDiscount => discountType == 'fixed_product';

  bool get isPercentageDiscount => discountType == 'percent';

  Coupon.fromJson(Map<String, dynamic> json) {
    try {
      amount = double.parse(json['amount'].toString());
      code = json['code'];
      id = json['id']?.toString();
      discountType = json['discount_type'];
      description = json['description'];
      minimumAmount = json['minimum_amount'] != null
          ? double.parse(json['minimum_amount'].toString())
          : 0.0;
      maximumAmount = json['maximum_amount'] != null
          ? double.parse(json['maximum_amount'].toString())
          : 0.0;
      dateExpires = json['date_expires'] != null
          ? DateTime.parse(json['date_expires'])
          : null;
      message = '';
      usageCount = json['usage_count'];
      individualUse = json['individual_use'] ?? false;
      usageLimit = json['usage_limit'];
      usageLimitPerUser = json['usage_limit_per_user'];
      freeShipping = json['free_shipping'] ?? false;
      excludeSaleItems = json['exclude_sale_items'] ?? false;

      if (json['product_ids'] != null) {
        productIds = [];
        json['product_ids'].forEach((e) {
          productIds.add(e.toString());
        });
      }

      if (json['excluded_product_ids'] != null) {
        excludedProductIds = [];
        json['excluded_product_ids'].forEach((e) {
          excludedProductIds.add(e.toString());
        });
      }

      if (json['product_categories'] != null) {
        productCategories = [];
        json['product_categories'].forEach((e) {
          productCategories.add(e.toString());
        });
      }

      if (json['excluded_product_categories'] != null) {
        excludedProductCategories = [];
        json['excluded_product_categories'].forEach((e) {
          excludedProductCategories.add(e.toString());
        });
      }

      if (json['email_restrictions'] != null) {
        emailRestrictions = [];
        json['email_restrictions'].forEach((e) {
          emailRestrictions.add(e.toString());
        });
      }

      if (json['used_by'] != null) {
        usedBy = [];
        json['used_by'].forEach((e) {
          usedBy!.add(e.toString());
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Coupon.fromOpencartJson(Map<String, dynamic> json) {
    try {
      amount = double.parse(json['discount'].toString());
      code = json['code'];
      id = json['coupon_id'];
      discountType = json['type'] == 'P' ? 'percent' : 'fixed_cart';
      description = json['name'];
      minimumAmount = 0.0;
      maximumAmount = 0.0;
      dateExpires = DateTime.parse(json['date_end']);
      message = '';
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Coupon.fromShopify(Map<String, dynamic> json) {
    final List? listCouponApply = json['edges'];
    var info = {};
    if (listCouponApply?.isNotEmpty ?? false) {
      info = listCouponApply![0]['node'] ?? {};
    }
    if (info['applicable'] == false) {
      info = {};
    }
    try {
      code = info['code'];
      id = info['code'];
      amount = 0;
      final infoCoupon = info['value'] ?? {};
      if (infoCoupon['__typename'] == 'MoneyV2') {
        discountType = CouponType.fixedAmount;
        amount = double.tryParse(infoCoupon['amount'] ?? '0');
      } else if (infoCoupon['__typename'] == 'PricingPercentageValue') {
        discountType = CouponType.percentage;
        amount = infoCoupon['percentage'];
      }
      description = '';
      minimumAmount = 0.0;
      maximumAmount = 0.0;
      dateExpires = null;
      message = 'Hello';
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Coupon.fromPresta(Map<String, dynamic> json) {
    try {
      code = json['code'];
      id = json['id'].toString();
      usageCount = int.parse(json['quantity'].toString());
      if (double.parse(json['reduction_percent']) > 0.0) {
        discountType = 'percent';
        amount = double.parse(json['reduction_percent']);
      } else {
        discountType = 'fixed_cart';
        amount = double.parse(json['reduction_amount']);
      }
      emailRestrictions = [];
      description = json['name'];
      minimumAmount = 0.0;
      maximumAmount = 0.0;
      dateExpires = DateTime.parse(json['date_to']);
      message = '';
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'code': code,
      'discount_type': discountType,
      // 'description': description,
      // 'minimum_amount': minimumAmount,
      // 'maximum_amount': maximumAmount,
      // 'date_expires': dateExpires,
    };
  }
}

class CouponType {
  static String percentage = 'percent';
  static String fixedAmount = 'fixed_cart';
  static String freeShipping = 'free_shipping';
}
