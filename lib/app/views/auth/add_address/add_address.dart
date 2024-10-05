import 'dart:convert';

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../../../../data/data.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import 'add_address_form.dart';

class AddAddress extends StatefulWidget {
  static const route = "/addAddresse";
  const AddAddress({super.key, required this.email});

  final String email;

  @override
  State<AddAddress> createState() => _AddAdresseState();
}

class _AddAdresseState extends State<AddAddress> {
  final TextEditingController communeController = TextEditingController();
  final TextEditingController celluleController = TextEditingController();
  final TextEditingController quarterController = TextEditingController();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final userData = Provider.of<UserDataController>(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.blackB,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              "Ajouter votre adresse",
              style: theme.textTheme.titleMedium!.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(height * 0.015),
                        Text(
                          " User ID : ${widget.email}\n\nVeuillez prendre un petit momen...",
                          style: GoogleFonts.raleway(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1.2,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PangoGest ! ",
                              style: GoogleFonts.raleway(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.asset(AppImages.logo),
                            ),
                          ],
                        ),
                        Gap(height * 0.015),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: AddAddressForm(
                              communeController: communeController,
                              celluleController: celluleController,
                              quarterController: quarterController,
                              avenueController: avenueController,
                              numController: numController,
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        userData.isRegisterUser
                            ? Container(
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: height * 0.015,
                                ),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : CustomMainButton(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final url = Uri.parse(
                                      "http://192.168.1.116:8000/api/adresse/",
                                    );
                                    var body = jsonEncode(
                                      {
                                        "ville": "Bukavu",
                                        "commune": communeController.text,
                                        "quartier": quarterController.text,
                                        "cellule":
                                            celluleController.text.isNotEmpty
                                                ? celluleController.text
                                                : null,
                                        "avenue": avenueController.text,
                                        "num_av": numController.text.isNotEmpty
                                            ? numController.text
                                            : "0000",
                                      },
                                    );
                                    try {
                                      final response = await http.post(
                                        url,
                                        headers: {
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                        },
                                        body: body,
                                      );
                                      if (response.statusCode == 201) {
                                        debugPrint(
                                          "======================== Address successfully created",
                                        );
                                        final json = jsonDecode(response.body);
                                        final address =
                                            AddressModel.fromJson(json);
                                        debugPrint(json["id"].toString());
                                        final urlFilter = Uri.parse(
                                          "http://192.168.1.116:8000/api/utilisateurs/?username=${widget.email}&first_name=&last_name=&user_type=",
                                        );

                                        try {
                                          var body = jsonEncode(
                                            {"id_adresse": json["id"]},
                                          );
                                          final response2 =
                                              await http.get(urlFilter);
                                          List jsonList =
                                              jsonDecode(response2.body);
                                          final jsonUser = jsonList.first;
                                          final userID =
                                              jsonUser["id"].toString();
                                          final urlUpdate = Uri.parse(
                                            "http://192.168.1.116:8000/api/utilisateurs/$userID/",
                                          );
                                          try {
                                            final response = await http.patch(
                                              urlUpdate,
                                              headers: {
                                                'Content-Type':
                                                    'application/json; charset=UTF-8',
                                              },
                                              body: body,
                                            );
                                            debugPrint(response.body);
                                            final json =
                                                jsonDecode(response.body);
                                            final user =
                                                UserModel.fromJson(json);
                                            await userData.registerUser(
                                              user,
                                              address,
                                            );
                                            communeController.clear();
                                            quarterController.clear();
                                            celluleController.clear();
                                            avenueController.clear();
                                            numController.clear();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } catch (e) {
                                            debugPrint(
                                                "Update error: ${e.toString()}");
                                          }
                                        } catch (e) {
                                          debugPrint(
                                              "Filter error: ${e.toString()}");
                                        }
                                      } else {
                                        debugPrint("Body : ${response.body}");
                                        debugPrint(
                                            "Error : ${response.statusCode}");
                                      }
                                    } catch (e) {
                                      debugPrint("Erreur lors du post : $e");
                                    }
                                  }
                                },
                                text: "S'inscrire",
                              ),
                      ],
                    ),
                  ),
                  // WrapperInscriptionConnexion(
                  //   fromConnexion: false,
                  //   canPop: widget.fromConnexion,
                  // ),
                  Gap(height * 0.02),
                  const AuthBottomView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
