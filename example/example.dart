import 'package:flutter/material.dart';
import 'package:jh_services/jh_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup the service locator
  setupServiceLocator(
    sharedPrefsConfig: SharedPrefsConfig(),
    connectivityConfig: ConnectivityConfig(),
    networkConfig: NetworkConfig(
      baseUrl: "https://jsonplaceholder.typicode.com", // Fake API for example purposes
    ),
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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
    setState(() {});
  }

  Future<void> _fetchApiData() async {
    try {
      final response = await networkService.get('/posts/1'); // Fetching fake data
      apiData = response['title']; // Assuming the response has a 'title' field
    }on ServerException catch (e) {
      apiData = e.errorModel.message;
    }
    setState(() {});
  }

  Future<void> _saveData() async {
    await sharedPrefsService.saveString('exampleKey', 'exampleValue');
  }

  void _getData()  {
    String? value =  sharedPrefsService.getString('exampleKey');
    print('Saved value: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('jh_services Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connectivity Status: ${isConnected ? "Connected" : "Not Connected"}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Save Data'),
            ),
            ElevatedButton(
              onPressed: _getData,
              child: Text('Retrieve Data'),
            ),
            SizedBox(height: 20),
            Text('API Data: ${apiData ?? "Loading..."}'),
          ],
        ),
      ),
    );
  }
}
