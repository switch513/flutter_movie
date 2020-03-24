import 'dart:convert' show json;

class MovieInfo {
  Rating rating;
  int reviewsCount;
  List<Videos> videos;
  int wishCount;
  String originalTitle;
  List<Null> blooperUrls;
  int collectCount;
  Images images;
  String doubanSite;
  String year;
  List<PopularComments> popularComments;
  String alt;
  String id;
  String mobileUrl;
  int photosCount;
  String pubdate;
  String title;
  Null doCount;
  bool hasVideo;
  String shareUrl;
  Null seasonsCount;
  List<String> languages;
  String scheduleUrl;
  List<Writers> writers;
  List<String> pubdates;
  String website;
  List<String> tags;
  bool hasSchedule;
  List<String> durations;
  List<String> genres;
  Null collection;
  List<Null> trailers;
  Null episodesCount;
  List<Null> trailerUrls;
  bool hasTicket;
  List<Null> bloopers;
  List<Null> clipUrls;
  Null currentSeason;
  List<Casts> casts;
  List<String> countries;
  String mainlandPubdate;
  List<Photos> photos;
  String summary;
  List<Null> clips;
  String subtype;
  List<Directors> directors;
  int commentsCount;
  List<PopularReviews> popularReviews;
  int ratingsCount;
  List<String> aka;

  factory MovieInfo(jsonStr) => jsonStr == null ? null : jsonStr is String ? MovieInfo.fromJson(json.decode(jsonStr)) : MovieInfo.fromJson(jsonStr);

  MovieInfo.fromParams(
      {this.rating,
        this.reviewsCount,
        this.videos,
        this.wishCount,
        this.originalTitle,
        this.blooperUrls,
        this.collectCount,
        this.images,
        this.doubanSite,
        this.year,
        this.popularComments,
        this.alt,
        this.id,
        this.mobileUrl,
        this.photosCount,
        this.pubdate,
        this.title,
        this.doCount,
        this.hasVideo,
        this.shareUrl,
        this.seasonsCount,
        this.languages,
        this.scheduleUrl,
        this.writers,
        this.pubdates,
        this.website,
        this.tags,
        this.hasSchedule,
        this.durations,
        this.genres,
        this.collection,
        this.trailers,
        this.episodesCount,
        this.trailerUrls,
        this.hasTicket,
        this.bloopers,
        this.clipUrls,
        this.currentSeason,
        this.casts,
        this.countries,
        this.mainlandPubdate,
        this.photos,
        this.summary,
        this.clips,
        this.subtype,
        this.directors,
        this.commentsCount,
        this.popularReviews,
        this.ratingsCount,
        this.aka});

