import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerApp() {
  return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 8,
          ),
          Row(
            children: [
              AutoSizeText(
                "Cube SoftTech",
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'ubuntu',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 5),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffc32c37),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: AutoSizeText(
                        '2',
                        maxLines: 1,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Image.asset(
            "assets/images/menu.png",
            height: 22,
          ),
        ],
  );
}
