import 'package:flutter/material.dart';

class HeroAnimation {
  getExpandedPage(context, id) {
    return Scaffold(
      body: Hero(
        tag: id,
        child: Material(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.teal,
            child: Text(
              id,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
