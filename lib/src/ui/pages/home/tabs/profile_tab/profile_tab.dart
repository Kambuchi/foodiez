import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiez/src/data/repositories/account_repository.dart';
import 'package:provider/provider.dart';
import '../../../../global_controller/notifications_controller.dart';
import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/authentication_repository.dart';
import '../../../../../data/repositories/preferences_reposiory.dart';
import '../../../../../data/repositories/websocket_repository.dart';
import '../../../../../helpers/get.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/date_format.dart';
import '../../../../../utils/dialogs.dart';
import '../../../../../utils/font_styles.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
    final isOk = await Dialogs.confirm(context, title: 'Accion requerida');
    if (isOk!) {
      await Get.i.find<AutheticationRepository>().signOut();
      await Get.i
          .find<PreferencesRepository>()
          .setOnboardAndWelcomeReady(false);
      await Get.i.find<WebsocketRepository>().disconnect();
      context.read<NotificationsController>().clear();
      Navigator.pushNamedAndRemoveUntil(context, Routes.LOGIN, (_) => true);
    }
  }

  @override
  Widget build(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
    // final user = Get.i.find<User>();
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            child: ClipOval(
              child: CachedNetworkImage(
                  width: 200,
                  color: Colors.transparent,
                  colorBlendMode: BlendMode.srcOver,
                  height: 200,
                  imageUrl:
                      'https://e7.pngegg.com/pngimages/340/946/png-clipart-avatar-user-computer-icons-software-developer-avatar-child-face-thumbnail.png'),
            ),
          ),
          CupertinoFormSection.insetGrouped(
            header: Text('Información de usuario'),
            margin: EdgeInsets.all(15).copyWith(top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            children: [
              CupertinoFormRow(
                prefix: Text(
                  'ID',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(user!.uid),
              ),
              CupertinoFormRow(
                prefix: Text(
                  'Nombre',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(user.displayName!),
              ),
              CupertinoTextFormFieldRow(
                prefix: Text(
                  'Correo',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: user.email,
                style: FontStyles.normal.copyWith(color: Colors.black),
                textAlign: TextAlign.right,
              ),
              // CupertinoFormRow(
              //   prefix: Text(
              //     'Cumpleaños',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   child: Text(user.birthday.format),
              // ),
            ],
          ),
          CupertinoFormSection(
            margin: const EdgeInsets.all(15),
            header: Text('Métodos de Pago'),
            children: [
              CupertinoFormRow(
                prefix: Text(
                  "Tarjetas",
                  style: TextStyle(color: Colors.black),
                ),
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    minSize: 20,
                    child: Text('Mostrar tarjetas'),
                    onPressed: () {}),
              ),
              CupertinoFormRow(
                prefix: Text(
                  "PayPal",
                  style: TextStyle(color: Colors.black),
                ),
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    minSize: 20,
                    child: Text('kambu@test.com'),
                    onPressed: () {}),
              ),
            ],
          ),
          CupertinoFormSection(
            margin: const EdgeInsets.all(15),
            header: Text('Cuenta'),
            children: [
              CupertinoFormRow(
                prefix: Text(
                  "Ajustes de Cuenta",
                  style: TextStyle(color: Colors.black),
                ),
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    minSize: 20,
                    child: Text('Editar ajustes'),
                    onPressed: () {}),
              ),
              CupertinoFormRow(
                prefix: Text(
                  "Sesión",
                  style: TextStyle(color: Colors.black),
                ),
                child: CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    minSize: 20,
                    child: Text(
                      'Salir',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () => _signOut(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
