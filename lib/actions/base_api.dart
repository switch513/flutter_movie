import 'package:movie/actions/request.dart';
import 'package:movie/models/base_api_model/base_movie_model.dart';
import 'package:movie/models/base_api_model/base_tv_show.dart';

class BaseApi {
  static Request _http = Request('https://www.fluttermovie.top/api');

  static Future<BaseMovieModel> getMovies(
      {int page = 1, int pageSize = 20}) async {
    BaseMovieModel model;
    String _url = '/Movies?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(days: 0));
    if (r != null) model = BaseMovieModel(r);
    return model;
  }

  static Future<BaseTvShowModel> getTvShows(
      {int page = 1, int pageSize = 20}) async {
    BaseTvShowModel model;
    String _url = '/TvShows?page=$page&pageSize=$pageSize';
    var r = await _http.request(_url,
        cached: true, cacheDuration: Duration(days: 0));
    if (r != null) model = BaseTvShowModel(r);
    return model;
  }
}