import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/screens/account/MyOrders.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsData extends ChangeNotifier {
  ProductDetails productDetails;
  List<AttributeMap> attributeMap = [];
  bool showProductLoading = true;

  ProductDetailsData(String guide) {
    getData(guide);
  }
/*
  ProductDetailsData() {
    showProductLoading = false;
    productDetails = ProductDetails(
        id: 2,
        name: 'name',
        image:
            'https://pngimg.com/uploads/running_shoes/running_shoes_PNG5816.png',
        desc:
            "<html> <head> <title>Bold</title></head> <body> <!--Normal text--> <p>Hello GeeksforGeeks</p> <!--Text in Bold--> <p><b>Hello GeeksforGeeks</b></p> <!--Text in Strong--> <p><strong>Hello GeeksforGeeks</strong></p></body></html> ",
        backgroundColor: '#f72585',
        brand: 'brand',
        images: [
          'https://pngimg.com/uploads/running_shoes/running_shoes_PNG5816.png',
          'https://pngimg.com/uploads/running_shoes/running_shoes_PNG5816.png'
        ],
        price: 300,
        specifications: [
          Specification('المعالج', 'core i9'),
          Specification('المعالج', 'core i9'),
          Specification('المعالج', 'core i9'),
          Specification('المعالج', 'core i9'),
        ],
        attributes: [
          Attribute(
              5,
              'name',
              [
                AttributeValue(
                  'guide1',
                  'values',
                ),
                AttributeValue(
                  'guide2',
                  'values',
                ),
                AttributeValue(
                  'guide3',
                  'values',
                ),
                AttributeValue(
                  'guide4',
                  'values',
                ),
                AttributeValue(
                  'guide5',
                  'values',
                ),
                AttributeValue(
                  'guide6',
                  'values',
                ),
              ],
              1,
              '1'),
          Attribute(
              5,
              'name',
              [
                AttributeValue(
                  'guide1',
                  '#f72585',
                ),
                AttributeValue(
                  'guide2',
                  '#f72585',
                ),
                AttributeValue(
                  'guide3',
                  '#f72585',
                ),
                AttributeValue(
                  'guide4',
                  '#f72585',
                ),
                AttributeValue(
                  'guide5',
                  '#f72585',
                ),
                AttributeValue(
                  'guide6',
                  '#f72585',
                ),
              ],
              2,
              '2'),
          Attribute(
              5,
              'name',
              [
                AttributeValue(
                  'guide1',
                  '#f72585',
                ),
                AttributeValue(
                  'guide2',
                  '#f72585',
                ),
                AttributeValue(
                  'guide3',
                  '#f72585',
                ),
                AttributeValue(
                  'guide4',
                  '#f72585',
                ),
                AttributeValue(
                  'guide5',
                  '#f72585',
                ),
                AttributeValue(
                  'guide6',
                  '#f72585',
                )
              ],
              2,
              '3'),
        ],
        relatedProducts: [RelatedProduct()]);
  }*/

  void getData(String guide) async {
    print(guide);
    NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientProduct/GetProductDetail?productguid=$guide');
    /* NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientProduct/GetProductDetail?productguid=98280b9f-6d98-4c18-8bb7-85cf7b57d6ff');*/

    var brandDataJson = await networkHelper.getData();

    if (brandDataJson != null) {
      setData(brandDataJson);
    } else {
      print('error');
    }
  }

  void setData(var brandDataJson) {
    ///single value
    ProductDetails testData =
        ProductDetails.fromJson(jsonDecode(brandDataJson));
    productDetails = testData;

    /*  if (productDetails.productsattrbutes != null) {
      for (int i = 0; i < productDetails.productsattrbutes.length; i++) {
        attributeMap.add(AttributeMap(
            productDetails.productsattrbutes[i].attributeGuid,
            productDetails.productsattrbutes[i].avalibeoptions[0]
                .productttributeOptionGuid));
      }
    }*/

    showProductLoading = false;
    notifyListeners();
  }
}

class OrderBottomSheetData extends ChangeNotifier {
  List<AttributeMap> attributeMap = [];
  int orderCount;
  String productImage;

