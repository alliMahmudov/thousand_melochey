import 'dart:developer';

import 'package:money_formatter/money_formatter.dart';
import 'package:flutter/services.dart';

class AppMoneyFormatter{

  AppMoneyFormatter._();


  static String shortFormatDouble(dynamic money) {
    double amount;
    bool isInteger = false;

    // Convert to double if given an integer
    if (money is int) {
      // No division, just convert to double
      amount = money.toDouble();
      isInteger = true; // Original was integer
    } else if (money is double) {
      // Keep doubles as they are
      amount = money;
      // Check if the double is actually a whole number
      isInteger = amount.truncateToDouble() == amount;
    } else {
      // Try to parse string or other types
      String moneyStr = money.toString();
      amount = double.tryParse(moneyStr) ?? 0.0;
      // If the string representation doesn't contain a decimal point, consider it an integer
      isInteger = !moneyStr.contains('.');
    }

    // Format settings based on whether the value is an integer or a decimal
    final MoneyFormatter formatter = MoneyFormatter(
        amount: amount.abs(),
        settings: MoneyFormatterSettings(
            symbol: 'UZS',
            thousandSeparator: ' ',
            decimalSeparator: '.',
            symbolAndNumberSeparator: ' ',
            fractionDigits: isInteger ? 0 : 2, // Use 0 decimals for integers, 2 for floats
            compactFormatType: CompactFormatType.short
        )
    );

    // Check for various thresholds and format accordingly
    if (amount.abs() >= 1000000000000) {
      return '${(amount.abs() / 1000000000000).toStringAsFixed(isInteger ? 0 : 1)}T';
    } else if (amount.abs() >= 1000000000) {
      return '${(amount.abs() / 1000000000).toStringAsFixed(isInteger ? 0 : 1)}B';
    } else if (amount.abs() >= 1000000) {
      return '${(amount.abs() / 1000000).toStringAsFixed(isInteger ? 0 : 1)}M';
    } else if (amount.abs() >= 1000) {
      return amount < 0 ? '-${formatter.output.nonSymbol}' : formatter.output.nonSymbol;
    } else {
      return amount < 0 ? '-${formatter.output.nonSymbol}' : formatter.output.nonSymbol;
    }
  }

  static String shortFormatString(String? money){
    if(money != null && money.isNotEmpty && double.tryParse(money) != null) {
      final double number = double.parse(money ?? "0").abs();
      final MoneyFormatter number1 = MoneyFormatter(
          amount: number ?? 0,
          settings: MoneyFormatterSettings(
              symbol: 'UZS',
              thousandSeparator: ' ',
              decimalSeparator: ' ',
              symbolAndNumberSeparator: ' ',
              fractionDigits: 0,
              compactFormatType: CompactFormatType.short
          )
      );

      return number < 0 ? '-${number1.output.compactNonSymbol}' : number1.output.compactNonSymbol;

    }
    return money ?? "";
  }


  static String longFormatDouble(dynamic money) {
    double amount;
    bool isInteger = false;

    // Convert to double if given an integer
    if (money is int) {
      // No division, just convert to double
      amount = money.toDouble();
      isInteger = true; // Original was integer
    } else if (money is double) {
      // Keep doubles as they are
      amount = money;
      // Check if the double is actually a whole number
      isInteger = amount.truncateToDouble() == amount;
    } else {
      // Try to parse string or other types
      String moneyStr = money.toString();
      amount = double.tryParse(moneyStr) ?? 0.0;
      // If the string representation doesn't contain a decimal point, consider it an integer
      isInteger = !moneyStr.contains('.');
    }

    // Ensure we're using the correct amount
    final MoneyFormatter number1 = MoneyFormatter(
        amount: amount.abs(),
        settings: MoneyFormatterSettings(
            symbol: 'UZS',
            thousandSeparator: ' ',
            decimalSeparator: '.',
            symbolAndNumberSeparator: ' ',
            fractionDigits: isInteger ? 0 : 2, // Use 0 decimals for integers, 2 for floats
            compactFormatType: CompactFormatType.short
        )
    );

    // If negative, add minus sign
    if(amount < 0){
      return "-${number1.output.nonSymbol}";
    }
    return number1.output.nonSymbol;
  }

  static String longFormatString(String? money){
    if(money != null && money.isNotEmpty && double.tryParse(money) != null) {
      final double number = double.parse(money ?? "0");
      final MoneyFormatter number1 = MoneyFormatter(
          amount: number ?? 0,
          settings: MoneyFormatterSettings(
              symbol: 'UZS',
              thousandSeparator: ' ',
              decimalSeparator: '.',
              symbolAndNumberSeparator: ' ',
              fractionDigits: number.truncateToDouble() == number ? 0 : 2,
              compactFormatType: CompactFormatType.short
          )
      );

      return number1.output.nonSymbol;

    }
    return money ?? "";
  }
}