/*
 * Author : Julien Scholz
 * https://github.com/Pikaju/PasswordStrength
 */
import 'dart:math';

double estimateBruteforceStrength(String password) {
  if (password.isEmpty) return 0.0;

  // Check which types of characters are used and create an opinionated bonus.
  double charsetBonus;
  if (RegExp(r'^[a-z]*$').hasMatch(password)) {
    charsetBonus = 1.0;
  } else if (RegExp(r'^[a-z0-9]*$').hasMatch(password)) {
    charsetBonus = 1.2;
  } else if (RegExp(r'^[a-zA-Z]*$').hasMatch(password)) {
    charsetBonus = 1.2;
  } else if (password.length == 8 && RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password)) {
    charsetBonus = 1.3;
  } else if (password.length > 8 && RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password)) {
    charsetBonus = 1.8;
  }

  final logisticFunction = (double x) {
    return 1.0 / (1.0 + exp(-x));
  };

  final curve = (double x) {
    return logisticFunction((x / 3.0) - 4.0);
  };

  return curve(password.length * charsetBonus);
}
