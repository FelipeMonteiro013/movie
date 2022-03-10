import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResumeScreen extends StatelessWidget {
  var movie;

  ResumeScreen({this.movie});

  @override
  Widget build(BuildContext context) {
    formatData() {
      String formattedDate =
          DateFormat('dd/MM/yyyy').format(DateTime.parse(movie.release_date));

      String newData = formattedDate;
      return newData;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text(movie.title),
          backgroundColor: Color(0XFFdb0000),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              fit: BoxFit.fill,
              height: 280,
              image: NetworkImage(movie.backdrop),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    avatar: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    label: Text(movie.vote_average.toString()),
                  ),
                  movie.release_date != ''
                      ? Chip(
                          avatar: Icon(Icons.calendar_month),
                          label: Text(formatData()),
                        )
                      : SizedBox()
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(movie.overview),
            ),
          ],
        ),
      ),
    );
  }
}
