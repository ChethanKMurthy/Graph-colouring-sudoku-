import 'package:flutter/material.dart';

class SudokuNodeClass {
  Color color;
  int boxNumber;
  int rowNumber;
  int columnNumber;
  SudokuNodeClass(
      {required this.color,
      required this.boxNumber,
      required this.rowNumber,
      required this.columnNumber});

  factory SudokuNodeClass.clone({required SudokuNodeClass sudokuNodeClass}) {
    return SudokuNodeClass(
        color: sudokuNodeClass.color,
        boxNumber: sudokuNodeClass.boxNumber,
        rowNumber: sudokuNodeClass.rowNumber,
        columnNumber: sudokuNodeClass.columnNumber);
  }
}
