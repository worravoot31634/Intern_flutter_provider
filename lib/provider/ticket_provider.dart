import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/api/user_api/ticket_api.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TicketProvider with ChangeNotifier{

  List<Ticket> _ticketListView;
  int _countItemListTicket;
  int _lenTicketList;
  bool _ticketScreenLoading = true;

  //refresh
  RefreshController _refreshController;

  TicketProvider(){
    init();
  }

  void init(){
    _refreshController = RefreshController(initialRefresh: false);
    _countItemListTicket = 10;
    getAllTicket();
    notifyListeners();
  }

  void getAllTicket() async {

    _ticketScreenLoading = true;
    notifyListeners();

    TicketApi ticketApi = new TicketApi();
    _ticketListView = await ticketApi.getAllTicket();
    _lenTicketList =_ticketListView.length;
    _ticketScreenLoading = false;
    log('load ticket finished' , name: 'ticketProvider');
    notifyListeners();
  }


  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (_countItemListTicket < _lenTicketList) {
      // get 2 list when refresh
      if (_countItemListTicket + 2 <= _lenTicketList) {
        _countItemListTicket += 2;
      } else if (_countItemListTicket + 1 <= _lenTicketList) {
        _countItemListTicket += 1;
      }
      log("countItemTicket: " + _countItemListTicket.toString());
      log("len: " + _lenTicketList.toString());

      _ticketListView.add((_ticketListView[_countItemListTicket]));
      _refreshController.loadComplete();
    } else {
      log("no data");
      _refreshController.loadNoData();
    }
    notifyListeners();

  }

  void onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _countItemListTicket = 10;
    log("refresh! count = " + countItemListTicket.toString());

    getAllTicket();

    refreshController.refreshCompleted();
    notifyListeners();
  }

  RefreshController get refreshController => _refreshController;

  bool get ticketScreenLoading => _ticketScreenLoading;

  int get lenTicketList => _lenTicketList;

  int get countItemListTicket => _countItemListTicket;

  List<Ticket> get ticketListView => _ticketListView;
}