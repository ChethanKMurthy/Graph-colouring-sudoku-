import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';
import 'package:sudoku_graph_colouring/widgets/sudoku_node_widget.dart';

class SudokuGridWidget extends StatefulWidget {
  final List<List<SudokuNodeClass>> sudokuNodesClasses;
  final SudokuSizes sudokuSizes;
  final ValueNotifier colorChangeNotifier;
  const SudokuGridWidget(
      {required this.sudokuNodesClasses,
      required this.sudokuSizes,
      required this.colorChangeNotifier,
      Key? key})
      : super(key: key);

  @override
  State<SudokuGridWidget> createState() => _SudokuGridWidgetState();
}

class _SudokuGridWidgetState extends State<SudokuGridWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sudokuNodes = convertTo1D(widget.sudokuNodesClasses);
    final size = int.parse(sudokuSizesMap[widget.sudokuSizes]!
        .substring(0, sudokuSizesMap[widget.sudokuSizes]!.indexOf('x')));

    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: size),
        itemCount: pow(size, 2).toInt(),
        itemBuilder: ((context, index) {
          return SudokuNodeWidget(
              node: sudokuNodes[index],
              sudokuSize: widget.sudokuSizes,
              colorChangeNotifier: widget.colorChangeNotifier);
        }));
  }
}
