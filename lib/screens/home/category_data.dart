import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';

class CategoryDetailsData extends ChangeNotifier {
  CategoryDetails categoryDetails;
  bool showLoading = true;

  CategoryDetailsData(String guide) {
    getData(guide);
  }

  void getData(String guide) async {
    NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientCategories/GetCategoryShowcase?categoryguid=${guide}');

    var categoyJson = await networkHelper.getData();

    if (categoyJson != null) {
      setData(categoyJson);
    } else {
      print('error');
    }
  }

  void setData(var categryDataJson) {
    /*var usersJson = jsonDecode(users) as List;
    List<User> usersList = usersJson.map((e) => User.fromJson(e)).toList();
    for (User user in usersList) {
      print(user.address.city);
    }
    print(usersList.length);*/

    ///single value
    CategoryDetails testData =
        CategoryDetails.fromJson(jsonDecode(categryDataJson));
    categoryDetails = testData;
    showLoading = false;
    print(showLoading);
    notifyListeners();
  }
}

class CategoryDetails {
  Category category;
  List<CategoryBrochures> categoryBrochures;
  List<Subcategories> subcategories;

  CategoryDetails({this.category, this.categoryBrochures, this.subcategories});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['categoryBrochures'] != null) {
      categoryBrochures = new List<CategoryBrochures>();
      json['categoryBrochures'].forEach((v) {
        categoryBrochures.add(new CategoryBrochures.fromJson(v));
      });
    }
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.categoryBrochures != null) {
      data['categoryBrochures'] =
          this.categoryBrochures.map((v) => v.toJson()).toList();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String categoryGuid;
  String name;
  bool categoryAvalible;
  String parentCategory;
  String catImgUrl;
  Null parentcategoryentity;
  List<Products> products;

  Category(
      {this.id,
      this.categoryGuid,
      this.name,
      this.categoryAvalible,
      this.parentCategory,
      this.catImgUrl,
      this.parentcategoryentity,
      this.products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGuid = json['CategoryGuid'];
    name = json['Name'];
    categoryAvalible = json['CategoryAvalible'];
    parentCategory = json['ParentCategory'];
    catImgUrl = json['CatImgUrl'];
    parentcategoryentity = json['parentcategoryentity'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryGuid'] = this.categoryGuid;
    data['Name'] = this.name;
    data['CategoryAvalible'] = this.categoryAvalible;
    data['ParentCategory'] = this.parentCategory;
    data['CatImgUrl'] = this.catImgUrl;
    data['parentcategoryentity'] = this.parentcategoryentity;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
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
  String foreignPrice;
  String productCost;
  bool customerEntersPrice;
  String minimumCustomerEnteredPrice;
  String maximumCustomerEnteredPrice;
  String basepriceEnabled;
  String basepriceAmount;
  String basepriceUnitId;
  String basepriceBaseAmount;
  String basepriceBaseUnitId;
  String stockQuantity;
  bool displayStockAvailability;
  bool displayStockQuantity;
  String minStockQuantity;
  String lowStockActivityId;
  bool notifyAdminForQuantityBelow;
  int backorderModeId;
  bool allowBackInStockSubscriptions;
  String orderMinimumQuantity;
  String orderMaximumQuantity;
  bool isShipEnabled;
  bool isFreeShipping;
  bool shipSeparately;
  Null additionalShippingCharge;
  String warehouseGuid;
  String isTelecommunicationsOrBroadcastingOrElectronicServices;
  String vendorGuid;
  bool isFeatureProduct;
  String featureProductDisplayorder;
  String porductTemplateGuid;
  String productImg;
  String productImgcolor;
  String categories;
  String manfucters;
  String tags;
  String discounts;
  String relatedProducts;
  String crossProducts;

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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

class CategoryBrochures {
  int id;
  String categoryBrochureGuid;
  String categoryGuid;
  Null url;
  String imageUrl;
  Null catname;

  CategoryBrochures(
      {this.id,
      this.categoryBrochureGuid,
      this.categoryGuid,
      this.url,
      this.imageUrl,
      this.catname});

  CategoryBrochures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryBrochureGuid = json['CategoryBrochureGuid'];
    categoryGuid = json['CategoryGuid'];
    url = json['url'];
    imageUrl = json['imageUrl'];
    catname = json['catname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryBrochureGuid'] = this.categoryBrochureGuid;
    data['CategoryGuid'] = this.categoryGuid;
    data['url'] = this.url;
    data['imageUrl'] = this.imageUrl;
    data['catname'] = this.catname;
    return data;
  }
}

class Subcategories {
  int id;
  String categoryGuid;
  String name;
  bool categoryAvalible;
  String parentCategory;
  String catImgUrl;
  Null parentcategoryentity;
  List<Products> products;

  Subcategories(
      {this.id,
      this.categoryGuid,
      this.name,
      this.categoryAvalible,
      this.parentCategory,
      this.catImgUrl,
      this.parentcategoryentity,
      this.products});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGuid = json['CategoryGuid'];
    name = json['Name'];
    categoryAvalible = json['CategoryAvalible'];
    parentCategory = json['ParentCategory'];
    catImgUrl = json['CatImgUrl'];
    parentcategoryentity = json['parentcategoryentity'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryGuid'] = this.categoryGuid;
    data['Name'] = this.name;
    data['CategoryAvalible'] = this.categoryAvalible;
    data['ParentCategory'] = this.parentCategory;
    data['CatImgUrl'] = this.catImgUrl;
    data['parentcategoryentity'] = this.parentcategoryentity;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