  MovieInfo.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    reviewsCount = json['reviews_count'];
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
    wishCount = json['wish_count'];
    originalTitle = json['original_title'];
    collectCount = json['collect_count'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    doubanSite = json['douban_site'];
    year = json['year'];
    if (json['popular_comments'] != null) {
      popularComments = new List<PopularComments>();
      json['popular_comments'].forEach((v) {
        popularComments.add(new PopularComments.fromJson(v));
      });
    }
    alt = json['alt'];
    id = json['id'];
    mobileUrl = json['mobile_url'];
    photosCount = json['photos_count'];
    pubdate = json['pubdate'];
    title = json['title'];
    doCount = json['do_count'];
    hasVideo = json['has_video'];
    shareUrl = json['share_url'];
    seasonsCount = json['seasons_count'];
    languages = json['languages'].cast<String>();
    scheduleUrl = json['schedule_url'];
    if (json['writers'] != null) {
      writers = new List<Writers>();
      json['writers'].forEach((v) {
        writers.add(new Writers.fromJson(v));
      });
    }
    pubdates = json['pubdates'].cast<String>();
    website = json['website'];
    tags = json['tags'].cast<String>();
    hasSchedule = json['has_schedule'];
    durations = json['durations'].cast<String>();
    genres = json['genres'].cast<String>();
    collection = json['collection'];
    episodesCount = json['episodes_count'];
    hasTicket = json['has_ticket'];
    currentSeason = json['current_season'];
    if (json['casts'] != null) {
      casts = new List<Casts>();
      json['casts'].forEach((v) {
        casts.add(new Casts.fromJson(v));
      });
    }
    countries = json['countries'].cast<String>();
    mainlandPubdate = json['mainland_pubdate'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    summary = json['summary'];
    subtype = json['subtype'];
    if (json['directors'] != null) {
      directors = new List<Directors>();
      json['directors'].forEach((v) {
        directors.add(new Directors.fromJson(v));
      });
    }
    commentsCount = json['comments_count'];
    if (json['popular_reviews'] != null) {
      popularReviews = new List<PopularReviews>();
      json['popular_reviews'].forEach((v) {
        popularReviews.add(new PopularReviews.fromJson(v));
      });
    }
    ratingsCount = json['ratings_count'];
    aka = json['aka'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['reviews_count'] = this.reviewsCount;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['wish_count'] = this.wishCount;
    data['original_title'] = this.originalTitle;
    data['collect_count'] = this.collectCount;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['douban_site'] = this.doubanSite;
    data['year'] = this.year;
    if (this.popularComments != null) {
      data['popular_comments'] =
          this.popularComments.map((v) => v.toJson()).toList();
    }
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['mobile_url'] = this.mobileUrl;
    data['photos_count'] = this.photosCount;
    data['pubdate'] = this.pubdate;
    data['title'] = this.title;
    data['do_count'] = this.doCount;
    data['has_video'] = this.hasVideo;
    data['share_url'] = this.shareUrl;
    data['seasons_count'] = this.seasonsCount;
    data['languages'] = this.languages;
    data['schedule_url'] = this.scheduleUrl;
    if (this.writers != null) {
      data['writers'] = this.writers.map((v) => v.toJson()).toList();
    }
    data['pubdates'] = this.pubdates;
    data['website'] = this.website;
    data['tags'] = this.tags;
    data['has_schedule'] = this.hasSchedule;
    data['durations'] = this.durations;
    data['genres'] = this.genres;
    data['collection'] = this.collection;

    data['episodes_count'] = this.episodesCount;
    data['has_ticket'] = this.hasTicket;
    data['current_season'] = this.currentSeason;
    if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
    data['countries'] = this.countries;
    data['mainland_pubdate'] = this.mainlandPubdate;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['summary'] = this.summary;
    data['subtype'] = this.subtype;
    if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
    data['comments_count'] = this.commentsCount;
    if (this.popularReviews != null) {
      data['popular_reviews'] =
          this.popularReviews.map((v) => v.toJson()).toList();
    }
    data['ratings_count'] = this.ratingsCount;
    data['aka'] = this.aka;
    return data;
  }
}

class Rating {
  int max;
  double average;
  Details details;
  String stars;
  int min;

  Rating({this.max, this.average, this.details, this.stars, this.min});

  Rating.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    average = json['average'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    stars = json['stars'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['average'] = this.average;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['stars'] = this.stars;
    data['min'] = this.min;
    return data;
  }
}

class Details {
  int i1;
  int i2;
  int i3;
  int i4;
  int i5;

  Details({this.i1, this.i2, this.i3, this.i4, this.i5});

  Details.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.i1;
    data['2'] = this.i2;
    data['3'] = this.i3;
    data['4'] = this.i4;
    data['5'] = this.i5;
    return data;
  }
}

class Videos {
  Source source;
  String sampleLink;
  String videoId;
  bool needPay;

  Videos({this.source, this.sampleLink, this.videoId, this.needPay});

  Videos.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    sampleLink = json['sample_link'];
    videoId = json['video_id'];
    needPay = json['need_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['sample_link'] = this.sampleLink;
    data['video_id'] = this.videoId;
    data['need_pay'] = this.needPay;
    return data;
  }
}

class Source {
  String literal;
  String pic;
  String name;

  Source({this.literal, this.pic, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    literal = json['literal'];
    pic = json['pic'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['literal'] = this.literal;
    data['pic'] = this.pic;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  String small;
  String large;
  String medium;

  Images({this.small, this.large, this.medium});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class PopularComments {
  Rating rating;
  int usefulCount;
  Author author;
  String subjectId;
  String content;
  String createdAt;
  String id;

  PopularComments(
      {this.rating,
        this.usefulCount,
        this.author,
        this.subjectId,
        this.content,
        this.createdAt,
        this.id});

  PopularComments.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    usefulCount = json['useful_count'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    subjectId = json['subject_id'];
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['useful_count'] = this.usefulCount;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['subject_id'] = this.subjectId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}


class Author {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  Author({this.uid, this.avatar, this.signature, this.alt, this.id, this.name});

  Author.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    signature = json['signature'];
    alt = json['alt'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['avatar'] = this.avatar;
    data['signature'] = this.signature;
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Writers {
  Images avatars;
  String nameEn;
  String name;
  String alt;
  String id;

  Writers({this.avatars, this.nameEn, this.name, this.alt, this.id});

  Writers.fromJson(Map<String, dynamic> json) {
    avatars =
    json['avatars'] != null ? new Images.fromJson(json['avatars']) : null;
    nameEn = json['name_en'];
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

class Photos {
  String thumb;
  String image;
  String cover;
  String alt;
  String id;
  String icon;

  Photos({this.thumb, this.image, this.cover, this.alt, this.id, this.icon});

  Photos.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    image = json['image'];
    cover = json['cover'];
    alt = json['alt'];
    id = json['id'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['image'] = this.image;
    data['cover'] = this.cover;
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['icon'] = this.icon;
    return data;
  }
}

class PopularReviews {
  Rating rating;
  String title;
  String subjectId;
  Author author;
  String summary;
  String alt;
  String id;

  PopularReviews(
      {this.rating,
        this.title,
        this.subjectId,
        this.author,
        this.summary,
        this.alt,
        this.id});

  PopularReviews.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    title = json['title'];
    subjectId = json['subject_id'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    summary = json['summary'];
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['title'] = this.title;
    data['subject_id'] = this.subjectId;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['summary'] = this.summary;
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

class Casts {
  Avatars avatars;
  String nameEn;
  String name;
  String alt;
  String id;

  Casts({this.avatars, this.nameEn, this.name, this.alt, this.id});

  Casts.fromJson(Map<String, dynamic> json) {
    avatars =
    json['avatars'] != null ? new Avatars.fromJson(json['avatars']) : null;
    nameEn = json['name_en'];
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

class Avatars {
  String small;
  String large;
  String medium;

  Avatars({this.small, this.large, this.medium});

  Avatars.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class Directors {
  Avatars avatars;
  String nameEn;
  String name;
  String alt;
  String id;

  Directors({this.avatars, this.nameEn, this.name, this.alt, this.id});

  Directors.fromJson(Map<String, dynamic> json) {
    avatars =
    json['avatars'] != null ? new Avatars.fromJson(json['avatars']) : null;
    nameEn = json['name_en'];
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name_en'] = this.nameEn;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }
}

