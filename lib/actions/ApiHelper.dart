import 'dart:convert' show json;
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:movie/actions/request.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/time_window.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/search_result.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static final String _apikey = 'd7ff494718186ed94ee75cf73c1a3214';
  static final String _apikeyV4 =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2ZmNDk0NzE4MTg2ZWQ5NGVlNzVjZjczYzFhMzIxNCIsInN1YiI6IjVkMDQ1OWM1OTI1MTQxNjNkMWJjNDZjYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tTDwJEVH88cCWCfTd42zvN4AsMR2pgix0QdzVJQzzDM';
  static String _requestToken;
  static String accessTokenV4;
  static String session;
  static DateTime _sessionExpiresTime;
  static SharedPreferences prefs;
  static String language = ui.window.locale.languageCode;
  static String region = ui.window.locale.countryCode;
  static bool includeAdult;
  static Request _http = Request('https://api.themoviedb.org/3');
  static Request _httpV4 = Request('https://api.themoviedb.org/4');
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    includeAdult = prefs.getBool('adultItems') ?? false;
  }

  static Future createGuestSession() async {
    String param = '/authentication/guest_session/new?api_key=$_apikey';
    dynamic r = await _http.request(param);
    if (r != null) {
      if (r['success']) {
        session = r['guest_session_id'];
        _sessionExpiresTime = DateTime.parse(
            r['expires_at'].toString().replaceFirst(new RegExp(' UTC'), ''));
        var date = DateTime.utc(
            _sessionExpiresTime.year,
            _sessionExpiresTime.month,
            _sessionExpiresTime.day,
            _sessionExpiresTime.hour,
            _sessionExpiresTime.minute,
            _sessionExpiresTime.second,
            _sessionExpiresTime.millisecond,
            _sessionExpiresTime.microsecond);
        prefs.setString('guestSession', session);
        prefs.setString('guestSessionExpires', date.toIso8601String());
      }
    }
  }

  static Future createRequestToken() async {
    String param = '/authentication/token/new?api_key=$_apikey';
    dynamic r = await _http.request(param);
    if (r != null) {
      if (r['success']) {
        _requestToken = r['request_token'];
      }
    }
  }


  static Future createSessionWithV4(String sessionToken) async {
    String param = '/authentication/session/convert/4?api_key=$_apikey';
    FormData formData = new FormData.fromMap({"access_token": _apikeyV4});
    dynamic r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $accessTokenV4'});
    if (r != null) {
      if (r['success']) {
        session = r['session_id'];
        _sessionExpiresTime = DateTime.parse(
            r['expires_at'].toString().replaceFirst(new RegExp(' UTC'), ''));
        prefs.setString('loginsession', session);
        prefs.setString(
            'loginsessionexpires', _sessionExpiresTime.toIso8601String());
      }
    }
  }


  static Future<bool> deleteSession() async {
    String param = '/authentication/session?api_key=$_apikey';
    if (session != null) {
      FormData formData = new FormData.fromMap({"session_id": session});
      dynamic r = await _http.request(param,
          method: 'DELETE', queryParameters: formData);
      if (r != null) {
        if (r['status_code'] == 6) {
          prefs.remove('loginsession');
          prefs.remove('accountid');
          prefs.remove('accountname');
          prefs.remove('accountgravatar');
          prefs.remove('islogin');
          await deleteAccessTokenV4();
        } else
          return false;
      }
    }
    return true;
  }

  static Future<String> createRequestTokenV4() async {
    String result;
    String param = "/auth/request_token";
    FormData formData = new FormData.fromMap({});
    var r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    if (r != null) {
      var jsonobject = json.decode(r);
      if (jsonobject['success']) {
        result = jsonobject['request_token'];
      }
    }
    return result;
  }

  static Future<bool> createAccessTokenV4(String requestTokenV4) async {
    if (requestTokenV4 == null) return false;
    bool result = false;
    String param = "/auth/access_token";
    FormData formData = new FormData.fromMap({"request_token": requestTokenV4});
    var r = await _httpV4.request(param,
        method: "POST",
        data: formData,
        headers: {'Authorization': 'Bearer $_apikeyV4'});
    if (r != null) {
      var jsonobject = json.decode(r);
      if (jsonobject['success']) {
        String _accountid = jsonobject['account_id'];
        accessTokenV4 = jsonobject['access_token'];
        prefs.setString('accountIdV4', _accountid);
        prefs.setString('accessTokenV4', accessTokenV4);
        result = true;
      }
    }
    return result;
  }



  static Future<bool> deleteAccessTokenV4() async {
    String param = '/auth/access_token';
    if (session != null) {
      var formData = {"access_token": accessTokenV4};
      dynamic r = await _httpV4.request(param,
          method: 'DELETE',
          headers: {'Authorization': 'Bearer $_apikeyV4'},
          queryParameters: formData);
      if (r != null) {
        if (r['success']) {
          prefs.remove('accountIdV4');
          prefs.remove('accessTokenV4');
        } else
          return false;
      }
    }
    return true;
  }

  static Future<bool> markAsFavorite(
      int id, MediaType type, bool isFavorite) async {
    bool result = false;
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return result;
    String param =
        '/account/$accountid/favorite?api_key=$_apikey&session_id=$session';
    var formData = {
      "media_type": type == MediaType.movie ? "movie" : "tv",
      "media_id": id,
      "favorite": isFavorite
    };
    dynamic r = await _http.request(param, method: "POST", data: formData);
    if (r != null) {
      if (r['status_code'] == 1 ||
          r['status_code'] == 12 ||
          r['status_code'] == 13) result = true;
    }
    return result;
  }

  static Future<bool> addToWatchlist(int id, MediaType type, bool isAdd) async {
    bool result = false;
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return result;
    String param =
        '/account/$accountid/watchlist?api_key=$_apikey&session_id=$session';
    var formData = {
      "media_type": type == MediaType.movie ? 'movie' : 'tv',
      "media_id": id,
      "watchlist": isAdd
    };
    dynamic r = await _http.request(param, method: "POST", data: formData);
    if (r != null) {
      if (r['status_code'] == 1 ||
          r['status_code'] == 12 ||
          r['status_code'] == 13) result = true;
    }
    return result;
  }



  ///Get the list of your favorite TV shows.
  static Future<VideoListModel> getFavoriteTVShows(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    VideoListModel model;
    String param =
        '/account/$accountid/favorite/tv?api_key=$_apikey&language=$language&session_id=$session&sort_by=$sortBy&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getMoviesWatchlist(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    VideoListModel model;
    String param =
        '/account/$accountid/watchlist/movies?api_key=$_apikey&language=$language&session_id=$session&sort_by=$sortBy&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getTVShowsWacthlist(int accountid,
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    VideoListModel model;
    String param =
        '/account/$accountid/watchlist/tv?api_key=$_apikey&language=$language&session_id=$session&sort_by=$sortBy&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  ///Get a list of all the movies you have rated.
  static Future<VideoListModel> getRatedMovies(
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return null;
    VideoListModel model;
    String param =
        '/account/$accountid/rated/movies?api_key=$_apikey&language=$language&session_id=$session&sort_by=$sortBy&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  ///Get a list of all the movies you have rated.
  static Future<VideoListModel> getRatedTVShows(
      {int page = 1, String sortBy = 'created_at.asc'}) async {
    int accountid = prefs.getInt('accountid');
    if (accountid == null) return null;
    VideoListModel model;
    String param =
        '/account/$accountid/rated/tv?api_key=$_apikey&language=$language&session_id=$session&sort_by=$sortBy&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<bool> rateTVShow(int tvid, double rating) async {
    bool result = false;
    String param = '/tv/$tvid/rating?api_key=$_apikey';
    int accountid = prefs.getInt('accountid');
    if (accountid == null)
      //param += '&guest_session_id=$session';
      return false;
    else
      param += '&session_id=$session';
    FormData formData = new FormData.fromMap({"value": rating});
    var r = await _http.request(param, method: "POST", data: formData);
    if (r != null) {
      var jsonobject = json.decode(r);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }

  static Future<bool> rateMovie(int movieid, double rating) async {
    bool result = false;
    String param = '/movie/$movieid/rating?api_key=$_apikey';
    int accountid = prefs.getInt('accountid');
    if (accountid == null)
      //param += '&guest_session_id=$session';
      return false;
    else
      param += '&session_id=$session';
    FormData formData = new FormData.fromMap({"value": rating});
    var r = await _http.request(param, method: "POST", data: formData);
    if (r != null) {
      var jsonobject = json.decode(r);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }

  static Future<bool> rateTVEpisode(
      int tvid, int seasonid, int episodeid, double rating) async {
    bool result = false;
    String param =
        '/tv/$tvid/season/$seasonid/episode/$episodeid/rating?api_key=$_apikey&session_id=$seasonid';
    var data = {"value": rating};
    var r = await _http.request(param, method: "POST", data: data);
    if (r != null) {
      var jsonobject = json.decode(r);
      if (jsonobject['status_code'] == 1) result = true;
    }
    return result;
  }



  static Future<VideoListResult> getLastMovies() async {
    VideoListResult model;
    String param = "/movie/latest?api_key=$_apikey&language=$language";
    var r = await _http.request(param);
    if (r != null) model = VideoListResult.fromJson(r);
    return model;
  }

  static Future<VideoListResult> getLastTVShows() async {
    VideoListResult model;
    String param = "/tv/latest?api_key=$_apikey&language=$language";
    var r = await _http.request(param);
    if (r != null) model = VideoListResult.fromJson(r);
    return model;
  }

  static Future<VideoListModel> getPopularMovies({int page = 1}) async {
    VideoListModel model;
    String param =
        "/movie/popular?api_key=$_apikey&language=$language&page=$page";
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getPopularTVShows({int page = 1}) async {
    VideoListModel model;
    String param = "/tv/popular?api_key=$_apikey&language=$language&page=$page";
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }



  ///Get a list of upcoming movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  static Future<VideoListModel> getMovieUpComing({int page = 1}) async {
    VideoListModel model;
    String param =
        '/movie/upcoming?api_key=$_apikey&language=$language&page=$page&region=$region';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  ///Get a list of movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  static Future<VideoListModel> getNowPlayingMovie({int page = 1}) async {
    VideoListModel model;
    String param =
        '/movie/now_playing?api_key=$_apikey&language=$language&page=$page&region=$region';
    var r = await _http.request(param, cached: true);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getRecommendationsMovie(int movieid,
      {int page = 1}) async {
    VideoListModel model;
    String param =
        '/movie/$movieid/recommendations?api_key=$_apikey&language=$language&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getRecommendationsTV(int tvid,
      {int page = 1}) async {
    VideoListModel model;
    String param =
        '/tv/$tvid/recommendations?api_key=$_apikey&language=$language&page=$page';
    var r = await _http.request(param);
    if (r != null) model = VideoListModel(r);
    return model;
  }




  ///Get a list of shows that are currently on the air.This query looks for any TV show that has an episode with an air date in the next 7 days.
  static Future<VideoListModel> getTVOnTheAir({int page = 1}) async {
    VideoListModel model;
    String param =
        '/tv/on_the_air?api_key=$_apikey&language=$language&page=$page';
    var r = await _http.request(param, cached: true);
    if (r != null) model = VideoListModel(r);
    return model;
  }




  ///Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the certifications list method.Discover also supports a nice list of sort options. See below for all of the available options.Please note, when using certification \ certification.lte you must also specify certification_country. These two parameters work together in order to filter the results. You can only filter results with the countries we have added to our certifications list.If you specify the region parameter, the regional release date will be used instead of the primary release date. The date returned will be the first date based on your query (ie. if a with_release_type is specified). It's important to note the order of the release types that are used. Specifying "2|3" would return the limited theatrical release date as opposed to "3|2" which would return the theatrical date.Also note that a number of filters support being comma (,) or pipe (|) separated. Comma's are treated like an AND and query while pipe's are an OR.
  static Future<VideoListModel> getMovieDiscover(
      {String lan,
        String region,
        String sortBy,
        String certificationCountry,
        String certification,
        String certificationLte,
        bool includeVideo = false,
        int page = 1,
        int primaryReleaseYear,
        String primaryReleaseDateGte,
        String primaryReleaseDateLte,
        String releaseDateGte,
        String releaseDateLte,
        int voteCountGte,
        int voteCountLte,
        double voteAverageGte,
        double voteAverageLte,
        String withCast,
        String withCrew,
        String withCompanies,
        String withGenres,
        String withKeywords,
        String withPeople,
        int year,
        String withoutGenres,
        int withRuntimeGte,
        int withRuntimeLte,
        int withReleaseType,
        String withOriginalLanguage,
        String withoutKeywords}) async {
    VideoListModel model;
    String param =
        '/discover/movie?api_key=$_apikey&page=$page&language=$language';
    param += sortBy == null ? '' : '&sort_by=$sortBy';
    param += certification == null ? '' : '&certification=$certification';
    param += certificationCountry == null
        ? ''
        : '&certification_country=$certificationCountry';
    param +=
    certificationLte == null ? '' : '&certification.lte=$certificationLte';
    param += includeAdult == null ? '' : '&include_adult=$includeAdult';
    param += includeVideo == null ? '' : '&include_video=$includeVideo';
    param += primaryReleaseYear == null
        ? ''
        : '&primary_release_year=$primaryReleaseYear';
    param += primaryReleaseDateGte == null
        ? ''
        : '&primary_release_date.gte=$primaryReleaseDateGte';
    param += primaryReleaseDateLte == null
        ? ''
        : '&primary_release_date.lte=$primaryReleaseDateLte';
    param += releaseDateGte == null ? '' : '&release_date.gte=$releaseDateGte';
    param += releaseDateLte == null ? '' : '&release_date.lte=$releaseDateLte';
    param += voteAverageGte == null ? '' : '&vote_average.gte=$voteAverageGte';
    param += voteCountGte == null ? '' : '&vote_count.gte=$voteCountGte';
    param += voteCountLte == null ? '' : '&vote_count.lte=$voteCountLte';
    param += voteAverageLte == null ? '' : '&vote_average.lte=$voteAverageLte';
    param += withCast == null ? '' : '&with_cast=$withCast';
    param += withCrew == null ? '' : '&with_crew=$withCrew';
    param += withCompanies == null ? '' : '&with_companies=$withCompanies';
    param += withGenres == null ? '' : '&with_genres=$withGenres';
    param += withKeywords == null ? '' : '&with_keywords=$withKeywords';
    param += withPeople == null ? '' : '&with_people=$withPeople';
    param += year == null ? '' : '&year=$year';
    param += withoutGenres == null ? '' : '&without_genres=$withoutGenres';
    param += withRuntimeGte == null ? '' : '&with_runtime.gte=$withRuntimeGte';
    param += withRuntimeLte == null ? '' : '&with_runtime.lte=$withRuntimeLte';
    param +=
    withReleaseType == null ? '' : '&with_release_type=$withReleaseType';
    param += withOriginalLanguage == null
        ? ''
        : '&with_original_language=$withOriginalLanguage';
    param +=
    withoutKeywords == null ? '' : '&without_keywords=$withoutKeywords';
    var r = await _http.request(param, cached: true);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<VideoListModel> getTVDiscover(
      {String lan,
        int page,
        String sortBy,
        String airDateGte,
        String airDateLte,
        String firstAirDateGte,
        String firstAirDateLte,
        String timezone = 'America/New_York',
        String withGenres,
        String withKeywords}) async {
    VideoListModel model;
    String param =
        '/discover/tv?api_key=$_apikey&page=$page&timezone=$timezone&language=$language';
    param += sortBy == null ? '' : '&sort_by=$sortBy';
    param += airDateGte == null ? '' : '&air_ate.gte=$airDateGte';
    param += airDateLte == null ? '' : '&air_ate.lte=$airDateLte';
    param +=
    firstAirDateGte == null ? '' : '&first_air_ate.gte=$firstAirDateGte';
    param +=
    firstAirDateLte == null ? '' : '&first_air_ate.lte=$firstAirDateLte';
    param += withGenres == null ? '' : '&with_genres=$withGenres';
    param += withKeywords == null ? '' : '&with_keywords=$withKeywords';
    var r = await _http.request(param, cached: true);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  ///Search for movies.
  static Future<VideoListModel> searchMovie(String keyword,
      {String lan,
        int page = 1,
        String region,
        int year,
        int primaryReleaseYear}) async {
    VideoListModel model;
    String param =
        '/search/movie?api_key=$_apikey&page=$page&include_adult=$includeAdult';
    param += region == null ? '' : '&region=$region';
    param += year == null ? '' : '&year=$year';
    param += primaryReleaseYear == null
        ? ''
        : '&primary_release_year=$primaryReleaseYear';
    var r = _http.request(param, cached: true);
    if (r != null) model = VideoListModel(r);
    return model;
  }

  static Future<SearchResultModel> searchMulit(String query,
      {int page = 1, bool searchadult = true}) async {
    SearchResultModel model;
    String param =
        '/search/multi?api_key=$_apikey&query=$query&page=$page&include_adult=$includeAdult&language=$language';
    var r = await _http.request(param, cached: true);
    if (r != null) model = SearchResultModel(r);
    return model;
  }

  static Future<SearchResultModel> getTrending(MediaType type, TimeWindow time,
      {int page = 1}) async {
    SearchResultModel model;
    String param =
        '/trending/${type.toString().split('.').last}/${time.toString().split('.').last}?api_key=$_apikey&language=$language&page=$page';
    var r = await _http.request(param,
        cached: true, cacheDuration: Duration(hours: 1));
    if (r != null) model = SearchResultModel(r);
    return model;
  }

}
