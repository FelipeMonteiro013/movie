import 'package:movie/services/networking.dart';

const key = '8e78791c15cfd8266917d82339e5d0b5';
const api = 'https://api.themoviedb.org/3';
const language = 'pt-BR';

class MovieModel {
  getMovies(page) async {
    NetworkingData networkingData = NetworkingData(
        '$api/movie/popular?api_key=$key&language=$language&page=$page');
    var movies = await networkingData.getNetworkData();

    return movies;
  }

  searchMovie(query) async {
    NetworkingData networkingData = NetworkingData(
        '$api/search/movie?api_key=$key&language=$language&query=$query&include_adult=false');
    var movies = await networkingData.getNetworkData();
    return movies;
  }
}
