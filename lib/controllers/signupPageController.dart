import 'package:get/get.dart';
import 'package:hive/hive.dart';


class SignUpController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    var box = await Hive.openBox("mybox");
    var b = Hive.box("mybox");

    print(b.name);
    print(b.path);

    b.put("id", 1);
    b.put("name", "Tom");
    
  }

  @override
  void onReady(){
    super.onReady();
  }

  @override
  void onClose(){
    super.onClose();
  }
}
