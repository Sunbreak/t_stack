import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t_stack/t_stack.dart';

void main() {
  const MethodChannel channel = MethodChannel('t_stack');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TStack.platformVersion, '42');
  });
}
