import 'package:flutter/material.dart';

const Map<int, Color> numberToColorMap = {
  0: Colors.white,
  1: Colors.red,
  2: Colors.blue,
  3: Colors.green,
  4: Colors.yellow,
  5: Colors.purple,
  6: Colors.orange,
  7: Colors.pink,
  8: Colors.teal,
  9: Colors.brown,
  10: Colors.redAccent,
  11: Colors.blueAccent,
  12: Colors.greenAccent,
  13: Colors.deepOrange,
  14: Colors.deepPurpleAccent,
  15: Colors.grey,
  16: Colors.indigoAccent
};

final Map<Color, int> colorToNumberMap = {
  Colors.white: 0,
  Colors.red: 1,
  Colors.blue: 2,
  Colors.green: 3,
  Colors.yellow: 4,
  Colors.purple: 5,
  Colors.orange: 6,
  Colors.pink: 7,
  Colors.teal: 8,
  Colors.brown: 9,
  Colors.redAccent: 10,
  Colors.blueAccent: 11,
  Colors.greenAccent: 12,
  Colors.deepOrange: 13,
  Colors.deepPurpleAccent: 14,
  Colors.grey: 15,
  Colors.indigoAccent: 16
};

const notColoured = Colors.white;

enum SudokuSizes {
  fourByFour,
  nineByNine,
  sixteenBySixteen,
}

final Map<SudokuSizes, String> sudokuSizesMap = {
  SudokuSizes.fourByFour: "4x4",
  SudokuSizes.nineByNine: "9x9",
  SudokuSizes.sixteenBySixteen: "16x16"
};

final Map<String, SudokuSizes> inverseSudokuSizesMap = {
  "4x4": SudokuSizes.fourByFour,
  "9x9": SudokuSizes.nineByNine,
  "16x16": SudokuSizes.sixteenBySixteen
};
