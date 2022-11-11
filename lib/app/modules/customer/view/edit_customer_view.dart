import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/customer.dart';
import '../../../widgets/customer_textfield.dart';
import '../controller/customer_controller.dart';

class EditCustomer extends StatefulWidget {
  const EditCustomer({super.key});

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final Customer customer = Get.arguments as Customer;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _chittyNumberController = TextEditingController();

  @override
  void initState() {
    _nameController.text = customer.name ?? '';
    _phoneController.text = customer.phone?.replaceAll('+91', '') ?? '';
    _addressController.text = customer.address ?? '';
    _chittyNumberController.text = customer.chittyNumber ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Member',
          style: AppConstants.kAppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Member Name',
                hintText: 'Enter member name',
                icon: FeatherIcons.user,
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: (name) => name!.isEmpty ? 'Please enter member name' : null,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  labelText: 'Phone Number',
                  hintText: ' 000 000 0000',
                  prefixText: '+91',
                  icon: FeatherIcons.phone,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (phone) {
                    if (phone!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (phone.length != 10) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Address',
                hintText: 'Enter address',
                icon: FeatherIcons.home,
                controller: _addressController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                validator: (address) => address!.isEmpty ? 'Please enter address' : null,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Chitty Number',
                hintText: 'Enter chitty number',
                icon: FeatherIcons.hash,
                controller: _chittyNumberController,
                keyboardType: TextInputType.number,
                validator: (chitty) => chitty!.isEmpty ? 'Please enter chitty number' : null,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    customer.phone = '+91${_phoneController.text}';
                    customer.name = _nameController.text;
                    customer.address = _addressController.text;
                    customer.chittyNumber = _chittyNumberController.text;
                    controller.editCustomer(customer);
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
