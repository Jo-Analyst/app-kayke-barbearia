import 'package:app_kayke_barbearia/app/pages/service_form_page.dart';
import 'package:app_kayke_barbearia/app/providers/service_provider.dart';
import 'package:app_kayke_barbearia/app/template/add_service.dart';
import 'package:app_kayke_barbearia/app/utils/content_message.dart';
import 'package:app_kayke_barbearia/app/utils/convert_values.dart';
import 'package:app_kayke_barbearia/app/utils/dialog.dart';
import 'package:app_kayke_barbearia/app/utils/cache.dart';
import 'package:app_kayke_barbearia/app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ServiceListPage extends StatefulWidget {
  final bool itFromTheSalesScreen;
  const ServiceListPage({required this.itFromTheSalesScreen, super.key});

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  final searchController = TextEditingController();
  String search = "";
  bool isGranted = false, isLoading = true;

  List<Map<String, dynamic>> services = [];
  List<Map<String, dynamic>> servicesSelected = [];

  void showMessage(Widget content, Color? color) {
    Message.showMessage(context, content, color);
  }

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  void loadServices() async {
    final serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    await serviceProvider.load();
    setState(() {
      services = serviceProvider.items;
      isLoading = false;
    });
  }

  void deleteService(ServiceProvider serviceProvider, service) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final confirmDelete = await showExitDialog(
        context, "Deseja mesmo excluir o serviço '${service["description"]}'?");
    if (confirmDelete == true) {
      serviceProvider.delete(service["id"]);
      showMessage(
        const ContentMessage(
          title: "Serviço excluido com sucesso.",
          icon: Icons.info,
        ),
        const Color.fromARGB(255, 199, 82, 74),
      );
    }
  }

  void selectServices(Map<String, dynamic> dataService) {
    final result = servicesSelected.any(
      (service) => service["description"] == dataService["description"],
    );
    setState(() {
      !result
          ? servicesSelected.add({
              "service_id": dataService["id"],
              "description": dataService["description"],
              "price_service": dataService["price"],
              "time_service": TimeOfDay.now().toString().substring(10, 15),
            })
          : servicesSelected.removeWhere(
              (service) => service["description"] == dataService["description"],
            );
    });
  }

  void selectAllServices() {
    setState(() {
      if (servicesSelected.length == services.length) {
        servicesSelected.clear();
        return;
      }

      servicesSelected.clear();
      for (var service in services) {
        servicesSelected.add({
          "service_id": service["id"],
          "description": service["description"],
          "price_service": service["price"],
          "time_service": TimeOfDay.now().toString().substring(10, 15),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          servicesSelected.isEmpty
              ? "Serviços"
              : servicesSelected.length.toString(),
        ),
        actions: [
          if (servicesSelected.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => selectAllServices(),
                  icon: const Icon(
                    Icons.select_all,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(servicesSelected);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ServiceFormPage(
                      isEdition: false,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Theme.of(context).primaryColor,
                secondRingColor: Colors.amber,
                thirdRingColor: Colors.purple,
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Consumer<ServiceProvider>(
                builder: (context, serviceProvider, _) {
                  services = serviceProvider.items;
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    height: MediaQuery.of(context).size.height - 140,
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          focusNode: textFocusNode,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Digite para buscar",
                            suffixIcon: search.isEmpty
                                ? const Icon(
                                    Icons.search,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      searchController.text = "";
                                      setState(() {
                                        search = "";
                                        loadServices();
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                          onChanged: (description) {
                            setState(() {
                              search = description;
                              serviceProvider.searchDescription(description);
                            });
                          },
                        ),
                        services.isEmpty
                            ? Center(
                                child: AddNewService(
                                  closeKeyboard: () =>
                                      FocusScope.of(context).requestFocus(
                                    FocusNode(),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: services.length,
                                        itemBuilder: (_, index) {
                                          var service = services[index];
                                          return Column(
                                            children: [
                                              Slidable(
                                                endActionPane:
                                                    widget.itFromTheSalesScreen
                                                        ? null
                                                        : ActionPane(
                                                            motion:
                                                                const StretchMotion(),
                                                            children: [
                                                              SlidableAction(
                                                                onPressed: (_) {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode());
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              ServiceFormPage(
                                                                        isEdition:
                                                                            true,
                                                                        serviceId:
                                                                            service["id"],
                                                                        description:
                                                                            service["description"],
                                                                        price: service[
                                                                            "price"],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                backgroundColor:
                                                                    Colors
                                                                        .amber,
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon: Icons
                                                                    .edit_outlined,
                                                                label: "Editar",
                                                              ),
                                                              SlidableAction(
                                                                onPressed: (_) {
                                                                  deleteService(
                                                                      serviceProvider,
                                                                      service);
                                                                },
                                                                backgroundColor:
                                                                    Colors.red,
                                                                icon: Icons
                                                                    .delete,
                                                                label:
                                                                    "Excluir",
                                                              ),
                                                            ],
                                                          ),
                                                child: ListTile(
                                                  selected: servicesSelected
                                                      .any((dataService) =>
                                                          dataService[
                                                              "description"] ==
                                                          service[
                                                              "description"]),
                                                  selectedColor: Colors.white,
                                                  onLongPress: widget
                                                          .itFromTheSalesScreen
                                                      ? () => selectServices(
                                                          service)
                                                      : null,
                                                  onTap: () {
                                                    if (widget
                                                            .itFromTheSalesScreen &&
                                                        servicesSelected
                                                            .isEmpty) {
                                                      Navigator.of(context)
                                                          .pop({
                                                        "service_id":
                                                            service["id"],
                                                        "description": service[
                                                            "description"],
                                                        "price_service":
                                                            service["price"],
                                                        "time_service":
                                                            TimeOfDay.now()
                                                                .toString()
                                                                .substring(
                                                                    10, 15)
                                                      });
                                                      return;
                                                    }

                                                    selectServices(service);
                                                  },
                                                  minLeadingWidth: 0,
                                                  selectedTileColor:
                                                      Colors.indigo,
                                                  title: Text(
                                                    service["description"],
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  subtitle: Text(
                                                    numberFormat.format(
                                                        service["price"]),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  leading: const Icon(
                                                    FontAwesomeIcons
                                                        .screwdriverWrench,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
