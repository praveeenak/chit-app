import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/app_constants.dart';
import '../../../widgets/customer_textfield.dart';
import '../controller/chitty_controller.dart';

class CreateChitty extends StatefulWidget {
  const CreateChitty({super.key});

  @override
  State<CreateChitty> createState() => _CreateChittyState();
}

class _CreateChittyState extends State<CreateChitty> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<ChittyController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Chitty',
          style: AppConstants.kAppBarTextStyle,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fill the details to create a chitty', style: theme.textTheme.headline6),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Chitty Number',
                hintText: 'Enter Chitty Number',
                keyboardType: TextInputType.number,
                icon: FeatherIcons.hash,
                controller: _idController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter chitty number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Chitty Name',
                hintText: 'Enter Chitty Name',
                icon: FeatherIcons.fileText,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter chitty name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // controller.createChitty(id: _idController.text, name: _nameController.text);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
