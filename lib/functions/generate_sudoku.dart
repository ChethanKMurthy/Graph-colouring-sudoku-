import 'dart:math';

class Sudoku {
  late List<List<int>> mat;
  int N;

  late int SRN;

  int K;

  Sudoku(
    this.N,
    this.K,
  ) {
    SRN = sqrt(N.toDouble()).toInt();
    mat = List.generate(N, (i) => List.generate(N, (j) => 0));
  }

  bool fillValues() {
    fillDiagonal();

    final result = fillRemaining(0, SRN);
    if (!result) return false;

    removeKDigits();
    return true;
  }

  void fillDiagonal() {
    for (int i = 0; i < N; i = i + SRN) {
      fillBox(i, i);
    }
  }

  bool unUsedInBox(int rowStart, int colStart, int num) {
    for (int i = 0; i < SRN; i++) {
      for (int j = 0; j < SRN; j++) {
        if (mat[rowStart + i][colStart + j] == num) {
          return false;
        }
      }
    }
    return true;
  }

  void fillBox(int row, int col) {
    int num;
    for (int i = 0; i < SRN; i++) {
      for (int j = 0; j < SRN; j++) {
        do {
          num = randomGenerator(N);
        } while (!unUsedInBox(row, col, num));
        mat[row + i][col + j] = num;
      }
    }
  }

  int randomGenerator(int num) {
    return Random().nextInt(num) + 1;
  }

  bool checkIfSafe(int i, int j, int num) {
    return (unUsedInRow(i, num) &&
        unUsedInCol(j, num) &&
        unUsedInBox(i - i % SRN, j - j % SRN, num));
  }

  bool unUsedInRow(int i, int num) {
    for (int j = 0; j < N; j++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool unUsedInCol(int j, int num) {
    for (int i = 0; i < N; i++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool fillRemaining(int i, int j) {
    if (j >= N && i < N - 1) {
      i = i + 1;
      j = 0;
    }
    if (i >= N && j >= N) {
      return true;
    }
    if (i < SRN) {
      if (j < SRN) {
        j = SRN;
      }
    } else if (i < N - SRN) {
      if (j == (i ~/ SRN) * SRN) {
        j = j + SRN;
      }
    } else {
      if (j == N - SRN) {
        i = i + 1;
        j = 0;
        if (i >= N) {
          return true;
        }
      }
    }
    for (int num = 1; num <= N; num++) {
      if (checkIfSafe(i, j, num)) {
        mat[i][j] = num;
        if (fillRemaining(i, j + 1)) {
          return true;
        }
        mat[i][j] = 0;
      }
    }
    return false;
  }

  void removeKDigits() {
    for (final i in mat) {
      for (final j in i) {
        if (j == 0) return;
      }
    }
    int count = K;
    while (count != 0) {
      int cellId = randomGenerator(N * N) - 1;
      int i = (cellId ~/ N);
      int j = cellId % N;
      if (mat[i][j] != 0) {
        count--;
        mat[i][j] = 0;
      }
    }
  }

  void clear() {
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        mat[i][j] = 0;
      }
    }
  }
}

List<List<int>> generateSudoku(int n) {
  final double emptyCellsPercent = n == 4 ? 0.6 : 0.3;
  final sudoku = Sudoku(n, (emptyCellsPercent * (n * n)).toInt());
  while (!sudoku.fillValues()) {
    sudoku.clear();
  }
  return sudoku.mat;
}
