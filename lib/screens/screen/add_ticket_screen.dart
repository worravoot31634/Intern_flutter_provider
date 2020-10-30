import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/api/user_api/ticket_api.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/provider/add_ticket_provider.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';

class AddTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AddTicketScreen(),
    );
  }
}

class _AddTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddTicketProvider>(
        builder: (BuildContext context, states, Widget child) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                color: Colors.grey[100],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerApp(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add_box,
                          size: 22,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AutoSizeText(
                          "Add Ticket",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'avenir'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'Ticket name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: AutoSizeTextField(
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                                controller: states.ctrlTicketName,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff29404E), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'ex. checkin bug',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'Ticket url',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: AutoSizeTextField(
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                                controller: states.ctrlTicketUrl,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff29404E), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'ts.cubesofttech.com/',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'User create',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff29404E),
                                    width: 2.0,
                                    ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownSearch<User>(
                                items: (states.userList == null)
                                    ? [User(name: "wait")]
                                    : states.userList,
                                maxHeight: 300,
                                itemAsString: (User u) => u.name,
                                onChanged: (user){
                                  states.setUserCreate(user);
                                  log(user.id);
                                },
                                showSearchBox: true,
                                selectedItem: (states.defaultSelectedUserCreate == null) ? User(name: "wait") :  User(name: states.defaultSelectedUserCreate),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: AutoSizeTextField(
                                maxLines: 2,
                                style: TextStyle(fontSize: 18),
                                controller: states.ctrlDescription,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff29404E), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'description',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'Expected result',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: AutoSizeTextField(
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                                controller: states.ctrlExpectedResult,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff29404E), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'expected',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'Actual result',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: AutoSizeTextField(
                                maxLines: 1,
                                style: TextStyle(fontSize: 18),
                                controller: states.ctrlActualResult,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff29404E), width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'actual',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ),
                            SizedBox(height:10),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Text(
                                    'User assigned',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff29404E),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownSearch<User>(
                                items: (states.userList == null)
                                    ? [User(name: "wait")]
                                    : states.userList,
                                maxHeight: 300,
                                itemAsString: (User u) => u.name,
                                onChanged: (user){
                                  if(user == null){
                                    log('nullja');
                                  }
                                  states.setUserAssigned(user);
                                },
                                showClearButton: true,
                                showSearchBox: true,
                                selectedItem: (states.defaultSelectedUserAssigned == null) ? User(name:"") :  User(name: states.defaultSelectedUserAssigned),


                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: RaisedButton.icon(
                                      onPressed: () async {
                                        states.addFile();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      label: AutoSizeText(
                                        'Attachments',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      icon: Icon(
                                        Icons.attach_file,
                                        color: Colors.white,
                                      ),
                                      textColor: Colors.white,
                                      color: Color(0xff29404E),
                                    ),
                                  ),
                                  Container(
                                    child: (states.fileName == null)
                                        ? Text('   Choose your file')
                                        : Text('   ${states.fileName}'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Colors.grey,
                                      child: Container(
                                        child: AutoSizeText(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        states.addTicket();
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Colors.green[800],
                                      child: Container(
                                        child: AutoSizeText(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<File> writeToFile(Uint8List data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
