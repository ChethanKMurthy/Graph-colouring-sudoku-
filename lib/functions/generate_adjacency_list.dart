import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';

Map<SudokuNodeClass, List<SudokuNodeClass>> generateAdjacencyList(List<List<SudokuNodeClass>> sudokuNodesClasses) {
  Map<SudokuNodeClass, List<SudokuNodeClass>> adjacencyList = {};
   for (int i = 0; i < sudokuNodesClasses.length; i++) {
      for (int j = 0; j < sudokuNodesClasses[i].length; j++) { 
        adjacencyList[sudokuNodesClasses[i][j]] = [];
        SudokuNodeClass node = sudokuNodesClasses[i][j];
        for(int k=0; k<sudokuNodesClasses.length; k++){
          for(int l=0; l<sudokuNodesClasses[k].length; l++){
            if(k == i && l == j){
              continue;
            }
            else if (node.boxNumber == sudokuNodesClasses[k][l].boxNumber || 
            node.rowNumber == sudokuNodesClasses[k][l].rowNumber || 
            node.columnNumber == sudokuNodesClasses[k][l].columnNumber){
              adjacencyList[node]!.add(sudokuNodesClasses[k][l]);
            }
          }
        }

      }
    }
    return adjacencyList;
}


