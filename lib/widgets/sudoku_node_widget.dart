import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';

class SudokuNodeWidget extends StatelessWidget {
  final SudokuNodeClass node;
  final SudokuSizes sudokuSize;
  final ValueNotifier colorChangeNotifier;
  const SudokuNodeWidget(
      {required this.node,
      required this.sudokuSize,
      required this.colorChangeNotifier,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: determineNodeWidths(node, sudokuSize), color: node.color),
        child: ValueListenableBuilder(
            valueListenable: colorChangeNotifier,
            builder: (context, value, child) {
              return Container(
                  color: value as bool ? node.color : Colors.white,
                  child: Center(
                    child: Text(
                      node.color == notColoured
                          ? ""
                          : convertToAlphabetsAndNumbers(
                              colorToNumberMap[node.color]!),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: determineFontSize(sudokuSize),
                          fontWeight: FontWeight.bold),
                    ),
                  ));
            }));
  }
}

Border determineNodeWidths(SudokuNodeClass node, SudokuSizes size) {
  int sudokuSize = int.parse(
      sudokuSizesMap[size]!.substring(0, sudokuSizesMap[size]!.indexOf('x')));
  double topWidth = 1;
  double bottomWidth = 1;
  double leftWidth = 1;
  double rightWidth = 1;
  double outerBoxSideWidth = 6;
  double innerBoxSideWidth = 4;

  if (node.rowNumber == 0) {
    topWidth = outerBoxSideWidth;
  }
  if (node.rowNumber == sudokuSize - 1) {
    bottomWidth = outerBoxSideWidth;
  }
  if (node.columnNumber == 0) {
    leftWidth = outerBoxSideWidth;
  }
  if (node.columnNumber == sudokuSize - 1) {
    rightWidth = outerBoxSideWidth;
  }
  if ((node.rowNumber + 1) % (sqrt(sudokuSize)) == 0 &&
      node.rowNumber != 0 &&
      node.rowNumber != sudokuSize - 1) {
    bottomWidth = innerBoxSideWidth;
  }
  if ((node.columnNumber + 1) % (sqrt(sudokuSize)) == 0 &&
      node.columnNumber != 0 &&
      node.columnNumber != sudokuSize - 1) {
    rightWidth = innerBoxSideWidth;
  }

  return Border(
      top: BorderSide(width: topWidth),
      bottom: BorderSide(width: bottomWidth),
      left: BorderSide(width: leftWidth),
      right: BorderSide(width: rightWidth));
}

double determineFontSize(SudokuSizes sudokuSize) {
  if (sudokuSize == SudokuSizes.fourByFour) {
    return 30;
  } else if (sudokuSize == SudokuSizes.nineByNine) {
    return 24;
  } else if (sudokuSize == SudokuSizes.nineByNine) {
    return 16;
  }
  return 20;
}