  OrderBottomSheetData(
      List<Productsattrbutes> productsattrbutes, String productImage) {
    orderCount = 1;
    this.productImage = productImage;
    if (productsattrbutes != null) {
      for (int i = 0; i < productsattrbutes.length; i++) {
        attributeMap.add(AttributeMap(
            productsattrbutes[i].attributeGuid,
            productsattrbutes[i].avalibeoptions[0].productttributeOptionGuid,
            productsattrbutes[i].avalibeoptions[0].name,
            productsattrbutes[i].avalibeoptions[0].attribueColor));
      }
    }
  }

  void subOrderCount() {
    if (orderCount > 1) {
      orderCount--;
      notifyListeners();
    }
  }

  void addOrderCount() {
    orderCount++;
    notifyListeners();
  }

  void setAttributeAtPosition(int position, String parentGuide,
      String childGuide, String value, String color) {
    attributeMap[position] =
        AttributeMap(parentGuide, childGuide, value, color);
    notifyListeners();
  }

  void addToCart(Product productDetails) {
    OrderDetails orderDetails =
        OrderDetails(productDetails, attributeMap, orderCount, productImage);
    storeLocal(orderDetails.toJson());
  }
}

void storeLocal(String data) async {
  String key = 'OrderList';
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List<String> orderList = preferences.getStringList(key);
  debugPrint(data);
  if (orderList == null) orderList = [];
  orderList.add(data);
  await preferences.setStringList(key, orderList);
}

class OrderDetails {
  Product product;
  List<AttributeMap> attributeMap;
  int orderCount;
  String image;

  OrderDetails(this.product, this.attributeMap, this.orderCount, this.image);

  OrderDetails.fromJson(Map<String, dynamic> json) {
    if (json['attributeMap'] != null) {
      attributeMap = new List<AttributeMap>();
      json['attributeMap'].forEach((v) {
        attributeMap.add(new AttributeMap.fromJson(v));
      });
    }
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    orderCount = json['orderCount'];
    image = json['image'];
  }

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributeMap != null) {
      data["attributeMap"] = this.attributeMap.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['orderCount'] = this.orderCount;
    data['image'] = this.image;

    return json.encode(data);
  }
}

class AttributeMap {
  String parentGuide;
  String childGuide;
  String value;
  String color;

  AttributeMap(this.parentGuide, this.childGuide, this.value, this.color);

  AttributeMap.fromJson(Map<String, dynamic> json) {
    parentGuide = json['parentGuide'];
    childGuide = json['childGuide'];
    value = json['value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentGuide'] = this.parentGuide;
    data['childGuide'] = this.childGuide;
    data['value'] = this.value;
    data['color'] = this.color;
    return data;
  }
}

class ProductDetails {
  Product product;
  List<Productimgs> productimgs;
  List<Productcategories> productcategories;
  List<Producttags> producttags;
  List<ProductManfuters> productManfuters;
  List<ProductDiscounts> productDiscounts;
  List<Crossproducts> crossproducts;
  List<Crossproducts> relatedproducts;
  List<Productspecification> productspecification;
  List<Productsattrbutes> productsattrbutes;

