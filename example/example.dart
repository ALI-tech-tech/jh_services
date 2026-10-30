import 'package:flutter/material.dart';
import 'package:jh_services/jh_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup the service locator with configurations
  await setupServiceLocator(
    sharedPrefsConfig: const SharedPrefsConfig(),
    connectivityConfig: const ConnectivityConfig(),
    networkConfig: const NetworkConfig(
      baseUrl: 'https://jsonplaceholder.typicode.com', // Demo mock API
    ),
  );

  runApp(const MyApp());
}

/// The example application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'jh_services Example',
      home: MyHomePage(),
    );
  }
}

/// The main interactive home page demonstrating jh_services.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final connectivityService = serviceLocator<ConnectivityService>();
  final sharedPrefsService = serviceLocator<SharedPrefsService>();
  final networkService = serviceLocator<NetworkService>();

  bool isConnected = false;
  String? apiData;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _fetchApiData();
  }

  Future<void> _checkConnectivity() async {
    isConnected = await connectivityService.isConnected();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _fetchApiData() async {
    try {
      final response = await networkService.get('/posts/1');
      if (response is Map<String, dynamic>) {
        apiData = response['title']?.toString();
      } else {
        apiData = response?.toString();
      }
    } on ServerException catch (e) {
      apiData = 'Error: ${e.errorModel.message}';
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _saveData() async {
    await sharedPrefsService.saveString('exampleKey', 'exampleValue');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved "exampleValue" to SharedPrefs!')),
      );
    }
  }

  void _getData() {
    final String? value = sharedPrefsService.getString('exampleKey');
    debugPrint('Saved value: $value');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Retrieved from storage: $value')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('jh_services Example')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Connectivity Status: ${isConnected ? "Connected" : "Not Connected"}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text('Save Data'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _getData,
                child: const Text('Retrieve Data'),
              ),
              const SizedBox(height: 20),
              Text(
                'API Data: ${apiData ?? "Loading..."}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
