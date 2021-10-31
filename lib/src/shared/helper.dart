import 'dart:math';

double getDiagonal(num sideA, num sideB) {
  final sizeLength = pow(sideA, 2) + pow(sideB, 2);
  return sqrt(sizeLength);
}
