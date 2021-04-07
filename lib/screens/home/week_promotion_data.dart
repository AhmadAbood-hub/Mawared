import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';

class WeekPromotionData extends ChangeNotifier {
  bool showLoading = true;
  WeekPromotion weekPromotion;

  WeekPromotionData(String discountGuide) {
    getData(discountGuide);
  }

  void getData(String guide) async {
    /*NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientDiscounts/GetProductsUnderDiscount?discountguid=${guide}');*/
    NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientDiscounts/GetProductsUnderDiscount?discountguid=${guide}');

    var weekPromotionJson = await networkHelper.getData();

    if (weekPromotionJson != null) {
      setData(weekPromotionJson);
    } else {
      print('error');
    }
  }

  void setData(var weekPromotionJson) {
    /*var usersJson = jsonDecode(users) as List;
    List<User> usersList = usersJson.map((e) => User.fromJson(e)).toList();
    for (User user in usersList) {
      print(user.address.city);
    }
    print(usersList.length);*/

    ///single value
    WeekPromotion testData =
        WeekPromotion.fromJson(jsonDecode(weekPromotionJson));
    weekPromotion = testData;
    showLoading = false;
    notifyListeners();
  }
}

class WeekPromotion {
  int id;
  String discountGuid;
  String name;
  String couponCode;
  Null adminComment;
  int discountTypeId;
  bool usePercentage;
  String discountPercentage;
  Null discountAmount;
  Null maximumDiscountAmount;
  String startDate;
  String endDate;
  bool requiresCouponCode;
  bool isCumulative;
  int discountLimitationId;
  bool limitationTimes;
  Null maximumDiscountedQuantity;
  bool appliedToSubCategories;
  String discountImgurl;
  bool discountavalibe;
  bool discountshowonhomescreeen;
  Null discountTypename;
  Null startdateS;
  Null enddateS;
  List<Discountproducts> discountproducts;

  WeekPromotion(
      {this.id,
      this.discountGuid,
      this.name,
      this.couponCode,
      this.adminComment,
      this.discountTypeId,
      this.usePercentage,
      this.discountPercentage,
      this.discountAmount,
      this.maximumDiscountAmount,
      this.startDate,
      this.endDate,
      this.requiresCouponCode,
      this.isCumulative,
      this.discountLimitationId,
      this.limitationTimes,
      this.maximumDiscountedQuantity,
      this.appliedToSubCategories,
      this.discountImgurl,
      this.discountavalibe,
      this.discountshowonhomescreeen,
      this.discountTypename,
      this.startdateS,
      this.enddateS,
      this.discountproducts});

  WeekPromotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountGuid = json['DiscountGuid'];
    name = json['Name'];
    couponCode = json['CouponCode'];
    adminComment = json['AdminComment'];
    discountTypeId = json['DiscountTypeId'];
    usePercentage = json['UsePercentage'];
    discountPercentage = json['DiscountPercentage'];
    discountAmount = json['DiscountAmount'];
    maximumDiscountAmount = json['MaximumDiscountAmount'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    requiresCouponCode = json['RequiresCouponCode'];
    isCumulative = json['IsCumulative'];
    discountLimitationId = json['DiscountLimitationId'];
    limitationTimes = json['LimitationTimes'];
    maximumDiscountedQuantity = json['MaximumDiscountedQuantity'];
    appliedToSubCategories = json['AppliedToSubCategories'];
    discountImgurl = json['DiscountImgurl'];
    discountavalibe = json['Discountavalibe'];
    discountshowonhomescreeen = json['Discountshowonhomescreeen'];
    discountTypename = json['DiscountTypename'];
    startdateS = json['StartdateS'];
    enddateS = json['EnddateS'];
    if (json['discountproducts'] != null) {
      discountproducts = new List<Discountproducts>();
      json['discountproducts'].forEach((v) {
        discountproducts.add(new Discountproducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DiscountGuid'] = this.discountGuid;
    data['Name'] = this.name;
    data['CouponCode'] = this.couponCode;
    data['AdminComment'] = this.adminComment;
    data['DiscountTypeId'] = this.discountTypeId;
    data['UsePercentage'] = this.usePercentage;
    data['DiscountPercentage'] = this.discountPercentage;
    data['DiscountAmount'] = this.discountAmount;
    data['MaximumDiscountAmount'] = this.maximumDiscountAmount;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['RequiresCouponCode'] = this.requiresCouponCode;
    data['IsCumulative'] = this.isCumulative;
    data['DiscountLimitationId'] = this.discountLimitationId;
    data['LimitationTimes'] = this.limitationTimes;
    data['MaximumDiscountedQuantity'] = this.maximumDiscountedQuantity;
    data['AppliedToSubCategories'] = this.appliedToSubCategories;
    data['DiscountImgurl'] = this.discountImgurl;
    data['Discountavalibe'] = this.discountavalibe;
    data['Discountshowonhomescreeen'] = this.discountshowonhomescreeen;
    data['DiscountTypename'] = this.discountTypename;
    data['StartdateS'] = this.startdateS;
    data['EnddateS'] = this.enddateS;
    if (this.discountproducts != null) {
      data['discountproducts'] =
          this.discountproducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Discountproducts {
  int id;
  String porductGuid;
  String name;
  Null metaKeywords;
  Null metaTitle;
  Null sku;
  Null displayOrder;
  bool published;
  bool deleted;
  Null createdOn;
  Null updatedOnUtc;
  bool hasTierPrices;
  bool hasDiscountsApplied;
  Null weight;
  Null length;
  Null width;
  Null height;
  bool markAsNew;
  Null markAsNewStartDateTimeUtc;
  Null markAsNewEndDateTimeUtc;
  double allowedQuantities;
  int productTypeId;
  bool visibleIndividually;
  String shortDescription;
  Null fullDescription;
  Null adminComment;
  Null productTemplateId;
  bool showOnHomepage;
  Null metaDescription;
  bool allowCustomerReviews;
  Null approvedRatingSum;
  Null notApprovedRatingSum;
  Null approvedTotalReviews;
  Null notApprovedTotalReviews;
  bool hasUserAgreement;
  Null userAgreementText;
  bool isRental;
  bool requireOtherProducts;
  bool automaticallyAddRequiredProducts;
  bool notReturnable;
  bool disableBuyButton;
  bool disableWishlistButton;
  bool availableForPreOrder;
  Null preOrderAvailabilityStartDateTime;
  bool callForPrice;
  bool linkPictureBycolor;
  String price;
  String oldPrice;
  Null foreignPrice;
  Null productCost;
  bool customerEntersPrice;
  Null minimumCustomerEnteredPrice;
  Null maximumCustomerEnteredPrice;
  Null basepriceEnabled;
  Null basepriceAmount;
  Null basepriceUnitId;
  Null basepriceBaseAmount;
  Null basepriceBaseUnitId;
  Null stockQuantity;
  bool displayStockAvailability;
  bool displayStockQuantity;
  Null minStockQuantity;
  Null lowStockActivityId;
  bool notifyAdminForQuantityBelow;
  int backorderModeId;
  bool allowBackInStockSubscriptions;
  Null orderMinimumQuantity;
  Null orderMaximumQuantity;
  bool isShipEnabled;
  bool isFreeShipping;
  bool shipSeparately;
  Null additionalShippingCharge;
  String warehouseGuid;
  Null isTelecommunicationsOrBroadcastingOrElectronicServices;
  String vendorGuid;
  bool isFeatureProduct;
  String featureProductDisplayorder;
  String porductTemplateGuid;
  String productImg;
  String productImgcolor;
  String categories;
  String manfucters;
  String tags;
  double discounts;
  Null relatedProducts;
  Null crossProducts;

  Discountproducts(
      {this.id,
      this.porductGuid,
      this.name,
      this.metaKeywords,
      this.metaTitle,
      this.sku,
      this.displayOrder,
      this.published,
      this.deleted,
      this.createdOn,
      this.updatedOnUtc,
      this.hasTierPrices,
      this.hasDiscountsApplied,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.markAsNew,
      this.markAsNewStartDateTimeUtc,
      this.markAsNewEndDateTimeUtc,
      this.allowedQuantities,
      this.productTypeId,
      this.visibleIndividually,
      this.shortDescription,
      this.fullDescription,
      this.adminComment,
      this.productTemplateId,
      this.showOnHomepage,
      this.metaDescription,
      this.allowCustomerReviews,
      this.approvedRatingSum,
      this.notApprovedRatingSum,
      this.approvedTotalReviews,
      this.notApprovedTotalReviews,
      this.hasUserAgreement,
      this.userAgreementText,
      this.isRental,
      this.requireOtherProducts,
      this.automaticallyAddRequiredProducts,
      this.notReturnable,
      this.disableBuyButton,
      this.disableWishlistButton,
      this.availableForPreOrder,
      this.preOrderAvailabilityStartDateTime,
      this.callForPrice,
      this.linkPictureBycolor,
      this.price,
      this.oldPrice,
      this.foreignPrice,
      this.productCost,
      this.customerEntersPrice,
      this.minimumCustomerEnteredPrice,
      this.maximumCustomerEnteredPrice,
      this.basepriceEnabled,
      this.basepriceAmount,
      this.basepriceUnitId,
      this.basepriceBaseAmount,
      this.basepriceBaseUnitId,
      this.stockQuantity,
      this.displayStockAvailability,
      this.displayStockQuantity,
      this.minStockQuantity,
      this.lowStockActivityId,
      this.notifyAdminForQuantityBelow,
      this.backorderModeId,
      this.allowBackInStockSubscriptions,
      this.orderMinimumQuantity,
      this.orderMaximumQuantity,
      this.isShipEnabled,
      this.isFreeShipping,
      this.shipSeparately,
      this.additionalShippingCharge,
      this.warehouseGuid,
      this.isTelecommunicationsOrBroadcastingOrElectronicServices,
      this.vendorGuid,
      this.isFeatureProduct,
      this.featureProductDisplayorder,
      this.porductTemplateGuid,
      this.productImg,
      this.productImgcolor,
      this.categories,
      this.manfucters,
      this.tags,
      this.discounts,
      this.relatedProducts,
      this.crossProducts});

  Discountproducts.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    porductGuid = json['PorductGuid'];
    name = json['Name'];
    metaKeywords = json['MetaKeywords'];
    metaTitle = json['MetaTitle'];
    sku = json['Sku'];
    displayOrder = json['DisplayOrder'];
    published = json['Published'];
    deleted = json['Deleted'];
    createdOn = json['CreatedOn'];
    updatedOnUtc = json['UpdatedOnUtc'];
    hasTierPrices = json['HasTierPrices'];
    hasDiscountsApplied = json['HasDiscountsApplied'];
    weight = json['Weight'];
    length = json['Length'];
    width = json['Width'];
    height = json['Height'];
    markAsNew = json['MarkAsNew'];
    markAsNewStartDateTimeUtc = json['MarkAsNewStartDateTimeUtc'];
    markAsNewEndDateTimeUtc = json['MarkAsNewEndDateTimeUtc'];
    allowedQuantities = json['AllowedQuantities'];
    productTypeId = json['ProductTypeId'];
    visibleIndividually = json['VisibleIndividually'];
    shortDescription = json['ShortDescription'];
    fullDescription = json['FullDescription'];
    adminComment = json['AdminComment'];
    productTemplateId = json['ProductTemplateId'];
    showOnHomepage = json['ShowOnHomepage'];
    metaDescription = json['MetaDescription'];
    allowCustomerReviews = json['AllowCustomerReviews'];
    approvedRatingSum = json['ApprovedRatingSum'];
    notApprovedRatingSum = json['NotApprovedRatingSum'];
    approvedTotalReviews = json['ApprovedTotalReviews'];
    notApprovedTotalReviews = json['NotApprovedTotalReviews'];
    hasUserAgreement = json['HasUserAgreement'];
    userAgreementText = json['UserAgreementText'];
    isRental = json['IsRental'];
    requireOtherProducts = json['RequireOtherProducts'];
    automaticallyAddRequiredProducts = json['AutomaticallyAddRequiredProducts'];
    notReturnable = json['NotReturnable'];
    disableBuyButton = json['DisableBuyButton'];
    disableWishlistButton = json['DisableWishlistButton'];
    availableForPreOrder = json['AvailableForPreOrder'];
    preOrderAvailabilityStartDateTime =
        json['PreOrderAvailabilityStartDateTime'];
    callForPrice = json['CallForPrice'];
    linkPictureBycolor = json['LinkPictureBycolor'];
    price = json['Price'];
    oldPrice = json['OldPrice'];
    foreignPrice = json['ForeignPrice'];
    productCost = json['ProductCost'];
    customerEntersPrice = json['CustomerEntersPrice'];
    minimumCustomerEnteredPrice = json['MinimumCustomerEnteredPrice'];
    maximumCustomerEnteredPrice = json['MaximumCustomerEnteredPrice'];
    basepriceEnabled = json['BasepriceEnabled'];
    basepriceAmount = json['BasepriceAmount'];
    basepriceUnitId = json['BasepriceUnitId'];
    basepriceBaseAmount = json['BasepriceBaseAmount'];
    basepriceBaseUnitId = json['BasepriceBaseUnitId'];
    stockQuantity = json['StockQuantity'];
    displayStockAvailability = json['DisplayStockAvailability'];
    displayStockQuantity = json['DisplayStockQuantity'];
    minStockQuantity = json['MinStockQuantity'];
    lowStockActivityId = json['LowStockActivityId'];
    notifyAdminForQuantityBelow = json['NotifyAdminForQuantityBelow'];
    backorderModeId = json['BackorderModeId'];
    allowBackInStockSubscriptions = json['AllowBackInStockSubscriptions'];
    orderMinimumQuantity = json['OrderMinimumQuantity'];
    orderMaximumQuantity = json['OrderMaximumQuantity'];
    isShipEnabled = json['IsShipEnabled'];
    isFreeShipping = json['IsFreeShipping'];
    shipSeparately = json['ShipSeparately'];
    additionalShippingCharge = json['AdditionalShippingCharge'];
    warehouseGuid = json['WarehouseGuid'];
    isTelecommunicationsOrBroadcastingOrElectronicServices =
        json['IsTelecommunicationsOrBroadcastingOrElectronicServices'];
    vendorGuid = json['VendorGuid'];
    isFeatureProduct = json['isFeatureProduct'];
    featureProductDisplayorder = json['FeatureProductDisplayorder'];
    porductTemplateGuid = json['PorductTemplateGuid'];
    productImg = json['ProductImg'];
    productImgcolor = json['ProductImgcolor'];
    categories = json['categories'];
    manfucters = json['manfucters'];
    tags = json['tags'];
    discounts = json['discounts'];
    relatedProducts = json['relatedProducts'];
    crossProducts = json['crossProducts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['PorductGuid'] = this.porductGuid;
    data['Name'] = this.name;
    data['MetaKeywords'] = this.metaKeywords;
    data['MetaTitle'] = this.metaTitle;
    data['Sku'] = this.sku;
    data['DisplayOrder'] = this.displayOrder;
    data['Published'] = this.published;
    data['Deleted'] = this.deleted;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedOnUtc'] = this.updatedOnUtc;
    data['HasTierPrices'] = this.hasTierPrices;
    data['HasDiscountsApplied'] = this.hasDiscountsApplied;
    data['Weight'] = this.weight;
    data['Length'] = this.length;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['MarkAsNew'] = this.markAsNew;
    data['MarkAsNewStartDateTimeUtc'] = this.markAsNewStartDateTimeUtc;
    data['MarkAsNewEndDateTimeUtc'] = this.markAsNewEndDateTimeUtc;
    data['AllowedQuantities'] = this.allowedQuantities;
    data['ProductTypeId'] = this.productTypeId;
    data['VisibleIndividually'] = this.visibleIndividually;
    data['ShortDescription'] = this.shortDescription;
    data['FullDescription'] = this.fullDescription;
    data['AdminComment'] = this.adminComment;
    data['ProductTemplateId'] = this.productTemplateId;
    data['ShowOnHomepage'] = this.showOnHomepage;
    data['MetaDescription'] = this.metaDescription;
    data['AllowCustomerReviews'] = this.allowCustomerReviews;
    data['ApprovedRatingSum'] = this.approvedRatingSum;
    data['NotApprovedRatingSum'] = this.notApprovedRatingSum;
    data['ApprovedTotalReviews'] = this.approvedTotalReviews;
    data['NotApprovedTotalReviews'] = this.notApprovedTotalReviews;
    data['HasUserAgreement'] = this.hasUserAgreement;
    data['UserAgreementText'] = this.userAgreementText;
    data['IsRental'] = this.isRental;
    data['RequireOtherProducts'] = this.requireOtherProducts;
    data['AutomaticallyAddRequiredProducts'] =
        this.automaticallyAddRequiredProducts;
    data['NotReturnable'] = this.notReturnable;
    data['DisableBuyButton'] = this.disableBuyButton;
    data['DisableWishlistButton'] = this.disableWishlistButton;
    data['AvailableForPreOrder'] = this.availableForPreOrder;
    data['PreOrderAvailabilityStartDateTime'] =
        this.preOrderAvailabilityStartDateTime;
    data['CallForPrice'] = this.callForPrice;
    data['LinkPictureBycolor'] = this.linkPictureBycolor;
    data['Price'] = this.price;
    data['OldPrice'] = this.oldPrice;
    data['ForeignPrice'] = this.foreignPrice;
    data['ProductCost'] = this.productCost;
    data['CustomerEntersPrice'] = this.customerEntersPrice;
    data['MinimumCustomerEnteredPrice'] = this.minimumCustomerEnteredPrice;
    data['MaximumCustomerEnteredPrice'] = this.maximumCustomerEnteredPrice;
    data['BasepriceEnabled'] = this.basepriceEnabled;
    data['BasepriceAmount'] = this.basepriceAmount;
    data['BasepriceUnitId'] = this.basepriceUnitId;
    data['BasepriceBaseAmount'] = this.basepriceBaseAmount;
    data['BasepriceBaseUnitId'] = this.basepriceBaseUnitId;
    data['StockQuantity'] = this.stockQuantity;
    data['DisplayStockAvailability'] = this.displayStockAvailability;
    data['DisplayStockQuantity'] = this.displayStockQuantity;
    data['MinStockQuantity'] = this.minStockQuantity;
    data['LowStockActivityId'] = this.lowStockActivityId;
    data['NotifyAdminForQuantityBelow'] = this.notifyAdminForQuantityBelow;
    data['BackorderModeId'] = this.backorderModeId;
    data['AllowBackInStockSubscriptions'] = this.allowBackInStockSubscriptions;
    data['OrderMinimumQuantity'] = this.orderMinimumQuantity;
    data['OrderMaximumQuantity'] = this.orderMaximumQuantity;
    data['IsShipEnabled'] = this.isShipEnabled;
    data['IsFreeShipping'] = this.isFreeShipping;
    data['ShipSeparately'] = this.shipSeparately;
    data['AdditionalShippingCharge'] = this.additionalShippingCharge;
    data['WarehouseGuid'] = this.warehouseGuid;
    data['IsTelecommunicationsOrBroadcastingOrElectronicServices'] =
        this.isTelecommunicationsOrBroadcastingOrElectronicServices;
    data['VendorGuid'] = this.vendorGuid;
    data['isFeatureProduct'] = this.isFeatureProduct;
    data['FeatureProductDisplayorder'] = this.featureProductDisplayorder;
    data['PorductTemplateGuid'] = this.porductTemplateGuid;
    data['ProductImg'] = this.productImg;
    data['ProductImgcolor'] = this.productImgcolor;
    data['categories'] = this.categories;
    data['manfucters'] = this.manfucters;
    data['tags'] = this.tags;
    data['discounts'] = this.discounts;
    data['relatedProducts'] = this.relatedProducts;
    data['crossProducts'] = this.crossProducts;
    return data;
  }
}
