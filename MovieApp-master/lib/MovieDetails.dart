import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'AppDatabase.dart';
import 'Movies.dart';

class MovieDetails extends StatefulWidget {

  @override
  _State createState() => _State();

  MovieResults movieDetails;
  MovieDetails.movieObject(this.movieDetails){
    this.movieDetails = movieDetails;
  }
}

class _State extends State<MovieDetails> {

  bool _isFavorite = false;
  AppDatabase database = AppDatabase();

  @override
  Widget build(BuildContext context) {
    // favorite = database.getFavoriteData();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Hero(
                  tag: widget.movieDetails.movieId,
                  child: Container(
                    height: 300,
                    padding: new EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w200' +
                                widget.movieDetails.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: new EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child:GestureDetector(
                    // padding: new EdgeInsets.fromLTRB(10, 50, 10, 0),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.movieDetails.originalTitle,
                          style: TextStyle(
                              fontSize: 22,
                              decoration: TextDecoration.none,
                              color: Colors.grey),
                          textAlign: TextAlign.start,
                        ),

                        new Spacer(),
                        Padding(
                          padding:  EdgeInsets.only(right: 16),
                          child: Container(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              onPressed: () { setState(() {
                                _isFavorite = !_isFavorite;
                                insertData(_isFavorite);
                              }); },
                              icon: Icon(Icons.favorite,
                                color: _isFavorite?Colors.red:Colors.grey ,),
                            ),
                          ),
                        ),
                      ],

                    ),
                    margin: EdgeInsets.only(left: 4),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 4, top: 32),),
                      RatingBar.builder(
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) =>
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                        itemSize: 18,
                        // onRatingUpdate: (_) {  },
                      ),
                      Padding(padding: EdgeInsets.only(left: 16),),
                      Text("${widget.movieDetails.voteAverage}k rating",
                        style: TextStyle(fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 4),),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 4),),
                      Icon(Icons.timer, color: Colors.grey, size: 16,),
                      Padding(padding: EdgeInsets.only(left: 4),),
                      Text("2h 41m",
                        style: TextStyle(fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.grey),
                      ),
                    ],
                  ),


                  Padding(padding: EdgeInsets.only(top: 8),),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 4),),
                      Icon(Icons.date_range, color: Colors.grey, size: 16,),
                      Padding(padding: EdgeInsets.only(left: 4),),
                      Text(widget.movieDetails.releaseDate,
                        style: TextStyle(fontSize: 14,
                            decoration: TextDecoration.none,
                            color: Colors.grey),
                      ),
                    ],
                  ),


                  Padding(padding: EdgeInsets.only(top: 8, left: 4),
                    child: Text(widget.movieDetails.overview,
                      style: TextStyle(fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.white70,),
                    ),),

                ],
              ),
            )
          ],
        ),
      ),
    );
    //throw UnimplementedError();
  }

  void insertData(bool isFavorite) {

    if(_isFavorite){
      widget.movieDetails.isFavorite = 1;
      database.insertMovie(widget.movieDetails);
    }else{
      widget.movieDetails.isFavorite = 0;
      database.insertMovie(widget.movieDetails);
    }
  }
}
