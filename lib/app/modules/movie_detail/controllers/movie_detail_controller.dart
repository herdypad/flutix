import 'package:flutix/app/api/api_movies.dart';
import 'package:flutix/app/controllers/utility_controller.dart';
import 'package:flutix/app/models/credit_model.dart';
import 'package:flutix/app/models/movie_detail_model.dart';
import 'package:flutix/app/models/movie_model.dart';
import 'package:flutix/utils/app_utils.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController {
  final cUtility = Get.find<UtilityController>();

  Rx<MovieModel> movieData = const MovieModel().obs;
  Rx<MovieDetailModel> movieDetailData = const MovieDetailModel().obs;
  RxList<CreditModel> listCast = <CreditModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingCast = false.obs;
  RxBool isShowButton = false.obs;
  RxBool isMovieTopRated = false.obs;

  @override
  void onInit() {
    initData();
    getMovieDetail();
    getCredits();
    super.onInit();
  }

  Future<void> initData() async {
    final args = Get.arguments;
    if (args != null) {
      movieData.value = args['movie'];
      isMovieTopRated.value = args['is_movie_top_rated'] ?? false;
      checkMovie();
    }
  }

  void checkMovie() {
    if (isMovieTopRated.value) {
      isShowButton(false);
    } else {
      if (DateTime.parse(movieData.value.releaseDate)
          .isBefore(DateTime.now())) {
        isShowButton(true);
      } else {
        isShowButton(false);
      }
    }
  }

  Future<void> getMovieDetail() async {
    try {
      isLoading(true);

      final response = await ApiMovies.getMovieDetail(
        language: cUtility.appLanguage.value,
        movieModel: movieData.value,
      );

      movieDetailData.value = MovieDetailModel.fromJson(response);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      logSys(e.toString());
    }
  }

  Future<void> getCredits() async {
    try {
      isLoadingCast(true);

      final response = await ApiMovies.getCredits(movieId: movieData.value.id);
      final List<Map<String, dynamic>> data = response['cast'];

      listCast(RxList.from(data.map(CreditModel.fromJson)));

      listCast.sort((a, b) => b.popularity.compareTo(a.popularity));

      isLoadingCast(false);
    } catch (e) {
      isLoadingCast(false);
      logSys(e.toString());
    }
  }
}
