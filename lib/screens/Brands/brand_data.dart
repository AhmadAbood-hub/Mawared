import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';

class BrandTapData extends ChangeNotifier {
  List<Brand> brandData = [
    /*  Brand(
      name: "Nike Sport",
      id: 1,
      image:
          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: 'Tech',
      id: 2,
      image:
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: "Sony Tech",
      id: 3,
      image:
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: "Sony Tech",
      id: 4,
      image:
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: "Sony Tech",
      id: 5,
      image:
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: "Sony Tech",
      id: 6,
      image:
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Brand(
      name: "Sony Tech",
      id: 7,
      image:
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),*/
  ];

  bool showLoading = true;

  BrandTapData() {
    getBrandsList();
  }

  Future<void> getBrandsList() async {
    NetworkHelper networkHelper =
        NetworkHelper('${kBaseApiUrl}api/ClientManufacturers/GetBrands');

    var brandDataJson = await networkHelper.getData();

    if (brandDataJson != null) {
      setData(brandDataJson);
    } else {
      print('error');
    }
  }

  void setData(var brandDataJson) {
    ///list value
    var brand1 = jsonDecode(brandDataJson) as List;
    List<Brand> usersList = brand1.map((e) => Brand.fromJson(e)).toList();
    brandData = usersList;
    showLoading = false;
    notifyListeners();
    /*var usersJson = jsonDecode(users) as List;
    List<User> usersList = usersJson.map((e) => User.fromJson(e)).toList();
    for (User user in usersList) {
      print(user.address.city);
    }
    print(usersList.length);*/

    ///single value
    /*print(users);
    TestData testData = TestData.fromJson(jsonDecode(users));
    print(testData.data[2].email);*/
  }
}

class BrandDetailsData extends ChangeNotifier {
  Brand brand;
  List<SortBy> sortValues;
  List<RefineBy> refineValues;
  bool showLoading = true;

  BrandDetailsData(String id) {
    getData(id);
  }

  void getData(String id) async {
    NetworkHelper networkHelper = NetworkHelper(
        '${kBaseApiUrl}api/ClientManufacturers/GetBrandDetail?manfucterGuid=${id}');

    var brandDataJson = await networkHelper.getData();

    if (brandDataJson != null) {
      setData(brandDataJson);
    } else {
      print('error');
    }
  }

  void setData(var brandDataJson) {
    /*var usersJson = jsonDecode(users) as List;
    List<User> usersList = usersJson.map((e) => User.fromJson(e)).toList();
    for (User user in usersList) {
      print(user.address.city);
    }
    print(usersList.length);*/

    ///single value
    Brand testData = Brand.fromJson(jsonDecode(brandDataJson));
    brand = testData;
    showLoading = false;
    notifyListeners();
  }
}

/*BrandDetailsData(int id) {
    List<Item> items = [
      Item(
          1,
          'name',
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
          900,
          3),
      Item(
          2,
          'name',
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
          900,
          3),
      Item(
          3,
          'name',
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
          900,
          3),
      Item(
          4,
          'name',
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
          900,
          3),
    ];

    brand = Brand(
        id: 5,
        name: 'Nike',
        desc:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        image:
            'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
        items: items);

    sortValues = [
      SortBy(1, 'الاكثر طلبا'),
      SortBy(1, 'الجديد'),
      SortBy(1, 'نسبة الحسم'),
      SortBy(1, 'السعر'),
    ];
    refineValues = [
      RefineBy(1, 'الاكثر طلبا'),
      RefineBy(1, 'الجديد'),
      RefineBy(1, 'نسبة الحسم'),
      RefineBy(1, 'السعر'),
    ];
  }*/

class SortBy {
  int id;
  String name;

  SortBy(this.id, this.name);
}

class RefineBy {
  int id;
  String name;

  RefineBy(this.id, this.name);
}

class Item {
  int id;
  String name;
  String image;
  double price;
  double rating;

  Item({this.id, this.name, this.image, this.price, this.rating});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}

class Brand {
  int id;
  String manufacturerGuid;
  String name;
  Null metaKeywords;
  String metaDescription;
  Null metaTitle;
  Null priceRanges;
  String description;
  String notes;
  String imageUrl;
  bool published;
  bool deleted;
  Null createdAt;
  Null updatedAt;
  bool manfucteravailbe;
  Null categories;
  List<Products> products;

  Brand(
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

  Brand.fromJson(Map<String, dynamic> json) {
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
  String sku;
  Null displayOrder;
  bool published;
  bool deleted;
  String createdOn;
  Null updatedOnUtc;
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
  Null productTemplateId;
  bool showOnHomepage;
  String metaDescription;
  bool allowCustomerReviews;
  Null approvedRatingSum;
  Null notApprovedRatingSum;
  Null approvedTotalReviews;
  Null notApprovedTotalReviews;
  bool hasUserAgreement;
  String userAgreementText;
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
  Null minimumCustomerEnteredPrice;
  Null maximumCustomerEnteredPrice;
  Null basepriceEnabled;
  Null basepriceAmount;
  Null basepriceUnitId;
  Null basepriceBaseAmount;
  Null basepriceBaseUnitId;
  String stockQuantity;
  bool displayStockAvailability;
  bool displayStockQuantity;
  String minStockQuantity;
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
  String porductTemplateGuid;
  String productImg;
  Null categories;
  Null manfucters;
  Null tags;
  Null discounts;
  Null relatedProducts;
  Null crossProducts;

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
      this.porductTemplateGuid,
      this.productImg,
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
    allowedQuantities = json['AllowedQuantities'].toDouble();
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
    porductTemplateGuid = json['PorductTemplateGuid'];
    productImg = json['ProductImg'];
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
    data['PorductTemplateGuid'] = this.porductTemplateGuid;
    data['ProductImg'] = this.productImg;
    data['categories'] = this.categories;
    data['manfucters'] = this.manfucters;
    data['tags'] = this.tags;
    data['discounts'] = this.discounts;
    data['relatedProducts'] = this.relatedProducts;
    data['crossProducts'] = this.crossProducts;
    return data;
  }
}
