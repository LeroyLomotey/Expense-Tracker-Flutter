import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 2)
class Transaction {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.type,
      required this.date});

  static String getDate(DateTime date) {
    String newDate = '${date.toString().substring(8, 10)} '; //ex: 10
    switch (date.toString().substring(5, 7)) {
      //ex: 10 Jan
      case '01':
        newDate += 'Jan';
        break;
      case '02':
        newDate += 'Feb';
        break;
      case '03':
        newDate += 'Mar';
        break;
      case '04':
        newDate += 'Apr';
        break;
      case '05':
        newDate += 'May';
        break;
      case '06':
        newDate += 'Jun';
        break;
      case '07':
        newDate += 'Jul';
        break;
      case '08':
        newDate += 'Aug';
        break;
      case '09':
        newDate += 'Sep';
        break;
      case '10':
        newDate += 'Oct';
        break;
      case '11':
        newDate += 'Nov';
        break;
      case '12':
        newDate += 'Dec';
    }
    newDate = '$newDate, ${date.toString().substring(0, 4)}'; //ex 10 Jan 2023
    return newDate;
  }

  static String getIcon(String type) {
    switch (type) {
      case 'Food':
        return './assets/icons/food.png';
      case 'Education':
        return './assets/icons/education.png';
      case 'Entertainment':
        return './assets/icons/entertainment.png';
      case 'Gift':
        return './assets/icons/gift.png';
      case 'Healthcare':
        return './assets/icons/healthcare.png';
      case 'Housing':
        return './assets/icons/housing.png';
      case 'Income':
        return './assets/icons/income.png';
      case 'Transportation':
        return './assets/icons/transportation.png';
      default:
        return './assets/icons/miscellanous.png';
    }
  }
}
