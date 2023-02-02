// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

library boarding_pass_scanner;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/foundation.dart';

/// A Airline class.
class AirLine {
  late String airLineName;
  late String airLineIATAAlphaNumericCode;
  String? airLineIATANumericCode;
  AirLine(
      {required this.airLineName,
      required this.airLineIATAAlphaNumericCode,
      this.airLineIATANumericCode});
}

/// A BoardingPass class.
class BoardingPass {
  late String qrCodeData;
  late String firstName;
  late String lastName;
  late String customerName;
  late String pnrNo;
  late String airLineFromCode;
  late String airLineToCode;
  late String airLineFromAndToCode;
  late String airLineIATAAlphaNumericCode;
  late String airLineIATANumericCode;
  late String airLineFlightNumericCode;
  late String airLineFlightNo;
  late String sequenceNo;
  late String eTicketNo; //When air line doesn't have IATA numeric code eTicketNo get empty string
  late String airLineName;

  BoardingPass(
      {required this.qrCodeData,
      required this.firstName,
      required this.lastName,
      required this.customerName,
      required this.pnrNo,
      required this.airLineFromCode,
      required this.airLineToCode,
      required this.airLineFromAndToCode,
      required this.airLineIATAAlphaNumericCode,
      required this.airLineIATANumericCode,
      required this.airLineFlightNumericCode,
      required this.airLineFlightNo,
      required this.sequenceNo,
      required this.eTicketNo,
      required this.airLineName});

  //This only for example
  static List<AirLine> airlineList = [
    AirLine(
        airLineName: "Air Vistara",
        airLineIATAAlphaNumericCode: "UK",
        airLineIATANumericCode: "228"),
    AirLine(
        airLineName: "Indigo",
        airLineIATAAlphaNumericCode: "6E",
        airLineIATANumericCode: "312"),
  ];
  //To scan the boarding pass & get data
  static Future<BoardingPassResult> scanBoardingPass(
      List<AirLine> airlineList) async {
    var aspectTolerance = 0.00;
    List name;
    String firstName = "";
    String lastName = "";
    String customerName = "";
    String pnrNo = "";
    String airLineFromCode = "";
    String airLineToCode = "";
    String airLineFromAndToCode = "";
    String airLineIATANumericCode = "";
    String airLineIATAAlphaNumericCode = "";
    String airLineFlightNo = "";
    String airLineFlightNumericCode = "";
    String sequenceNo = "";
    String eTicketNo = "";
    AirLine? matchedAirline;

    final possibleFormats = BarcodeFormat.values.toList()
      ..removeWhere((e) => e == BarcodeFormat.unknown);

    List<BarcodeFormat> selectedFormats = [...possibleFormats];
    final whitespaceRE = RegExp(r"\s+");
    String cleanupWhitespace(String input) =>
        input.replaceAll(whitespaceRE, " ");
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          restrictFormat: selectedFormats,
          android: AndroidOptions(
            aspectTolerance: aspectTolerance,
          ),
        ),
      );

      var qrCodeData = result.rawContent.toString();
      if (qrCodeData.isNotEmpty &&
          qrCodeData.length > 90 &&
          airlineList.isNotEmpty) {
        List<AirLine> matchedAirlineList = [];
        matchedAirlineList = airlineList
            .where((airline) =>
                qrCodeData.contains(airline.airLineIATAAlphaNumericCode))
            .toList();
        if (matchedAirlineList.isNotEmpty) {
          matchedAirline = matchedAirlineList.first;
          //name - Dinesh Veeran
          name = cleanupWhitespace(qrCodeData.substring(2, 22)).split("/");
          firstName = name[1];
          lastName = name[0];
          customerName = cleanupWhitespace("$firstName $lastName");
          //PNR - 6 char alpha numeric
          pnrNo = cleanupWhitespace(qrCodeData.substring(23, 29));
          //Form code - MMA
          airLineFromCode = cleanupWhitespace(qrCodeData.substring(30, 33));
          //To code - DEL
          airLineToCode = cleanupWhitespace(qrCodeData.substring(33, 36));
          //Form & To code - (MMA - DEL)
          airLineFromAndToCode = "$airLineFromCode - $airLineToCode";
          //Air Line IATA Alpha Numeric Code - 6E,UK
          airLineIATAAlphaNumericCode =
              cleanupWhitespace(qrCodeData.substring(36, 39));
          //Flight Numeric Code - 0827
          airLineFlightNumericCode =
              cleanupWhitespace(qrCodeData.substring(39, 44));
          //Flight number
          airLineFlightNo = cleanupWhitespace(
              "$airLineIATAAlphaNumericCode $airLineFlightNumericCode");
          //Sequence number
          sequenceNo = cleanupWhitespace(qrCodeData.substring(44, 57));

          var strArr =
              cleanupWhitespace(qrCodeData.substring(57, qrCodeData.length))
                  .split(" ");

          if (matchedAirline.airLineIATANumericCode != null &&
              matchedAirline.airLineIATANumericCode != "") {
            var eTicketDummy = strArr
                .where((element) =>
                    element.length > 13 &&
                    element.contains(matchedAirline!.airLineIATANumericCode!))
                .first;
            if (eTicketDummy != "") {
              var eTicketStartIndex =
                  eTicketDummy.indexOf(matchedAirline.airLineIATANumericCode!);
              eTicketNo = eTicketDummy.substring(
                  eTicketStartIndex, eTicketStartIndex + 13);
            }
          }

          return BoardingPassResult(
              BoardingPass(
                  qrCodeData: qrCodeData,
                  firstName: firstName,
                  lastName: lastName,
                  customerName: customerName,
                  pnrNo: pnrNo,
                  airLineFromCode: airLineFromCode,
                  airLineToCode: airLineToCode,
                  airLineFromAndToCode: airLineFromAndToCode,
                  airLineIATAAlphaNumericCode: airLineIATAAlphaNumericCode,
                  airLineIATANumericCode: airLineIATANumericCode,
                  airLineFlightNumericCode: airLineFlightNumericCode,
                  airLineFlightNo: airLineFlightNo,
                  sequenceNo: sequenceNo,
                  eTicketNo: eTicketNo,
                  airLineName: matchedAirline.airLineName),
              "Successfully get boarding pass details");
        } else {
          return BoardingPassResult(null, "Airline is not in the list");
        }
      } else {
        return BoardingPassResult(null, "Please scan air line boarding pass");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return BoardingPassResult(null, "");
  }
}

/// A BoardingPassResult class.
class BoardingPassResult {
  BoardingPass? boardingPass;
  late String message;
  BoardingPassResult(this.boardingPass, this.message);
}
