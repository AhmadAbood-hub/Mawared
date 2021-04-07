import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mawared_app/screens/home/category_details_screen.dart';
import 'package:mawared_app/screens/home/home_screen.dart';
import 'package:mawared_app/utilties/constants.dart';
import 'package:mawared_app/utilties/networking.dart';

import 'category_data.dart';

class HomeData extends ChangeNotifier {
  List<HeaderImage> headerImages;
  List<WeekPromotion> weekPromotionImages;
  List<FlashSale> flashSales;
  List<Category> categories;
  bool showFirstListLoading = true;
  bool showBottomListLoading = true;

  TopHomeData topHomeData;
  List<BottomHomeData> bottomHomeDatas;

  HomeData() {
    getData();
    headerImages = [
      HeaderImage(1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      HeaderImage(2,
          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg'),
      HeaderImage(3,
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop'),
      HeaderImage(4,
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg'),
    ];

    weekPromotionImages = [
      WeekPromotion(1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      WeekPromotion(2,
          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg'),
      WeekPromotion(3,
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop'),
      WeekPromotion(4,
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg'),
    ];

    flashSales = [
      FlashSale(
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'apple macbook somthing  very weired and great jop',
          1300.0,
          1500.0,
          4,
          'aleppo'),
      FlashSale(
          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg',
          'apple macbook somthing  very weired and great jop',
          1300.0,
          1500.0,
          4,
          'aleppo'),
      FlashSale(
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop',
          'apple macbook somthing  very weired and great jop',
          1300.0,
          1500.0,
          4,
          'aleppo'),
      FlashSale(
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg',
          'apple macbook somthing  very weired and great jop',
          1300.0,
          1500.0,
          4,
          'aleppo'),
    ];

    categories = [
      /*  Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      Category("Smart Phone",
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg'),
      Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      Category("Smart Phone",
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),*/
    ];
  }

  void getData() async {
    NetworkHelper networkHelper =
        NetworkHelper('${kBaseApiUrl}api/ClientDashboard/GetFeatureProducts');

    var brandDataJson = await networkHelper.getData();

    NetworkHelper networkHelperBottom =
        NetworkHelper('${kBaseApiUrl}api/ClientDashboard/GetCategoryWidgets');

    if (brandDataJson != null) {
      setData(brandDataJson);
    } else {
      print('error');
    }

    var bottomHomeDatasJson = await networkHelperBottom.getData();

    if (bottomHomeDatasJson != null) {
      setBottomData(bottomHomeDatasJson);
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
    TopHomeData testData = TopHomeData.fromJson(jsonDecode(brandDataJson));
    topHomeData = testData;

    showFirstListLoading = false;
    notifyListeners();
  }

  void setBottomData(var bottomHomeDatasJson) {
    /* var bottomJson = jsonDecode(bottomHomeDatasJson) as List;
    List<BottomHomeData> bottomHomeDatas2 =
        bottomJson.map((e) => BottomHomeData.fromJson(e)).toList();
    bottomHomeDatas = bottomHomeDatas2;
    showBottomListLoading = false;
    print(bottomJson);
    notifyListeners();*/

    var bottomJson = jsonDecode(bottomHomeDatasJson);
    var bottomJsonWidget = bottomJson['widgets'] as List;
    List<BottomHomeData> bottomHomeDatas2 =
        bottomJsonWidget.map((e) => BottomHomeData.fromJson(e)).toList();
    bottomHomeDatas = bottomHomeDatas2;
    showBottomListLoading = false;
    notifyListeners();
  }
}

class GridItem {
  int id;
  String image;
  String name;

  GridItem(this.id, this.image, this.name);
}

class HeaderImage {
  int id;
  String image;

  HeaderImage(this.id, this.image);
}

class WeekPromotion {
  int id;
  String image;

  WeekPromotion(this.id, this.image);
}

class FlashSale {
  String image;
  String name;
  double price;
  double oldPrice;
  double rating;
  String location;

  FlashSale(this.image, this.name, this.price, this.oldPrice, this.rating,
      this.location);
}

class Item {
  int id;
  String image;
  String title;
  double price;
  double oldPrice;
  double rating;
  int numberOfSales;
  int disscount;

  Item(this.id, this.image, this.title, this.price, this.oldPrice, this.rating,
      this.numberOfSales, this.disscount);
}

/*class CategoriesDetailsData extends ChangeNotifier {
  List<HeaderImage> categoryHeader;
  List<SubCategory> subCategories;
  List<SubCategoryDetails> subCategoryDetails;

  bool showLoading = true;

  CategoriesDetailsData(String categoryGide) {
    showLoading = false;
    categoryHeader = [
      HeaderImage(1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'),
      HeaderImage(2,
          'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F1138257321%2F960x0.jpg'),
      HeaderImage(3,
          'https://images.theconversation.com/files/351878/original/file-20200810-22-przb4a.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C5760%2C2880&q=45&auto=format&w=1356&h=668&fit=crop'),
      HeaderImage(4,
          'https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f8ce3bc303aa96a0ceca6b1%2F0x0.jpg'),
    ];

    subCategories = [
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
      SubCategory(1, 'shirt'),
    ];

    List<CategoryItem> items = [
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          null),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
    ];

    subCategoryDetails = [
      SubCategoryDetails(1, 'name', items),
      SubCategoryDetails(2, 'name', items),
      SubCategoryDetails(3, 'name', items),
      SubCategoryDetails(4, 'name', items),
    ];
  }
}*/

class SubCategory {
  int id;
  String name;

  SubCategory(this.id, this.name);
}

class SubCategoryDetails {
  int id;
  String name;
  List<CategoryItem> categoryItem;

  SubCategoryDetails(this.id, this.name, this.categoryItem);
}

class CategoryItem {
  int id;
  String image;
  String title;
  double price;
  double rating;
  int numberOfSales;
  int discount;

  CategoryItem(this.id, this.image, this.title, this.price, this.rating,
      this.numberOfSales, this.discount);
}

class SubCategoryData extends ChangeNotifier {
  //List<CategoryItem> categoryItems;
  CategoryDetails categoryDetails;
  bool showLoading = true;

  SubCategoryData(String guide) {
    getData(guide);
    /*categoryItems = [
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          null),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
      CategoryItem(
          1,
          'https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg',
          'some title',
          1000,
          4.3,
          187,
          45),
    ];*/
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
    //print(showLoading);
    notifyListeners();
  }
}

class ItemDetails {
  int id;
  List<String> images;
  String title;
  String desc;
  double price;
  double rating;
  int numberOfSales;
  List<Specification> specification;
  List<Attribute> attributes;
  List<ItemDetails> relatedItems;

  ItemDetails(
      this.id,
      this.images,
      this.title,
      this.desc,
      this.price,
      this.rating,
      this.numberOfSales,
      this.specification,
      this.attributes,
      this.relatedItems);
}

class ProductDetailsData extends ChangeNotifier {
  ItemDetails itemDetails;
  ItemDetails reItem;

  ProductDetailsData() {
    reItem = ItemDetails(
        2,
        ['https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'],
        'title',
        'desc',
        1400,
        5,
        555,
        null,
        null,
        null);
    List<Specification> sp = [
      Specification('key', 'value'),
      Specification('key', 'value'),
      Specification('key', 'value'),
      Specification('key', 'value'),
      Specification('key', 'value'),
    ];
    List<Attribute> att = [
      Attribute(3, 'name', ['values', 'blalbla'], 1),
      Attribute(3, 'name', ['values', 'blalbla'], 1),
      Attribute(3, 'name', ['values', 'blalbla'], 6),
      Attribute(3, 'name', ['values', 'blalbla'], 1),
      Attribute(3, 'name', ['values', 'blalbla'], 1),
    ];

    itemDetails = ItemDetails(
        1,
        ['https://www.expatica.com/app/uploads/sites/11/2014/05/Shopping.jpg'],
        'title',
        'desc',
        1400,
        3,
        222,
        sp,
        att,
        [reItem]);
  }
}

class Specification {
  int id;
  String key;
  String value;

  Specification(this.key, this.value);
}

class Attribute {
  int id;
  String name;
  List<String> values;
  //if type is 1 its a text else its a color widget
  int type;

  Attribute(this.id, this.name, this.values, this.type);
}

class TopHomeData {
  List<MainBrochures> mainBrochures;
  List<Product> featureproducts;
  List<Product> newproducts;
  List<Product> recommandedproducts;
  List<Product> flashSalesProduct;
  List<Category> mainCategories;
  List<Discount> discounts;

  TopHomeData(
      {this.mainBrochures,
      this.mainCategories,
      this.featureproducts,
      this.newproducts,
      this.recommandedproducts,
      this.flashSalesProduct,
      this.discounts});

  TopHomeData.fromJson(Map<String, dynamic> json) {
    if (json['MainBrochures'] != null) {
      mainBrochures = new List<MainBrochures>();
      json['MainBrochures'].forEach((v) {
        mainBrochures.add(new MainBrochures.fromJson(v));
      });
    }
    if (json['MainCategories'] != null) {
      mainCategories = new List<Category>();
      json['MainCategories'].forEach((v) {
        mainCategories.add(new Category.fromJson(v));
      });
    }
    if (json['featureproducts'] != null) {
      featureproducts = new List<Product>();
      json['featureproducts'].forEach((v) {
        featureproducts.add(new Product.fromJson(v));
      });
    }
    if (json['newproducts'] != null) {
      newproducts = new List<Product>();
      json['newproducts'].forEach((v) {
        newproducts.add(new Product.fromJson(v));
      });
    }
    if (json['recommandedproducts'] != null) {
      recommandedproducts = new List<Product>();
      json['recommandedproducts'].forEach((v) {
        recommandedproducts.add(new Product.fromJson(v));
      });
    }
    if (json['FlashSalesProduct'] != null) {
      flashSalesProduct = new List<Product>();
      json['FlashSalesProduct'].forEach((v) {
        flashSalesProduct.add(new Product.fromJson(v));
      });
    }
    if (json['Discounts'] != null) {
      discounts = new List<Discount>();
      json['Discounts'].forEach((v) {
        discounts.add(new Discount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainBrochures != null) {
      data['MainBrochures'] =
          this.mainBrochures.map((v) => v.toJson()).toList();
    }
    if (this.mainCategories != null) {
      data['MainCategories'] =
          this.mainCategories.map((v) => v.toJson()).toList();
    }
    if (this.featureproducts != null) {
      data['featureproducts'] =
          this.featureproducts.map((v) => v.toJson()).toList();
    }
    if (this.newproducts != null) {
      data['newproducts'] = this.newproducts.map((v) => v.toJson()).toList();
    }
    if (this.recommandedproducts != null) {
      data['recommandedproducts'] =
          this.recommandedproducts.map((v) => v.toJson()).toList();
    }
    if (this.flashSalesProduct != null) {
      data['FlashSalesProduct'] =
          this.flashSalesProduct.map((v) => v.toJson()).toList();
    }
    if (this.discounts != null) {
      data['Discounts'] = this.discounts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainBrochures {
  int id;
  String categoryBrochureGuid;
  String categoryGuid;
  String url;
  String imageUrl;

  MainBrochures(
      {this.id,
      this.categoryBrochureGuid,
      this.categoryGuid,
      this.url,
      this.imageUrl});

  MainBrochures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryBrochureGuid = json['CategoryBrochureGuid'];
    categoryGuid = json['CategoryGuid'];
    url = json['url'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryBrochureGuid'] = this.categoryBrochureGuid;
    data['CategoryGuid'] = this.categoryGuid;
    data['url'] = this.url;
    data['imageUrl'] = this.imageUrl;
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
  String productImgcolor;
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
  String manufacutername;
  String categories;
  String manfucters;
  String tags;
  //String discounts;
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
      this.productImgcolor,
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
      this.manufacutername,
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
      this.categories,
      this.manfucters,
      this.tags,
      //this.discounts,
      this.relatedProducts,
      this.crossProducts});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    porductGuid = json['PorductGuid'];
    name = json['Name'];
    metaKeywords = json['MetaKeywords'];
    manufacutername = json['manufacutername'];
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
    productImgcolor = json['ProductImgcolor'];
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
    categories = json['categories'];
    manfucters = json['manfucters'];
    tags = json['tags'];
    //discounts = json['discounts'];
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
    data['ProductImgcolor'] = this.productImgcolor;
    data['Sku'] = this.sku;
    data['DisplayOrder'] = this.displayOrder;
    data['Published'] = this.published;
    data['Deleted'] = this.deleted;
    data['CreatedOn'] = this.createdOn;
    data['manufacutername'] = this.manufacutername;
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
    data['categories'] = this.categories;
    data['manfucters'] = this.manfucters;
    data['tags'] = this.tags;
    //data['discounts'] = this.discounts;
    data['relatedProducts'] = this.relatedProducts;
    data['crossProducts'] = this.crossProducts;
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
  String parentcategoryentity;

  Category(
      {this.id,
      this.categoryGuid,
      this.name,
      this.categoryAvalible,
      this.parentCategory,
      this.catImgUrl,
      this.parentcategoryentity});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryGuid = json['CategoryGuid'];
    name = json['Name'];
    categoryAvalible = json['CategoryAvalible'];
    parentCategory = json['ParentCategory'];
    catImgUrl = json['CatImgUrl'];
    parentcategoryentity = json['parentcategoryentity'];
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
    return data;
  }
}

class Discount {
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

  Discount(
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
      this.enddateS});

  Discount.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class BottomHomeData {
  int id;
  String categoryWidgetGuid;
  String categoryGuid;
  int widgetControlId;
  String displayOrder;
  String categoryName;
  String widgetControlName;
  List<Product> products;
  List<MainBrochures> categoryBrochures;
  List<Category> subcategories;

  BottomHomeData(
      {this.id,
      this.categoryWidgetGuid,
      this.categoryGuid,
      this.widgetControlId,
      this.displayOrder,
      this.categoryName,
      this.widgetControlName,
      this.products,
      this.categoryBrochures,
      this.subcategories});

  BottomHomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryWidgetGuid = json['CategoryWidgetGuid'];
    categoryGuid = json['CategoryGuid'];
    widgetControlId = json['WidgetControlId'];
    displayOrder = json['displayOrder'];
    categoryName = json['CategoryName'];
    widgetControlName = json['WidgetControlName'];
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    if (json['CategoryBrochures'] != null) {
      categoryBrochures = new List<MainBrochures>();
      json['CategoryBrochures'].forEach((v) {
        categoryBrochures.add(new MainBrochures.fromJson(v));
      });
    }
    if (json['subcategories'] != null) {
      subcategories = new List<Category>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryWidgetGuid'] = this.categoryWidgetGuid;
    data['CategoryGuid'] = this.categoryGuid;
    data['WidgetControlId'] = this.widgetControlId;
    data['displayOrder'] = this.displayOrder;
    data['CategoryName'] = this.categoryName;
    data['WidgetControlName'] = this.widgetControlName;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['CategoryBrochures'] = this.categoryBrochures;
    data['subcategories'] = this.subcategories;
    return data;
  }
}
