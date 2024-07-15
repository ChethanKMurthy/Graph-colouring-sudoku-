import 'dart:math';

import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';

List<SudokuNodeClass> convertTo1D(
    List<List<SudokuNodeClass>> sudokuNodesClasses) {
  return [for (var row in sudokuNodesClasses) ...row];
}

SudokuNodeClass? getNodeWithCoordinates(
    int row, int column, List<List<SudokuNodeClass>> sudokuNodesClasses) {
  for (final i in sudokuNodesClasses) {
    for (final j in i) {
      if (j.rowNumber == row && j.columnNumber == column) {
        return j;
      }
    }
  }
  return null;
}

bool isBorderNode(SudokuNodeClass node, int sudokuSize){
  if(node.rowNumber == 0 || node.rowNumber == sudokuSize-1 || node.columnNumber == 0 || node.columnNumber == sudokuSize-1){
    return true;
  }
  return false;
}

String convertToAlphabetsAndNumbers(int n) {
  if (n >= 10) {
    return String.fromCharCode(n - 10 + 65);
  }
  return n.toString();
}

int getBoxNumber(int i, int j, int sudokuLength) {
  return (i ~/ sqrt(sudokuLength)) * (sqrt(sudokuLength)).toInt() +
      (j ~/ sqrt(sudokuLength));
}

List<List<SudokuNodeClass>> convertColorToSudoku(final sudokuPuzzle) {
  List<List<SudokuNodeClass>> res = [];
  for (int i = 0; i < sudokuPuzzle.length; i++) {
    List<SudokuNodeClass> row = [];
    for (int j = 0; j < sudokuPuzzle[i].length; j++) {
      row.add(SudokuNodeClass(
          color: sudokuPuzzle[i][j],
          boxNumber: getBoxNumber(i, j, sudokuPuzzle.length),
          rowNumber: i,
          columnNumber: j));
    }
    res.add(row);
  }
  return res;
}