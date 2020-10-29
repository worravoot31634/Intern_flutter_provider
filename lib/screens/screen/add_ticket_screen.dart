
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_flutter_application/api/user_api/file_upload_api.dart';
import 'package:provider_flutter_application/api/user_api/ticket_api.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';

class AddTicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AddTicketScreen(),
    );
  }
}

class _AddTicketScreen extends StatefulWidget {
  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<_AddTicketScreen> {
  final _ctrlTicketName = TextEditingController();
  final _ctrlTicketUrl = TextEditingController();
  final _ctrlDescription = TextEditingController();
  final _ctrlExpectedResult = TextEditingController();
  final _ctrlActualResult = TextEditingController();

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // String _fileName;
  // List<PlatformFile> _paths;
  // String _directoryPath;
  // String _extension;
  // bool _loadingPath = false;
  // bool _multiPick = false;
  // FileType _pickingType = FileType.any;
  // TextEditingController _controller = TextEditingController();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() => _extension = _controller.text);
  // }
  //
  // void _openFileExplorer() async {
  //   setState(() => _loadingPath = true);
  //   try {
  //     _directoryPath = null;
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: _multiPick,
  //       allowedExtensions: (_extension?.isNotEmpty ?? false)
  //           ? _extension?.replaceAll(' ', '')?.split(',')
  //           : null,
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _loadingPath = false;
  //     _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
  //   });
  // }
  // void _clearCachedFiles() {
  //   FilePicker.platform.clearTemporaryFiles().then((result) {
  //     _scaffoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         backgroundColor: result ? Colors.green : Colors.red,
  //         content: Text((result
  //             ? 'Temporary files removed with success.'
  //             : 'Failed to clean temporary files')),
  //       ),
  //     );
  //   });
  // }
  //
  // void _selectFolder() {
  //   FilePicker.platform.getDirectoryPath().then((value) {
  //     setState(() => _directoryPath = value);
  //   });
  // }

  FilePickerResult result;

  @override
  Widget build(BuildContext context) {
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
                          SizedBox(height:5),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: AutoSizeTextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                              controller: _ctrlTicketName,

                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff29404E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
                          SizedBox(height:5),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: AutoSizeTextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                              controller: _ctrlTicketUrl,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff29404E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'ts.cubesofttech.com/',
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
                                  'Description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: AutoSizeTextField(
                              maxLines: 2,
                              style: TextStyle(fontSize: 18),
                              controller: _ctrlDescription,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff29404E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'description',
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
                                  'Expected result',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: AutoSizeTextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                              controller: _ctrlExpectedResult,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff29404E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'expected',
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
                                  'Actual result',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:5),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: AutoSizeTextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                              controller: _ctrlActualResult,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff29404E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'actual',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.only(left:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: RaisedButton.icon(
                                    onPressed: () async{
                                      result = await FilePicker.platform.pickFiles();


                                      if(result != null) {
                                        PlatformFile file = result.files.first;
                                        File myFile = File(file.path);
                                        FileUploadApi fileUploadApi = new FileUploadApi();
                                        String status = await fileUploadApi.addImage(myFile, file.name);

                                      } else {
                                        // User canceled the picker
                                      }

                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    label: AutoSizeText('Attachments', style: TextStyle(color: Colors.white),
                                    ),
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                    textColor: Colors.white,
                                    color:Color(0xff29404E),
                                  ),
                                ),
                                Container(child: Text('   test.jpg'))
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: RaisedButton(
                                    onPressed: () {
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
                                    onPressed: () async{
                                      TicketApi ticketApi = new TicketApi();
                                      Ticket ticket = new Ticket();
                                      ticket.ticketName = _ctrlTicketName.text;
                                      ticket.userCreate = "worrawoot.s";
                                      ticket.ticketUrl = _ctrlTicketUrl.text;
                                      ticket.description = _ctrlDescription.text;
                                      ticket.expectedResult = _ctrlExpectedResult.text;
                                      ticket.actualResult = _ctrlActualResult.text;

                                      if(result != null) {
                                        PlatformFile file = result.files.first;
                                        File fileUpload = File(file.path);
                                        //FileUploadApi fileUploadApi = new FileUploadApi();
                                        ticketApi.addTicket(ticket, fileUpload);
                                      } else {
                                      // User canceled the picker
                                      }

                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0),
                                    ),
                                    color: Colors.green[800],
                                    /*Color.fromRGBO(15, 76, 129, 1),*/
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
  }
  Future<File> writeToFile(Uint8List data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }



}
