import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insertBoleto/insertBolet_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/appTextStyles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/inputText/inputText_widget.dart';
import 'package:payflow/shared/widgets/setLabelButtons/setLabelButtons_widget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controllerValidator = InsertBoletoController();
  final controllerUser = AuthController();

  final moneyInputController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");

  final dueDateInputController = MaskedTextController(mask: '00/00/0000');
  final barcodeInputController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.input,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 40),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: controllerValidator.formKey,
                  child: Column(
                    children: [
                      InputTextWidget(
                        label: "Nome do boleto",
                        icon: Icons.description_outlined,
                        onChanged: (value) {
                          controllerValidator.onChange(name: value);
                        },
                        validator: controllerValidator.validateName,
                      ),
                      InputTextWidget(
                        controller: dueDateInputController,
                        label: "Vencimento",
                        icon: Icons.calendar_today_outlined,
                        onChanged: (value) {
                          controllerValidator.onChange(dueDate: value);
                        },
                        validator: controllerValidator.validateVencimento,
                      ),
                      InputTextWidget(
                        controller: moneyInputController,
                        label: "Valor",
                        icon: FontAwesomeIcons.wallet,
                        onChanged: (value) {
                          controllerValidator.onChange(
                              value: moneyInputController.numberValue);
                        },
                        validator: (_) => controllerValidator
                            .validateValor(moneyInputController.numberValue),
                      ),
                      InputTextWidget(
                        controller: barcodeInputController,
                        label: "Código de barras",
                        icon: FontAwesomeIcons.barcode,
                        onChanged: (value) {
                          controllerValidator.onChange(barcode: value);
                        },
                        validator: controllerValidator.validateCodigo,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        secundaryLabel: "Cadastrar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secundaryOnPressed: () async {
          await controllerValidator.cadastrarBoleto();
          Navigator.pop(context);
        },
        enableSecundaryColor: true,
      ),
    );
  }
}
