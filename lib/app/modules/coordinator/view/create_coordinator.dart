import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/coordinator.dart';
import '../../../widgets/customer_textfield.dart';
import '../index.dart';

class CreateCoordinator extends StatefulWidget {
  final bool isFirstTime;
  const CreateCoordinator({super.key, this.isFirstTime = false});

  @override
  State<CreateCoordinator> createState() => _CreateCoordinatorState();
}

class _CreateCoordinatorState extends State<CreateCoordinator> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoordinatorController());
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Coordinator', style: AppConstants.kAppBarTextStyle),
        centerTitle: false,
      ),
      body: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.isFirstTime) const SizedBox(height: 30),
              if (widget.isFirstTime)
                Text(
                  'Please add a coordinator to continue',
                  style: theme.textTheme.headline6?.copyWith(color: Colors.grey),
                ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _nameController,
                labelText: 'Coordinator Name',
                hintText: 'Enter coordinator name',
                icon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (name) => name!.isEmpty ? 'Please enter coordinator name' : null,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                hintText: ' 000 000 0000',
                prefixText: '+91',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (phone) {
                  if (phone!.isEmpty) {
                    return 'Please enter phone number';
                  } else if (phone.length != 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final mobileNumber = '+91${_phoneController.text}';
                    final coordinator = Coordinator(
                      name: _nameController.text,
                      phone: mobileNumber,
                    );
                    final success = await controller.createCoordinator(coordinator, isFirstTime: widget.isFirstTime);
                    if (success) Get.back();
                  }
                },
                child: const Text('Add Coordinator'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
