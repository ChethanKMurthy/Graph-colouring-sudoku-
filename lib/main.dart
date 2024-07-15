import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/fetch_puzzle.dart';
import 'package:sudoku_graph_colouring/functions/solve_sudoku.dart';
import 'package:sudoku_graph_colouring/widgets/sudoku_grid_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: SodukuSolver(),
  ));
}

class SodukuSolver extends StatefulWidget {
  const SodukuSolver({Key? key}) : super(key: key);

  @override
  State<SodukuSolver> createState() => _SodukuSolverState();
}

class _SodukuSolverState extends State<SodukuSolver> {
  late List<List<SudokuNodeClass>> sudokuNodesClasses;
  late List<List<SudokuNodeClass>> sudokuNodesClassesQuestion;
  ValueNotifier<bool> showColor = ValueNotifier(false);
  ValueNotifier<bool> solved = ValueNotifier(false);
  SudokuSizes dropDownValue = SudokuSizes.fourByFour;

  @override
  void initState() {
    super.initState();
    sudokuNodesClasses = fetchSudokuPuzzle(dropDownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Soduku Solver"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.height / 1.4,
                  child: ValueListenableBuilder(
                      valueListenable: solved,
                      builder: (context, value, child) {
                        return SudokuGridWidget(
                            sudokuNodesClasses: sudokuNodesClasses,
                            sudokuSizes: dropDownValue,
                            colorChangeNotifier: showColor);
                      }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          // style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.amber[300],
                          borderRadius: BorderRadius.circular(10),
                          underline: const Text(""),
                          isDense: true,
                          value: sudokuSizesMap[dropDownValue],
                          selectedItemBuilder: (context) {
                            return SudokuSizes.values
                                .map((e) => DropdownMenuItem<String>(
                                    value: sudokuSizesMap[e],
                                    child: Text(
                                      sudokuSizesMap[e]!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                                .toList();
                          },
                          items: SudokuSizes.values
                              .map((e) => DropdownMenuItem<String>(
                                  value: sudokuSizesMap[e],
                                  child: Text(
                                    sudokuSizesMap[e]!,
                                    style: const TextStyle(color: Colors.black),
                                  )))
                              .toList(),
                          onChanged: (value) async {
                            dropDownValue = inverseSudokuSizesMap[value]!;
                            solved.value = false;
                            setState(() {
                              sudokuNodesClasses =
                                  fetchSudokuPuzzle(dropDownValue);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      onPressed: () {
                        showColor.value = !showColor.value;
                      },
                      child: ValueListenableBuilder(
                          valueListenable: showColor,
                          builder: (context, value, child) {
                            return Text(
                                value as bool ? "Hide Colors" : "Show Colors",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600));
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      onPressed: () {
                        if (!solved.value) {
                          // sudokuNodesClassesQuestion =
                          // List.from(sudokuNodesClasses);
                          sudokuNodesClassesQuestion = sudokuNodesClasses
                              .map((e) => e
                                  .map((e) =>
                                      SudokuNodeClass.clone(sudokuNodeClass: e))
                                  .toList())
                              .toList();
                          // final value =
                          solveSudoku(sudokuNodesClasses).then((value) {
                            if (value == null) {
                              showIncorrectGridDialog(context,
                                  "Sudoku is taking too much time to solve!!");
                            } else if (value) {
                              solved.value = true;
                            } else {
                              showIncorrectGridDialog(
                                  context, "Incorrect Sudoku");
                            }
                          });
                        } else {
                          sudokuNodesClasses = sudokuNodesClassesQuestion
                              .map((e) => e
                                  .map((e) =>
                                      SudokuNodeClass.clone(sudokuNodeClass: e))
                                  .toList())
                              .toList();
                          solved.value = false;
                        }
                      },
                      child: ValueListenableBuilder(
                          valueListenable: solved,
                          builder: (context, value, child) {
                            return Text(
                              value as bool ? "Show Question" : "Solve",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            );
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void showIncorrectGridDialog(final context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              sudokuNodesClasses =
                                  fetchSudokuPuzzle(dropDownValue);
                            });
                          },
                          child: const Text("Generate Another Sudoku")),
                    ],
                  ),
                ),
              ));
        });
  }
}
