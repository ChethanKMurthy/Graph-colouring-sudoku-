import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:sudoku_graph_colouring/functions/generate_adjacency_list.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';

Future<bool?> solveSudoku(
    List<List<SudokuNodeClass>> sudokuNodesClasses) async {
  final adjList = generateAdjacencyList(sudokuNodesClasses);
  final isValid = isValidSudoku(adjList);
  if (!isValid) return false;
  bool result = false;
  Map map = {};
  map['1'] = adjList;
  map['2'] = convertTo1D(sudokuNodesClasses);
  final value = await compute(colorise, map);
  result = value;
  return result;
}

bool colorise(Map<dynamic, dynamic> map) {
  Map<SudokuNodeClass, List<SudokuNodeClass>> adjacencyList = map["1"];
  List<SudokuNodeClass> nodes = map["2"];
  for (var node in nodes) {
    if (node.color == notColoured) {
      for (int colorNumber = 1;
          colorNumber <= sqrt(nodes.length);
          colorNumber++) {
        if (checkValidColor(
            adjacencyList, node, numberToColorMap[colorNumber]!)) {
          node.color = numberToColorMap[colorNumber]!;
          Map map = {};
          map['1'] = adjacencyList;
          map['2'] = nodes;
          if (colorise(map)) return true;
          node.color = notColoured;
        }
      }
      return false;
    }
  }
  return true;
}

bool checkValidColor(final adjacencyList, final node, final color) {
  for (var neighbour in adjacencyList[node]!) {
    if (neighbour.color == color) {
      return false;
    }
  }
  return true;
}

bool isValidSudoku(Map<SudokuNodeClass, List<SudokuNodeClass>> adjacencyList) {
  for (final node in adjacencyList.keys) {
    for (final neighbour in adjacencyList[node]!) {
      if (node.color != notColoured) {
        if (neighbour.color == node.color) {
          return false;
        }
      }
    }
  }
  return true;
}
