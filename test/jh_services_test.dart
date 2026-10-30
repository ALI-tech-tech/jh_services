import 'package:flutter_test/flutter_test.dart';
import 'package:jh_services/jh_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPrefsService Tests', () {
    late SharedPrefsService prefsService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefsService = SharedPrefsService();
      await prefsService.init();
    });

    test('saveString and getString work properly', () async {
      expect(prefsService.getString('key_str'), isNull);
      final result = await prefsService.saveString('key_str', 'hello');
      expect(result, isTrue);
      expect(prefsService.getString('key_str'), equals('hello'));
    });

    test('saveInt, saveDouble, saveBool work properly', () async {
      await prefsService.saveInt('key_int', 42);
      await prefsService.saveDouble('key_double', 3.14);
      await prefsService.saveBool('key_bool', true);

      expect(prefsService.getInt('key_int'), equals(42));
      expect(prefsService.getDouble('key_double'), equals(3.14));
      expect(prefsService.getBool('key_bool'), isTrue);
    });

    test('saveDateTime and getDateTime work properly', () async {
      final now = DateTime.now();
      await prefsService.saveDateTime('time_key', now);

      final retrieved = prefsService.getDateTime('time_key');
      expect(retrieved, isNotNull);
      expect(retrieved!.toIso8601String(), equals(now.toIso8601String()));
    });

    test('toggleBool toggles value or initializes if missing', () async {
      final val1 = await prefsService.toggleBool('toggle_key');
      expect(val1, isTrue);

      final val2 = await prefsService.toggleBool('toggle_key');
      expect(val2, isFalse);
    });

    test('incrementOrInitInt and decrementInt operate correctly', () async {
      final val1 = await prefsService.incrementOrInitInt('counter', initialValue: 10, incrementBy: 5);
      expect(val1, equals(15));

      final val2 = await prefsService.decrementInt('counter', decrementBy: 3);
      expect(val2, equals(12));
    });

    test('saveJson and getJson work with nested maps', () async {
      final sample = {'name': 'Antigravity', 'count': 100, 'active': true};
      await prefsService.saveJson('json_key', sample);

      final retrieved = prefsService.getJson('json_key');
      expect(retrieved, equals(sample));
    });

    test('saveBulk and getBulk store and retrieve multiple items', () async {
      await prefsService.saveBulk({
        'b_str': 'value',
        'b_int': 99,
        'b_bool': false,
      });

      final bulk = prefsService.getBulk(['b_str', 'b_int', 'b_bool', 'missing']);
      expect(bulk['b_str'], equals('value'));
      expect(bulk['b_int'], equals(99));
      expect(bulk['b_bool'], isFalse);
      expect(bulk['missing'], isNull);
    });

    test('string list operations (add, remove, updateOrAppend)', () async {
      await prefsService.saveStringList('list_key', ['a', 'b']);
      await prefsService.addToStringList('list_key', 'c');
      expect(prefsService.getStringList('list_key'), equals(['a', 'b', 'c']));

      await prefsService.removeFromStringList('list_key', 'b');
      expect(prefsService.getStringList('list_key'), equals(['a', 'c']));

      await prefsService.updateOrAppendToStringList('list_key', ['c', 'd']);
      expect(prefsService.getStringList('list_key'), equals(['a', 'c', 'd']));
    });

    test('containsKey, remove and clear behave correctly', () async {
      await prefsService.saveString('temp', 'to_delete');
      expect(prefsService.containsKey('temp'), isTrue);

      await prefsService.remove('temp');
      expect(prefsService.containsKey('temp'), isFalse);

      await prefsService.saveString('a', '1');
      await prefsService.saveString('b', '2');
      expect(prefsService.getItemCount(), equals(2));

      await prefsService.clear();
      expect(prefsService.getItemCount(), equals(0));
    });
  });

  group('ErrorModel & ServerException Tests', () {
    test('ErrorModel.fromJson parses standard error map', () {
      final json = {'message': 'Invalid token', 'error': 'UNAUTHORIZED', 'statusCode': 401};
      final model = ErrorModel.fromJson(json);

      expect(model.message, equals('Invalid token'));
      expect(model.error, equals('UNAUTHORIZED'));
      expect(model.statusCode, equals(401));
      expect(model.toJson(), equals(json));
    });

    test('ErrorModel.fromJson safely handles null and string responses', () {
      final modelNull = ErrorModel.fromJson(null);
      expect(modelNull.message, isNotEmpty);
      expect(modelNull.statusCode, equals(0));

      final modelStr = ErrorModel.fromJson('Internal Server Error 500');
      expect(modelStr.message, equals('Internal Server Error 500'));
    });

    test('ServerException wraps ErrorModel properly', () {
      const errorModel = ErrorModel(
        message: 'Not found',
        error: 'NOT_FOUND',
        statusCode: 404,
      );
      const exception = ServerException(errorModel: errorModel);

      expect(exception.errorModel.message, equals('Not found'));
      expect(exception.toString(), contains('Not found'));
      expect(exception.toString(), contains('404'));
    });
  });

  group('NetworkConfig Tests', () {
    test('NetworkConfig has sensible default timeouts', () {
      const config = NetworkConfig(baseUrl: 'https://api.example.com');
      expect(config.baseUrl, equals('https://api.example.com'));
      expect(config.connectTimeout, equals(5000));
      expect(config.receiveTimeout, equals(3000));
      expect(config.defaultHeaders, isNull);
    });

    test('NetworkConfig accepts custom headers and timeouts', () {
      const config = NetworkConfig(
        baseUrl: 'https://api.custom.com',
        connectTimeout: 10000,
        receiveTimeout: 8000,
        defaultHeaders: {'Authorization': 'Bearer 123'},
      );
      expect(config.connectTimeout, equals(10000));
      expect(config.receiveTimeout, equals(8000));
      expect(config.defaultHeaders?['Authorization'], equals('Bearer 123'));
    });
  });

  group('Service Locator Initialization Tests', () {
    test('setupServiceLocator registers and initializes services without errors', () async {
      SharedPreferences.setMockInitialValues({});

      await setupServiceLocator(
        networkConfig: const NetworkConfig(baseUrl: 'https://test.example.com'),
      );

      expect(serviceLocator.isRegistered<SharedPrefsService>(), isTrue);
      expect(serviceLocator.isRegistered<NetworkService>(), isTrue);
      expect(serviceLocator.isRegistered<ConnectivityService>(), isTrue);
      expect(serviceLocator.isRegistered<ImagePickerService>(), isTrue);
      expect(serviceLocator.isRegistered<FilePickerService>(), isTrue);

      final networkService = serviceLocator<NetworkService>();
      expect(networkService.config.baseUrl, equals('https://test.example.com'));
    });
  });
}
