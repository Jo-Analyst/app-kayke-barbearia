import 'package:app_kayke_barbearia/app/models/provision_of_services_model.dart';

class ProvisionOfServiceController {
  Future<List<Map<String, dynamic>>> getProvisionOfServicesByDate(
      String date) async {
    return await ProvisionOfService.findByDate(date);
  }
}
