import 'package:app_kayke_barbearia/app/models/provision_of_services_model.dart';

class ProvisionOfServiceController {
  static Future<List<Map<String, dynamic>>> getProvisionOfServicesByDate(
      String date) async {
    return await ProvisionOfService.findByDate(date);
  }

  static deleteProvisionOfService(int id) async {
    await ProvisionOfService.delete(id);
  }
}
