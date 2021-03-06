import 'package:flutter/material.dart';
import 'package:payflow/modules/extractPage/exrtact_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/modules/meusBoletos/meusBoletos_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/bottomSheet/bottomSheet_widget.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          color: AppColors.primary,
          height: 152,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá,",
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: "${widget.user.name}",
                        style: TextStyles.titleBoldBackground)
                  ],
                ),
              ),
              subtitle: Text("Mantenha suas contas em dia",
                  style: TextStyles.captionShape),
              trailing: GestureDetector(
                onTap: () {
                  _showModalBottom(context);
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(widget.user.photoURL!),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        MeusExtratosPage(
          key: UniqueKey(),
        ),
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                homeController.setPage(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: homeController.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, '/barcodescanner');
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primary,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/barcodescanner');
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.setPage(1);
                setState(() {});
              },
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showModalBottom(BuildContext context) {
  final loginController = LoginController();

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetWidget(
          rotate: false,
          title: 'Você deseja sair?',
          subtitle: '',
          primaryLabel: 'Não, cancelar',
          primaryOnPressed: () {
            Navigator.pop(context);
          },
          secundaryLabel: 'Sim, sair',
          secundaryOnPressed: () {
            loginController.googleSignOUt(context);
          },
        );
      });
}
