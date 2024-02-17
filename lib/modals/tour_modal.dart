// ignore_for_file: avoid_print

class TourModal {
  final String? resultType;
  final TourDataModal? resultObject;

  TourModal({
    this.resultType,
    this.resultObject,
  });

  factory TourModal.fromJson(Map<String, dynamic> json) {
    // print(json['result_type']);
    return TourModal(
      resultType: (json['result_type'] as String?)?.toString(),
      resultObject: TourDataModal.fromJson(json['result_object']),
    );
  }
}

// All Deatils are here
class TourDataModal {
  final String? name;
  final String? lat;
  final String? long;
  final String? review;
  final String? location;
  final String? timezone;
  final String? caption;
  final bool? blessed;
  final String? uploadDate;
  final String? publishedDate;
  final String? clickZone;
  final String? geoType;
  final String? distance;
  final String? rating;
  final bool? isClosed;
  final String? openNow;
  final bool? isLongClosed;
  final String? description;
  final String? geodescription;
  final String? webUrl;
  final String? address;
  final ImagesModal image;
  final CategoryCountModal category;

  TourDataModal({
    this.name,
    this.lat,
    this.long,
    this.review,
    this.location,
    this.timezone,
    this.caption,
    this.blessed,
    this.uploadDate,
    this.publishedDate,
    this.clickZone,
    this.geoType,
    this.distance,
    this.rating,
    this.isClosed,
    this.openNow,
    this.isLongClosed,
    this.description,
    this.geodescription,
    this.webUrl,
    this.address,
    required this.image,
    required this.category,
  });

  factory TourDataModal.fromJson(Map<String, dynamic> json) {
    return TourDataModal(
      name: (json['name'] as String?)?.toString(),
      lat: (json['latitude'] as String?)?.toString(),
      long: (json['longitude'] as String?)?.toString(),
      review: (json['num_reviews'] as String?)?.toString(),
      location: (json['location_string'] as String?)?.toString(),
      timezone: (json['timezone'] as String?)?.toString(),
      caption: (json['caption'] as String?)?.toString(),
      blessed: (json['is_blessed']),
      uploadDate: (json['uploaded_date'] as String?)?.toString(),
      publishedDate: (json['published_date'] as String?)?.toString(),
      clickZone: (json['doubleclick_zone'] as String?)?.toString(),
      geoType: (json['geo_type'] as String?)?.toString(),
      distance: (json['distance'] as String?)?.toString(),
      rating: (json['rating'] as String?)?.toString(),
      isClosed: (json['is_closed']),
      openNow: (json['open_now_text'] as String?)?.toString(),
      isLongClosed: (json['is_long_closed']),
      description: (json['description'] as String?)?.toString(),
      geodescription: (json['geo_description'] as String?)?.toString(),
      webUrl: (json['web_url'] as String?)?.toString(),
      address: (json['address'] as String?)?.toString(),
      image: json['photo'] != null
          ? ImagesModal.fromJson(json['photo'])
          : ImagesModal(
              images: OriginalModal(original: ImageModal(imgsize: null))),
      category: json['category_counts'] != null
          ? CategoryCountModal.fromJson(json['category_counts'])
          : CategoryCountModal(
              attrationmodal: AttractionModal(),
              restraurant: TotalRestraurantModal(restraurant: null)),
    );
  }
}

// Image Parameter are here
class ImagesModal {
  final OriginalModal images;

  ImagesModal({required this.images});
  factory ImagesModal.fromJson(Map<String, dynamic> json) {
    return ImagesModal(
      images: OriginalModal.fromJson(json['images']),
    );
  }
}

class OriginalModal {
  final ImageModal original;

  OriginalModal({required this.original});
  factory OriginalModal.fromJson(Map<String, dynamic> json) {
    return OriginalModal(
      original: ImageModal.fromJson(json['original']),
    );
  }
}

class ImageModal {
  final String? imgsize;

  ImageModal({this.imgsize});
  factory ImageModal.fromJson(Map<String, dynamic> json) {
    return ImageModal(
      imgsize: json['url'],
    );
  }
}

// Category types are here
class CategoryCountModal {
  final AttractionModal attrationmodal;
  final TotalRestraurantModal restraurant;
  final String? neighborhoods;
  final String? airports;

  CategoryCountModal({
    required this.attrationmodal,
    required this.restraurant,
    this.neighborhoods,
    this.airports,
  });
  factory CategoryCountModal.fromJson(Map<String, dynamic> json) {
    return CategoryCountModal(
      attrationmodal: AttractionModal.fromJson(json['attractions']),
      restraurant: TotalRestraurantModal.fromJson(json['restaurants']),
      neighborhoods: (json['neighborhoods'] as String?)?.toString(),
      airports: (json['airports'] as String?)?.toString(),
    );
  }
}

class AttractionModal {
  final String? activities;
  final String? attractions;
  final String? nightlife;
  final String? shopping;

  AttractionModal({
    this.activities,
    this.attractions,
    this.nightlife,
    this.shopping,
  });

  factory AttractionModal.fromJson(Map<String, dynamic> json) {
    return AttractionModal(
      activities: (json['activities'] as String?)?.toString(),
      attractions: (json['attractions'] as String?)?.toString(),
      nightlife: (json['nightlife'] as String?)?.toString(),
      shopping: (json['shopping'] as String?)?.toString(),
    );
  }
}

class TotalRestraurantModal {
  final String? restraurant;

  TotalRestraurantModal({this.restraurant});

  factory TotalRestraurantModal.fromJson(Map<String, dynamic> json) {
    return TotalRestraurantModal(
      restraurant: (json['total'] as String?)?.toString(),
    );
  }
}
