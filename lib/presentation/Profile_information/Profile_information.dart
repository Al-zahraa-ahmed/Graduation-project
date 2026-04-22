import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

class Profile_information extends StatefulWidget {
  const Profile_information({super.key});

  @override
  State<Profile_information> createState() => _Profile_informationState();
}

class _Profile_informationState extends State<Profile_information> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _userApi = UserApiService();
  final _picker = ImagePicker();
  bool _isLoading = true;
  bool _isSaving = false;
  String? _imgUrl;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _userApi.getUserAllData();
      _usernameController.text = user.username;
      _nameController.text = user.email; // name field from API
      _emailController.text = user.email;
      _imgUrl = user.img;

      // Use the actual fields from the API response
      final response = await _userApi.dio.get(
        "https://signlingo.org/api/user/all-data",
      );
      final data = response.data["data"];
      _usernameController.text = data["username"] ?? "";
      _nameController.text = data["name"] ?? "";
      _emailController.text = data["userEmail"] ?? "";
      _imgUrl = data["img"];
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).profile_load_error)),
        );
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildProfileImage() {
    if (_pickedImage != null) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: FileImage(_pickedImage!),
      );
    }
    if (_imgUrl != null &&
        _imgUrl!.isNotEmpty &&
        !_imgUrl!.contains("default-user")) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(_imgUrl!),
      );
    }
    return Image.asset(
      "Assets/images/Ellipse 4.png",
      height: 99,
      width: 99,
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library, color: Color(0xff7C7CD5)),
                  title: Text(S.of(context).profile_gallery),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      setState(() => _pickedImage = File(picked.path));
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Color(0xff7C7CD5)),
                  title: Text(S.of(context).profile_camera),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) {
                      setState(() => _pickedImage = File(picked.path));
                    }
                  },
                ),
                if (_imgUrl != null || _pickedImage != null)
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text(S.of(context).profile_remove_photo),
                    onTap: () {
                      Navigator.pop(ctx);
                      setState(() {
                        _pickedImage = null;
                        _imgUrl = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    final username = _usernameController.text.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final currentPass = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    // Validation
    if (username.isEmpty || name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).profile_validation_required)),
      );
      return;
    }

    // Password validation: all 3 empty or all 3 filled
    final hasAnyPassword =
        currentPass.isNotEmpty || newPass.isNotEmpty || confirmPass.isNotEmpty;
    final hasAllPasswords =
        currentPass.isNotEmpty && newPass.isNotEmpty && confirmPass.isNotEmpty;
    if (hasAnyPassword && !hasAllPasswords) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).profile_validation_passwords),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final bool removeImage = _pickedImage == null && _imgUrl == null;
      await _userApi.updateUserData(
        username: username,
        name: name,
        email: email,
        currentPassword: hasAllPasswords ? currentPass : null,
        newPassword: hasAllPasswords ? newPass : null,
        confirmPassword: hasAllPasswords ? confirmPass : null,
        imgPath: _pickedImage?.path,
        removeImage: removeImage,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).profile_update_success)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset("Assets/images/Group 1.png"),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Color(0xffD6D6F5),
                          ),
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.chevron_left),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -40,
                        child: GestureDetector(
                          onTap: _showImagePicker,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _buildProfileImage(),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 55,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color(0xff7C7CD5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 68),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _usernameController,
                          hint: S.of(context).profile_username,
                          label: S.of(context).profile_username,
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          controller: _nameController,
                          hint: S.of(context).profile_name,
                          label: S.of(context).profile_name,
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          controller: _emailController,
                          hint: S.of(context).profile_email,
                          label: S.of(context).profile_email,
                          readOnly: true,
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          controller: _currentPasswordController,
                          hint: "*****************",
                          label: S.of(context).profile_current_pass,
                          isabvious: true,
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          controller: _newPasswordController,
                          hint: "*****************",
                          label: S.of(context).profile_new_pass,
                          isabvious: true,
                        ),
                        SizedBox(height: 24),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hint: "*****************",
                          label: S.of(context).profile_confirm_pass,
                          isabvious: true,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            txt: _isSaving ? S.of(context).profile_saving : S.of(context).profile_btn1,
                            onpressed: _isSaving ? null : _saveChanges,
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            txt: S.of(context).profile_btn2,
                            c: Color(0xffCCCCCC),
                            onpressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
