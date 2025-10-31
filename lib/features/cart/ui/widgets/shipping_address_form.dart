import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/model/text_field_model/text_field_model.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/colors.dart';
import 'package:my_store/core/widgets/custom_text_form_field.dart';
import 'governorate_dropdown.dart';
import 'fixed_country_field.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({super.key});

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  String? selectedGovernorate;

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
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
            "The address your order will be shipped to:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: nameController,
              keyboardType: TextInputType.name,
              hintText: "Full name",
              validator: (v) => v == null || v.trim().isEmpty
                  ? "Please enter your full name"
                  : null,
            ),
          ),
          const SizedBox(height: 12),

          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              hintText: "Address",
              validator: (v) => v == null || v.trim().isEmpty
                  ? "Please enter your address"
                  : null,
            ),
          ),

          const SizedBox(height: 12),
          const FixedCountryField(),
          const SizedBox(height: 12),
          GovernorateDropdown(
            onChanged: (v) => setState(() => selectedGovernorate = v),
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: zipController,
              keyboardType: TextInputType.number,
              hintText: "Zip Code",
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return "Please enter your zip code";
                } else if (!RegExp(r'^[0-9]{5,6}$').hasMatch(v.trim())) {
                  return "Zip code must be 5 or 6 digits";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),

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
                GoRouter.of(context).push(Routes.paymentView);
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
