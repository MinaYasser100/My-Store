import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _userHiveHelper = UserHiveHelper();

  String selectedType = "Home";
  final countries = ["Egypt", "USA", "UK", "Germany", "France"];
  String selectedCountry = "Egypt";

  // controllers
  final _labelController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  bool _isSaving = false;

  Future<void> _saveAddress() async {
    try {
      setState(() => _isSaving = true);
      final userModel = _userHive_helper_getUser();

      if (userModel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found.")),
        );
        return;
      }

      final labelText = _labelController.text.trim().isEmpty
          ? selectedType
          : _labelController.text.trim();

      final addressData = {
        'label': labelText,
        'type': selectedType,
        'fullName': _fullNameController.text.trim(),
        'address': _streetController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'zip': _zipController.text.trim(),
        'country': selectedCountry,
        'userId': userModel.uid,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection(ConstantVariable.users)
          .doc(userModel.uid)
          .collection(ConstantVariable.addressesCollection)
          .add(addressData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Address added successfully!")),
      );
      context.pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving address: $e")),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  // helper to get user (extracted to avoid repeated long line)
  dynamic _userHive_helper_getUser() {
    try {
      return _userHive_helper_get(); // trigger typed wrapper below
    } catch (_) {
      return null;
    }
  }

  // typed wrapper that uses your UserHiveHelper instance
  dynamic _userHive_helper_get() {
    return _userHiveHelper.getUser(ConstantVariable.uId);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _fullNameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0D1C3C), size: 18),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Add Address',
          style: TextStyle(
            color: Color(0xFF0D1C3C),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Label (new — added back)
            _buildLabel('Address Label'),
            const SizedBox(height: 6),
            _buildTextField(_labelController, 'e.g. Home, Work, Office'),

            const SizedBox(height: 16),
            _buildLabel('Address Type'),
            const SizedBox(height: 8),
            Row(
              children: ['Home', 'Work', 'Other'].map((type) {
                final isSelected = selectedType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    selectedColor: const Color(0xFF0D1C3C),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF0D1C3C),
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: const Color(0xFFF5F6FA),
                    onSelected: (_) {
                      setState(() => selectedType = type);
                    },
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            _buildLabel('Full Name'),
            _buildTextField(_fullNameController, 'Enter full name'),

            const SizedBox(height: 16),
            _buildLabel('Street Address'),
            _buildTextField(_streetController, 'Enter street address'),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('City'),
                      _buildTextField(_cityController, 'City'),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('State/Region'),
                      _buildTextField(_stateController, 'State'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('ZIP Code'),
                      _buildTextField(_zipController, 'ZIP Code'),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Country'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCountry,
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: countries
                              .map((country) => DropdownMenuItem(
                                    value: country,
                                    child: Text(country),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => selectedCountry = value!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D1C3C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF0D1C3C),
          fontWeight: FontWeight.w500,
        ),
      );

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF0D1C3C), width: 1.5),
        ),
      ),
    );
  }
}