  ProductDetails(
      {this.product,
      this.productimgs,
      this.productcategories,
      this.producttags,
      this.productManfuters,
      this.productDiscounts,
      this.crossproducts,
      this.relatedproducts,
      this.productspecification,
      this.productsattrbutes});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['productimgs'] != null) {
      productimgs = new List<Productimgs>();
      json['productimgs'].forEach((v) {
        productimgs.add(new Productimgs.fromJson(v));
      });
    }
    if (json['productcategories'] != null) {
      productcategories = new List<Productcategories>();
      json['productcategories'].forEach((v) {
        productcategories.add(new Productcategories.fromJson(v));
      });
    }
    if (json['producttags'] != null) {
      producttags = new List<Producttags>();
      json['producttags'].forEach((v) {
        producttags.add(new Producttags.fromJson(v));
      });
    }
    if (json['productManfuters'] != null) {
      productManfuters = new List<ProductManfuters>();
      json['productManfuters'].forEach((v) {
        productManfuters.add(new ProductManfuters.fromJson(v));
      });
    }
    if (json['productDiscounts'] != null) {
      productDiscounts = new List<ProductDiscounts>();
      json['productDiscounts'].forEach((v) {
        productDiscounts.add(new ProductDiscounts.fromJson(v));
      });
    }
    if (json['Crossproducts'] != null) {
      crossproducts = new List<Crossproducts>();
      json['Crossproducts'].forEach((v) {
        crossproducts.add(new Crossproducts.fromJson(v));
      });
    }
    if (json['Relatedproducts'] != null) {
      relatedproducts = new List<Crossproducts>();
      json['Relatedproducts'].forEach((v) {
        relatedproducts.add(new Crossproducts.fromJson(v));
      });
    }
    if (json['productspecification'] != null) {
      productspecification = new List<Productspecification>();
      json['productspecification'].forEach((v) {
        productspecification.add(new Productspecification.fromJson(v));
      });
    }
    if (json['productsattrbutes'] != null) {
      productsattrbutes = new List<Productsattrbutes>();
      json['productsattrbutes'].forEach((v) {
        productsattrbutes.add(new Productsattrbutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.productimgs != null) {
      data['productimgs'] = this.productimgs.map((v) => v.toJson()).toList();
    }
    if (this.productcategories != null) {
      data['productcategories'] =
          this.productcategories.map((v) => v.toJson()).toList();
    }
    if (this.producttags != null) {
      data['producttags'] = this.producttags.map((v) => v.toJson()).toList();
    }
    if (this.productManfuters != null) {
      data['productManfuters'] =
          this.productManfuters.map((v) => v.toJson()).toList();
    }
    if (this.productDiscounts != null) {
      data['productDiscounts'] =
          this.productDiscounts.map((v) => v.toJson()).toList();
    }
    if (this.crossproducts != null) {
      data['Crossproducts'] =
          this.crossproducts.map((v) => v.toJson()).toList();
    }
    if (this.relatedproducts != null) {
      data['Relatedproducts'] =
          this.relatedproducts.map((v) => v.toJson()).toList();
    }
    if (this.productspecification != null) {
      data['productspecification'] =
          this.productspecification.map((v) => v.toJson()).toList();
    }
    if (this.productsattrbutes != null) {
      data['productsattrbutes'] =
          this.productsattrbutes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int id;
  String porductGuid;
  String name;
  String metaKeywords;
  String metaTitle;
  String sku;
  String displayOrder;
  bool published;
  bool deleted;
  String createdOn;
  String updatedOnUtc;
  bool hasTierPrices;
  bool hasDiscountsApplied;
  String weight;
  String length;
  String width;
  String height;
  bool markAsNew;
  String markAsNewStartDateTimeUtc;
  String markAsNewEndDateTimeUtc;
  double allowedQuantities;
  int productTypeId;
  bool visibleIndividually;
  String shortDescription;
  String fullDescription;
  String adminComment;
  String productTemplateId;
  bool showOnHomepage;
  String metaDescription;
  bool allowCustomerReviews;
  String approvedRatingSum;
  String notApprovedRatingSum;
  String approvedTotalReviews;
  String notApprovedTotalReviews;
  bool hasUserAgreement;
  String userAgreementText;
  bool isRental;
  bool requireOtherProducts;
  bool automaticallyAddRequiredProducts;
  bool notReturnable;
  bool disableBuyButton;
  bool disableWishlistButton;
  bool availableForPreOrder;
  String preOrderAvailabilityStartDateTime;
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
  String additionalShippingCharge;
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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

class Productimgs {
  int id;
  String productPictureGuid;
  String imageUrl;
  String imgFolder;
  String productColor;
  int displayOder;
  String title;
  String altText;
  String backgroundcolor;
  bool enableBackgroundcolor;
  String images;

  Productimgs(
      {this.id,
      this.productPictureGuid,
      this.imageUrl,
      this.imgFolder,
      this.productColor,
      this.displayOder,
      this.title,
      this.altText,
      this.backgroundcolor,
      this.enableBackgroundcolor,
      this.images});

  Productimgs.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    productPictureGuid = json['ProductPictureGuid'];
    imageUrl = json['imageUrl'];
    imgFolder = json['imgFolder'];
    productColor = json['productColor'];
    displayOder = json['displayOder'];
    title = json['Title'];
    altText = json['AltText'];
    backgroundcolor = json['Backgroundcolor'];
    enableBackgroundcolor = json['enableBackgroundcolor'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ProductPictureGuid'] = this.productPictureGuid;
    data['imageUrl'] = this.imageUrl;
    data['imgFolder'] = this.imgFolder;
    data['productColor'] = this.productColor;
    data['displayOder'] = this.displayOder;
    data['Title'] = this.title;
    data['AltText'] = this.altText;
    data['Backgroundcolor'] = this.backgroundcolor;
    data['enableBackgroundcolor'] = this.enableBackgroundcolor;
    data['images'] = this.images;
    return data;
  }
}

class Productcategories {
  int id;
  String categoryGuid;
  String name;
  bool categoryAvalible;
  String parentCategory;
  String catImgUrl;
  String parentcategoryentity;
  String products;

  Productcategories(
      {this.id,
      this.categoryGuid,
      this.name,
      this.categoryAvalible,
      this.parentCategory,
      this.catImgUrl,
      this.parentcategoryentity,
      this.products});

  Productcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGuid = json['CategoryGuid'];
    name = json['Name'];
    categoryAvalible = json['CategoryAvalible'];
    parentCategory = json['ParentCategory'];
    catImgUrl = json['CatImgUrl'];
    parentcategoryentity = json['parentcategoryentity'];
    products = json['products'];
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
    data['products'] = this.products;
    return data;
  }
}

class Producttags {
  int id;
  String tagGuid;
  String name;
  bool tagAvalible;

  Producttags({this.id, this.tagGuid, this.name, this.tagAvalible});

  Producttags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagGuid = json['TagGuid'];
    name = json['Name'];
    tagAvalible = json['TagAvalible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TagGuid'] = this.tagGuid;
    data['Name'] = this.name;
    data['TagAvalible'] = this.tagAvalible;
    return data;
  }
}

class ProductManfuters {
  int id;
  String manufacturerGuid;
  String name;
  String metaKeywords;
  String metaDescription;
  String metaTitle;
  String priceRanges;
  String description;
  String notes;
  String imageUrl;
  bool published;
  bool deleted;
  String createdAt;
  String updatedAt;
  bool manfucteravailbe;
  String categories;
  String products;

  ProductManfuters(
      {this.id,
      this.manufacturerGuid,
      this.name,
      this.metaKeywords,
      this.metaDescription,
      this.metaTitle,
      this.priceRanges,
      this.description,
      this.notes,
      this.imageUrl,
      this.published,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.manfucteravailbe,
      this.categories,
      this.products});

  ProductManfuters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturerGuid = json['manufacturerGuid'];
    name = json['Name'];
    metaKeywords = json['MetaKeywords'];
    metaDescription = json['MetaDescription'];
    metaTitle = json['MetaTitle'];
    priceRanges = json['PriceRanges'];
    description = json['Description'];
    notes = json['notes'];
    imageUrl = json['ImageUrl'];
    published = json['Published'];
    deleted = json['Deleted'];
    createdAt = json['Created_at'];
    updatedAt = json['Updated_at'];
    manfucteravailbe = json['manfucteravailbe'];
    categories = json['categories'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manufacturerGuid'] = this.manufacturerGuid;
    data['Name'] = this.name;
    data['MetaKeywords'] = this.metaKeywords;
    data['MetaDescription'] = this.metaDescription;
    data['MetaTitle'] = this.metaTitle;
    data['PriceRanges'] = this.priceRanges;
    data['Description'] = this.description;
    data['notes'] = this.notes;
    data['ImageUrl'] = this.imageUrl;
    data['Published'] = this.published;
    data['Deleted'] = this.deleted;
    data['Created_at'] = this.createdAt;
    data['Updated_at'] = this.updatedAt;
    data['manfucteravailbe'] = this.manfucteravailbe;
    data['categories'] = this.categories;
    data['products'] = this.products;
    return data;
  }
}

class ProductDiscounts {
  int id;
  String discountGuid;
  String name;
  String couponCode;
  String adminComment;
  int discountTypeId;
  bool usePercentage;
  String discountPercentage;
  String discountAmount;
  String maximumDiscountAmount;
  String startDate;
  String endDate;
  bool requiresCouponCode;
  bool isCumulative;
  int discountLimitationId;
  bool limitationTimes;
  String maximumDiscountedQuantity;
  bool appliedToSubCategories;
  String discountImgurl;
  bool discountavalibe;
  bool discountshowonhomescreeen;
  String discountTypename;
  String startdateS;
  String enddateS;
  String discountproducts;

  ProductDiscounts(
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

  ProductDiscounts.fromJson(Map<String, dynamic> json) {
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
    discountproducts = json['discountproducts'];
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
    data['discountproducts'] = this.discountproducts;
    return data;
  }
}

class Crossproducts {
  int id;
  String porductGuid;
  String name;
  String metaKeywords;
  String metaTitle;
  String sku;
  String displayOrder;
  bool published;
  bool deleted;
  String createdOn;
  String updatedOnUtc;
  bool hasTierPrices;
  bool hasDiscountsApplied;
  String weight;
  String length;
  String width;
  String height;
  bool markAsNew;
  String markAsNewStartDateTimeUtc;
  String markAsNewEndDateTimeUtc;
  double allowedQuantities;
  int productTypeId;
  bool visibleIndividually;
  String shortDescription;
  String fullDescription;
  String adminComment;
  String productTemplateId;
  bool showOnHomepage;
  String metaDescription;
  bool allowCustomerReviews;
  String approvedRatingSum;
  String notApprovedRatingSum;
  String approvedTotalReviews;
  String notApprovedTotalReviews;
  bool hasUserAgreement;
  String userAgreementText;
  bool isRental;
  bool requireOtherProducts;
  bool automaticallyAddRequiredProducts;
  bool notReturnable;
  bool disableBuyButton;
  bool disableWishlistButton;
  bool availableForPreOrder;
  String preOrderAvailabilityStartDateTime;
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
  String additionalShippingCharge;
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

  Crossproducts(
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

  Crossproducts.fromJson(Map<String, dynamic> json) {
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

class Productspecification {
  int id;
  String specificationGuid;
  String customValue;
  String productGuid;
  String specificationAttributeGuid;
  String specificationAttributeValueGuid;
  String attribute;
  String attributevalue;
  String attributename;
  String attributevaluename;
  String avalibeoptions;

  Productspecification(
      {this.id,
      this.specificationGuid,
      this.customValue,
      this.productGuid,
      this.specificationAttributeGuid,
      this.specificationAttributeValueGuid,
      this.attribute,
      this.attributevalue,
      this.attributename,
      this.attributevaluename,
      this.avalibeoptions});

  Productspecification.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    specificationGuid = json['SpecificationGuid'];
    customValue = json['CustomValue'];
    productGuid = json['ProductGuid'];
    specificationAttributeGuid = json['SpecificationAttributeGuid'];
    specificationAttributeValueGuid = json['SpecificationAttributeValueGuid'];
    attribute = json['attribute'];
    attributevalue = json['attributevalue'];
    attributename = json['attributename'];
    attributevaluename = json['attributevaluename'];
    avalibeoptions = json['avalibeoptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SpecificationGuid'] = this.specificationGuid;
    data['CustomValue'] = this.customValue;
    data['ProductGuid'] = this.productGuid;
    data['SpecificationAttributeGuid'] = this.specificationAttributeGuid;
    data['SpecificationAttributeValueGuid'] =
        this.specificationAttributeValueGuid;
    data['attribute'] = this.attribute;
    data['attributevalue'] = this.attributevalue;
    data['attributename'] = this.attributename;
    data['attributevaluename'] = this.attributevaluename;
    data['avalibeoptions'] = this.avalibeoptions;
    return data;
  }
}

class Productsattrbutes {
  int id;
  String attributeGuid;
  String productGuid;
  String productAttributeGuid;
  String productAttributeValueGuid;
  String colorSquaresRgb;
  int productAttributeMappingId;
  int attributeValueTypeId;
  int associatedProductId;
  bool priceAdjustment;
  String priceAdjustmentUsePercentage;
  String weightAdjustment;
  String cost;
  bool customerEntersQty;
  String quantity;
  bool isPreSelected;
  String displayOrder;
  String pictureId;
  String attribute;
  String attributevalue;
  String attributename;
  String attributevaluename;
  List<Avalibeoptions> avalibeoptions;

  Productsattrbutes(
      {this.id,
      this.attributeGuid,
      this.productGuid,
      this.productAttributeGuid,
      this.productAttributeValueGuid,
      this.colorSquaresRgb,
      this.productAttributeMappingId,
      this.attributeValueTypeId,
      this.associatedProductId,
      this.priceAdjustment,
      this.priceAdjustmentUsePercentage,
      this.weightAdjustment,
      this.cost,
      this.customerEntersQty,
      this.quantity,
      this.isPreSelected,
      this.displayOrder,
      this.pictureId,
      this.attribute,
      this.attributevalue,
      this.attributename,
      this.attributevaluename,
      this.avalibeoptions});

  Productsattrbutes.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    attributeGuid = json['AttributeGuid'];
    productGuid = json['ProductGuid'];
    productAttributeGuid = json['ProductAttributeGuid'];
    productAttributeValueGuid = json['ProductAttributeValueGuid'];
    colorSquaresRgb = json['ColorSquaresRgb'];
    productAttributeMappingId = json['ProductAttributeMappingId'];
    attributeValueTypeId = json['AttributeValueTypeId'];
    associatedProductId = json['AssociatedProductId'];
    priceAdjustment = json['PriceAdjustment'];
    priceAdjustmentUsePercentage = json['PriceAdjustmentUsePercentage'];
    weightAdjustment = json['WeightAdjustment'];
    cost = json['Cost'];
    customerEntersQty = json['CustomerEntersQty'];
    quantity = json['Quantity'];
    isPreSelected = json['IsPreSelected'];
    displayOrder = json['DisplayOrder'];
    pictureId = json['PictureId'];
    attribute = json['attribute'];
    attributevalue = json['attributevalue'];
    attributename = json['attributename'];
    attributevaluename = json['attributevaluename'];
    if (json['avalibeoptions'] != null) {
      avalibeoptions = new List<Avalibeoptions>();
      json['avalibeoptions'].forEach((v) {
        avalibeoptions.add(new Avalibeoptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AttributeGuid'] = this.attributeGuid;
    data['ProductGuid'] = this.productGuid;
    data['ProductAttributeGuid'] = this.productAttributeGuid;
    data['ProductAttributeValueGuid'] = this.productAttributeValueGuid;
    data['ColorSquaresRgb'] = this.colorSquaresRgb;
    data['ProductAttributeMappingId'] = this.productAttributeMappingId;
    data['AttributeValueTypeId'] = this.attributeValueTypeId;
    data['AssociatedProductId'] = this.associatedProductId;
    data['PriceAdjustment'] = this.priceAdjustment;
    data['PriceAdjustmentUsePercentage'] = this.priceAdjustmentUsePercentage;
    data['WeightAdjustment'] = this.weightAdjustment;
    data['Cost'] = this.cost;
    data['CustomerEntersQty'] = this.customerEntersQty;
    data['Quantity'] = this.quantity;
    data['IsPreSelected'] = this.isPreSelected;
    data['DisplayOrder'] = this.displayOrder;
    data['PictureId'] = this.pictureId;
    data['attribute'] = this.attribute;
    data['attributevalue'] = this.attributevalue;
    data['attributename'] = this.attributename;
    data['attributevaluename'] = this.attributevaluename;
    if (this.avalibeoptions != null) {
      data['avalibeoptions'] =
          this.avalibeoptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avalibeoptions {
  int id;
  String productttributeOptionGuid;
  String productAttributeeGuid;
  String name;
  String displayName;
  String attribueDate;
  String attribueColor;
  String attribueRange;
  String attrbuteDateS;
  String productattr;

  Avalibeoptions(
      {this.id,
      this.productttributeOptionGuid,
      this.productAttributeeGuid,
      this.name,
      this.displayName,
      this.attribueDate,
      this.attribueColor,
      this.attribueRange,
      this.attrbuteDateS,
      this.productattr});

  Avalibeoptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productttributeOptionGuid = json['ProductttributeOptionGuid'];
    productAttributeeGuid = json['ProductAttributeeGuid'];
    name = json['Name'];
    displayName = json['DisplayName'];
    attribueDate = json['attribueDate'];
    attribueColor = json['attribueColor'];
    attribueRange = json['attribueRange'];
    attrbuteDateS = json['attrbuteDateS'];
    productattr = json['productattr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ProductttributeOptionGuid'] = this.productttributeOptionGuid;
    data['ProductAttributeeGuid'] = this.productAttributeeGuid;
    data['Name'] = this.name;
    data['DisplayName'] = this.displayName;
    data['attribueDate'] = this.attribueDate;
    data['attribueColor'] = this.attribueColor;
    data['attribueRange'] = this.attribueRange;
    data['attrbuteDateS'] = this.attrbuteDateS;
    data['productattr'] = this.productattr;
    return data;
  }
}
