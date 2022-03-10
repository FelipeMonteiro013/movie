class Movie {
  late String title;
  late String poster;
  late String backdrop;
  late String overview;
  late double vote_average;
  late String release_date;

  Movie({
    required this.title,
    required this.poster,
    required this.backdrop,
    this.overview = '',
    this.release_date = '',
    required this.vote_average,
  });
}
