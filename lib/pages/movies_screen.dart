import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/pages/resume_screen.dart';
import 'package:movie/services/movies.dart';

class MoviesScreen extends StatefulWidget {
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Movie> movies = [];
  int page = 1;
  String search = '';

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    var moviesData = await MovieModel().getMovies(page);

    for (var movie in moviesData['results']) {
      setState(
        () {
          movies.add(
            Movie(
              title: movie['title'],
              poster:
                  'https://image.tmdb.org/t/p/w220_and_h330_face${movie['poster_path']}',
              backdrop:
                  'https://image.tmdb.org/t/p/w220_and_h330_face${movie['backdrop_path']}',
              overview: movie['overview'],
              release_date: movie!['release_date'],
              vote_average: movie['vote_average'].toDouble(),
            ),
          );
        },
      );
    }
  }

  void searchMovie(query) async {
    var moviesData = await MovieModel().searchMovie(query);
    setState(() {
      movies = [];
    });
    for (var movie in moviesData['results']) {
      inspect(movie);
      setState(
        () {
          movies.add(
            Movie(
              title: movie['title'],
              poster: movie['poster_path'] != null
                  ? 'https://image.tmdb.org/t/p/w220_and_h330_face${movie['poster_path']}'
                  : 'https://neilpatel.com/wp-content/uploads/2019/05/ilustracao-sobre-o-error-404-not-found.jpeg',
              backdrop: movie['backdrop_path'] != null
                  ? 'https://image.tmdb.org/t/p/w220_and_h330_face${movie['backdrop_path']}'
                  : 'https://media.istockphoto.com/vectors/error-page-or-file-not-found-icon-vector-id924949200?k=20&m=924949200&s=170667a&w=0&h=-g01ME1udkojlHCZeoa1UnMkWZZppdIFHEKk6wMvxrs=',
              overview: movie['overview'],
              release_date:
                  movie['release_date'] == null ? '' : movie['release_date'],
              vote_average: movie['vote_average'].toDouble(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Filmes'),
        backgroundColor: const Color(0XFFdb0000),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            FocusManager.instance.primaryFocus?.unfocus();
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent / 2) {
              setState(() {
                page++;
                getMovies();
              });
            }
            return true;
          },
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  label: Text('Pesquisar'),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                  if (value == '') {
                    setState(() {
                      movies = [];
                      search = '';
                    });
                    getMovies();
                  } else if (value.length > 0 && value[0] != ' ') {
                    searchMovie(value);
                  }
                },
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.to(
                          ResumeScreen(
                            movie: movies[index],
                          ),
                        ),
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(movies[index].poster),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
