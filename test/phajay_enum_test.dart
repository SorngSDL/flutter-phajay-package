import 'package:flutter_phajay_package/flutter_phajay_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('bank type enum', () {
    expect(BankType.bcel.name, 'bcel');

    expect(BankType.ldb.name, 'ldb');
  });
}
