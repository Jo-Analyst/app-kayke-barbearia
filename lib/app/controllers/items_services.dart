import 'package:app_kayke_barbearia/app/models/items_service_model.dart';

class ItemsServicesController {
  static Future<List<Map<String, dynamic>>> getItemsProvisionOfServiceId(
      int provisionOfServiceId) async {
    return await ItemsService()
        .findByProvisionOfServiceId(provisionOfServiceId);
  }
}
