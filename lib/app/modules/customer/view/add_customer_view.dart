import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/coordinator.dart';
import '../../../data/model/customer.dart';
import '../../../widgets/customer_textfield.dart';
import '../../coordinator/view/select_coordinator.dart';
import '../controller/customer_controller.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _chittyNumberController = TextEditingController();

  bool _isValid = false;

  Coordinator? selectedCoordinator;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Member',
          style: AppConstants.kAppBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.kDefaultPadding,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            onChanged: () {
              setState(() => _isValid = _formKey.currentState!.validate());
            },
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
                const SizedBox(height: 20),
                Visibility(
                  visible: selectedCoordinator == null,
                  replacement: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(selectedCoordinator?.name ?? ''),
                      subtitle: Text(selectedCoordinator?.phone ?? ''),
                      onTap: () async {
                        Get.to(() => SelectCoordinator())?.then((value) {
                          if (value != null) {
                            setState(() => selectedCoordinator = value);
                          }
                        });
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: const Text('Select Coordinator'),
                    subtitle: const Text('Please select a coordinator'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      Get.to(() => SelectCoordinator())?.then((value) {
                        if (value != null) {
                          setState(() => selectedCoordinator = value);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isValid ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton.extended(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (selectedCoordinator != null) {
                final mobile = '+91${_phoneController.text}';
                final Customer customer = Customer(
                  cId: selectedCoordinator!.id,
                  name: _nameController.text,
                  phone: mobile,
                  address: _addressController.text,
                  chittyNumber: _chittyNumberController.text,
                );
                final success = await controller.createCustomer(customer);
                if (success) Get.back();
              } else {
                Get.snackbar(
                  'Error',
                  'Please select a coordinator',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            }
          },
          icon: const Icon(FeatherIcons.check),
          label: const Text('Confirm'),
        ),
      ),
    );
  }
}
