import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/generate_sudoku.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';

List<List<SudokuNodeClass>> fetchSudokuPuzzle(SudokuSizes sudokuSize) {
  List<List<int>> sudoku = [];
  if (sudokuSize == SudokuSizes.fourByFour) {
    sudoku = generateSudoku(4);
  } else if (sudokuSize == SudokuSizes.nineByNine) {
    sudoku = generateSudoku(9);
  } else if (sudokuSize == SudokuSizes.sixteenBySixteen) {
    sudoku = generateSudoku(16);
  }

  return convertColorToSudoku(sudoku
      .map((e) => e.map((e) => numberToColorMap[e] ?? Colors.white).toList())
      .toList());
  // return convertForm(sudoku);
}

List<List<String>> convertForm(List<List<int>> sudoku) {
  return sudoku
      .map((e) => e.map((e) => convertToAlphabetsAndNumbers(e)).toList())
      .toList();
}
