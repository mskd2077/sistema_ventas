import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart';
import '../models/product.dart';
import '../objectbox.g.dart'; // generated code

class ObjectBox {
  late final Store store;
  late final Box<Product> productBox;

  ObjectBox._create(this.store) {
    productBox = Box<Product>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${docsDir.path}/objectbox');
    return ObjectBox._create(store);
  }
}
