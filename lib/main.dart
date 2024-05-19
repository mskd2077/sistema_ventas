import 'package:flutter/material.dart';
import 'objectbox/objectbox.dart';
import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
  runApp(MyApp(objectBox: objectBox));
}

class MyApp extends StatelessWidget {
  final ObjectBox objectBox;

  MyApp({required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(objectBox: objectBox),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ObjectBox objectBox;

  MyHomePage({required this.objectBox});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory System'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: _addProduct,
            child: Text('Add Product'),
          ),
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }

  void _addProduct() {
    final name = _nameController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (name.isNotEmpty && quantity > 0 && price > 0.0) {
      final product = Product(name: name, quantity: quantity, price: price);
      widget.objectBox.productBox.put(product);
      setState(() {
        _nameController.clear();
        _quantityController.clear();
        _priceController.clear();
      });
    }
  }

  Widget _buildProductList() {
    final products = widget.objectBox.productBox.getAll();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('Quantity: ${product.quantity} - Price: \$${product.price}'),
        );
      },
    );
  }
}
