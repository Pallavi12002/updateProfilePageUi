import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _nameController = TextEditingController();
  final _stateController = TextEditingController();
  String _gender = 'Male';
  String? _country;
  bool _isEmailValid = false;
  bool _isMobileValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _mobileController.dispose();
    _nameController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7463F0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text('Update Profile', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: const Color(0xFF7463F0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfilePicture(),
                    const SizedBox(height: 16),
                    _buildTextField('Name', 'Enter your name', _nameController),
                    const SizedBox(height: 16),
                    _buildTextField('Mobile Number', 'Enter your mobile number', _mobileController, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Email', 'Enter your email', _emailController, isEmail: true),
                    const SizedBox(height: 16),
                    _buildGenderSelector(),
                    const SizedBox(height: 16),
                    _buildTextField('State', 'Enter your state', _stateController),
                    const SizedBox(height: 16),
                    _buildDropdownField('Country', _country),
                    const SizedBox(height: 24),
                    _buildUpdateButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey[200],
      child: IconButton(
        icon: Icon(Icons.camera_alt, color: Colors.grey),
        onPressed: () {
          // Handle profile picture change
        },
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isNumber = false, bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: _getValidationIcon(controller, isEmail, isNumber),
          ),
          onChanged: (text) {
            setState(() {
              if (isEmail) {
                _isEmailValid = _validateEmail(text);
              } else if (isNumber) {
                _isMobileValid = _validateMobile(text);
              }
            });
          },
        ),
      ],
    );
  }

  Icon? _getValidationIcon(TextEditingController controller, bool isEmail, bool isNumber) {
    if (controller.text.isEmpty) {
      return null;
    }
    if (isEmail) {
      return _isEmailValid ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.error, color: Colors.red);
    }
    if (isNumber) {
      return _isMobileValid ? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.error, color: Colors.red);
    }
    return null;
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender'),
        SizedBox(height: 8),
        Row(
          children: [
            _buildRadioButton('Male'),
            _buildRadioButton('Female'),
            _buildRadioButton('Others'),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _gender,
          onChanged: (String? newValue) {
            setState(() {
              _gender = newValue!;
            });
          },
        ),
        Text(value),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: DropdownButton<String>(
            value: value,
            hint: Text('Select your country'),
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _country = newValue!;
              });
            },
            items: <String>['INDIA', 'USA', 'UK', 'Canada', 'Australia']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF7463F0),
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: (_isEmailValid && _isMobileValid) ? () {
          // Handle update button press
        } : null,
        child: Text(
          'Update Your Profile',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validateMobile(String mobile) {
    final mobileRegex = RegExp(r'^\d{10}$');
    return mobileRegex.hasMatch(mobile);
  }
}
