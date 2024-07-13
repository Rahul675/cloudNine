import 'package:cloudnine/documents/DocumentsController.dart';
import 'package:get/get.dart';

class DocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentsController>(() => DocumentsController());
  }
}
