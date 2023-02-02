<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
<div align="center">

# Boarding Pass Scanner
  
[![BUILD](https://img.shields.io/badge/Build-Passing-<COLOR>.svg)](https://github.com/Dinesh-Dlanzer/boarding_pass_scanner)
[![dlanzer](https://img.shields.io/badge/Follow_me-Dlanzer-orange.svg?&logo=youtube&logoColor=orange)](https://www.youtube.com/@dlanzer)
[![Repo Status](https://img.shields.io/badge/RepoStatus-Active-blueviolet.svg)](https://github.com/Dinesh-Dlanzer/boarding_pass_scanner)
[![MIT license](https://img.shields.io/badge/License-MIT-red.svg)](https://github.com/Dinesh-Dlanzer/boarding_pass_scanner)
[![Flutter](https://img.shields.io/badge/_Flutter_-Package-grey.svg?&logo=Flutter&logoColor=white&labelColor=blue)](https://github.com/Dinesh-Dlanzer/boarding_pass_scanner)
</div>

## Description
A plugin for scan & get airline boarding pass data, the plugin support on both Android and iOS.

## Getting started

Add the following to your pubspec.yaml file.

```yaml
dependencies:
  boarding_pass_scanner: ^1.0.0
```

Import the package.
```dart
import 'package:boarding_pass_scanner/boarding_pass_scanner.dart';
```

## Usage

The easiest way to use this library just call scanBoardingPass function with list of airline you need allow

```dart
var scan = await BoardingPass.scanBoardingPass(BoardingPass.airlineList);
if (scan.boardingPass != null) {
    print(scan.boardingPass!.qrCodeData);
    print(scan.boardingPass!.firstName);
    print(scan.boardingPass!.lastName);
    print(scan.boardingPass!.customerName);
    print(scan.boardingPass!.pnrNo);
    print(scan.boardingPass!.airLineFromCode);
    print(scan.boardingPass!.airLineToCode);
    print(scan.boardingPass!.airLineFromAndToCode);
    print(scan.boardingPass!.airLineIATAAlphaNumericCode);
    print(scan.boardingPass!.airLineFlightNumericCode);
    print(scan.boardingPass!.airLineFlightNo);
    print(scan.boardingPass!.sequenceNo);
    print(scan.boardingPass!.eTicketNo);
}
print(scan.message);
```
## License

```
MIT License

Copyright (c) 2023 Dlanzer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
```

## Additional information

To know more awesome content about Flutter., 

Visit my channel 👉 : [Dlanzer](https://www.youtube.com/@dlanzer)