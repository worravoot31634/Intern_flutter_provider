
import 'package:intl/intl.dart';
import 'package:provider_flutter_application/api/user_api/holiday_api.dart';
import 'package:provider_flutter_application/model/holiday.dart';

class HolidayAction {
  Future<List<DateTime>> getAllDateHoliday() async {
    try {
      HolidayApi holidayApi = new HolidayApi();
      List<Holiday> holidayApiResponse = await holidayApi.getAllHoliday();
      //String -> DateTime -> String

      List<DateTime> holidayDate = new List<DateTime>();
      for (int index = 0; index < holidayApiResponse.length; index++) {
        DateTime startDate = convertStringToDate(holidayApiResponse[index].startDate);
        DateTime endDate = convertStringToDate(holidayApiResponse[index].endDate);
        //case startDate equal endDate then [add only startDate]
        if(startDate == endDate){
          holidayDate.add(startDate);
        }
        // case startDate not Equal endDate then [add range of startDate and endDate]
        else{
          List<DateTime> tempRangeOfDateList = getDaysInBetween(startDate,endDate);
          holidayDate.addAll(tempRangeOfDateList);
        }


        //log('num index : $index');
      }
      return holidayDate;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      print("can't load holiday list");
      return null;
    }
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
      //log(days.toString(),name: 'getDaysInBeteween');
    }
    return days;
  }

  DateTime convertStringToDate(String mdyFullString) {
    return DateFormat('MMM dd, yyyy').parse(mdyFullString);
  }

  String formattedDateToString(DateTime date) {
    return DateFormat("dd MMMM yyyy").format(date);
  }

// String changeFormatDate(String oldDateFormat) {
//   return formattedDateToString(convertStringToDate(oldDateFormat));
// }
}
