import 'package:eco_store_demo/services/core_service/dio_service/dio_service.dart';
import 'package:eco_store_demo/services/core_service/local_services/local_service.dart';

class BaseService with DioService, LocalService {
  BaseService() {
    provideServiceObject();
    openCartBox();
  }
}
