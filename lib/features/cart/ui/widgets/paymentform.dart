import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';
import 'package:my_store/features/cart/ui/widgets/custom_checkBox.dart';

class Paymentform extends StatefulWidget {
  const Paymentform({super.key});

  @override
  State<Paymentform> createState() => _PaymentformState();
}

bool useShippingAddress = false;

class _PaymentformState extends State<Paymentform> {
  final _formKey = GlobalKey<FormState>();
  final creditcardnumber = TextEditingController();
  final ccv = TextEditingController();
  final ExpiryDate = TextEditingController();

  @override
  void dispose() {
    creditcardnumber.dispose();
    ccv.dispose();
    ExpiryDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your payment information:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: creditcardnumber,
              keyboardType: TextInputType.number,
              hintText: "credit card number",

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Please enter your credit card number";
                }
                if (v.trim().length != 16) {
                  return "Credit card number must be exactly 16 digits";
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 12),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: ccv,
              keyboardType: TextInputType.number,
              hintText: "CCV",

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],

              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Please enter your CCV number";
                }
                if (v.trim().length != 3) {
                  return "CCV must be exactly 3 digits";
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 12),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: ExpiryDate,
              keyboardType: TextInputType.text,
              hintText: "MM/YY",
              labelText: "ExpiryDate",
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Please enter your Expiry date";
                }
                final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
                if (!regex.hasMatch(v)) return "Enter a valid format MM/YY";
                return null;
              },
            ),
          ),

          CustomCheckbox(
            label: "use my shopping address for billing",
            onChanged: (value) {
              setState(() {
                useShippingAddress = value ?? false;
              });
            },
            validator: (value) {
              if (value != true) {
                return "You must check this box before proceeding.";
              }
              return null;
            },
            initialValue: useShippingAddress,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsTheme().primaryDark,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                GoRouter.of(context).push(Routes.confirmview);
              }
            },
            child: const Text(
              "Proceed to Payment",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
