import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/CustomWidgets/AppSnackBar.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomButton.dart';
import 'package:graduation_project/Core/CustomWidgets/CustomTextField.dart';
import 'package:graduation_project/business_logic/Profile/profile_cubit.dart';
import 'package:graduation_project/business_logic/Profile/profile_information_cubit.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

class Profile_information extends StatelessWidget {
  const Profile_information({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileInformationCubit(),
      child: const _ProfileInformationView(),
    );
  }
}

class _ProfileInformationView extends StatefulWidget {
  const _ProfileInformationView();

  @override
  State<_ProfileInformationView> createState() =>
      _ProfileInformationViewState();
}

class _ProfileInformationViewState extends State<_ProfileInformationView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _picker = ImagePicker();

  String? _imgUrl;
  File? _pickedImage;
  bool _hydrated = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Seed controllers from the loaded user exactly once so that subsequent
  /// state emissions (Saving, SaveError) don't clobber in-progress edits.
  void _hydrateOnce(UserModel user) {
    if (_hydrated) return;
    _hydrated = true;
    _usernameController.text = user.username;
    _emailController.text = user.email;
    _imgUrl = user.img;
  }

  bool _isDefaultImg(String? url) =>
      url == null || url.isEmpty || url.contains('default-user');

  Widget _buildProfileImage() {
    if (_pickedImage != null) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: FileImage(_pickedImage!),
      );
    }
    if (!_isDefaultImg(_imgUrl)) {
      return ClipOval(
        child: SizedBox(
          width: 90,
          height: 90,
          child: Image.network(
            _imgUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Image.asset(
              'Assets/images/Ellipse 4.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    return Image.asset('Assets/images/Ellipse 4.png', height: 99, width: 99);
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final canRemove = _pickedImage != null || !_isDefaultImg(_imgUrl);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: Color(0xff7C7CD5),
                  ),
                  title: Text(S.of(context).profile_gallery),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null && mounted) {
                      setState(() => _pickedImage = File(picked.path));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Color(0xff7C7CD5),
                  ),
                  title: Text(S.of(context).profile_camera),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final picked = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null && mounted) {
                      setState(() => _pickedImage = File(picked.path));
                    }
                  },
                ),
                if (canRemove)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
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

  void _save() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final currentPass = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty) {
      AppSnackBar.error(context, S.of(context).profile_validation_required);
      return;
    }

    final hasAny =
        currentPass.isNotEmpty || newPass.isNotEmpty || confirmPass.isNotEmpty;
    final hasAll = currentPass.isNotEmpty &&
        newPass.isNotEmpty &&
        confirmPass.isNotEmpty;
    if (hasAny && !hasAll) {
      AppSnackBar.error(context, S.of(context).profile_validation_passwords);
      return;
    }
    if (hasAll && newPass != confirmPass) {
      AppSnackBar.error(context, S.of(context).passwords_must_match);
      return;
    }

    final removeImage = _pickedImage == null && _isDefaultImg(_imgUrl);
    context.read<ProfileInformationCubit>().updateUser(
          username: username,
          email: email,
          currentPassword: hasAll ? currentPass : null,
          newPassword: hasAll ? newPass : null,
          confirmPassword: hasAll ? confirmPass : null,
          imgPath: _pickedImage?.path,
          removeImage: removeImage,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return BlocConsumer<ProfileInformationCubit, ProfileInformationState>(
      listener: (context, state) {
        if (state is ProfileInformationLoaded) {
          setState(() => _hydrateOnce(state.user));
        } else if (state is ProfileInformationLoadError && !_hydrated) {
          // Inline-rendered when no user is loaded yet; no snackbar needed.
        } else if (state is ProfileInformationLoadError) {
          AppSnackBar.error(context, state.message);
        } else if (state is ProfileInformationSaveSuccess) {
          AppSnackBar.success(
            context,
            S.of(context).profile_update_success,
          );
          // Refresh the parent ProfileCubit so the Profile screen reflects
          // the new image/name/email immediately after we pop back.
          context.read<ProfileCubit>().getMainData();
          Navigator.pop(context);
        } else if (state is ProfileInformationSaveError) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        final isInitialLoad = !_hydrated &&
            (state is ProfileInformationInitial ||
                state is ProfileInformationLoading);
        if (isInitialLoad) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!_hydrated && state is ProfileInformationLoadError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProfileInformationCubit>().loadUser(),
                      child: Text(S.of(context).retry),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final isSaving = state is ProfileInformationSaving;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset('Assets/images/Group 1.png'),
                    PositionedDirectional(
                      top: 30,
                      start: 20,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xffD6D6F5),
                        ),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          isRtl ? Icons.chevron_right : Icons.chevron_left,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -40,
                      child: GestureDetector(
                        onTap: isSaving ? null : _showImagePicker,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _buildProfileImage(),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 55,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xff7C7CD5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
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
                const SizedBox(height: 68),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _usernameController,
                        hint: S.of(context).profile_username,
                        label: S.of(context).profile_username,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _emailController,
                        hint: S.of(context).profile_email,
                        label: S.of(context).profile_email,
                        readOnly: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _currentPasswordController,
                        hint: S.of(context).enter_pass,
                        label: S.of(context).profile_current_pass,
                        isabvious: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _newPasswordController,
                        hint: S.of(context).enter_pass,
                        label: S.of(context).profile_new_pass,
                        isabvious: true,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hint: S.of(context).enter_pass,
                        label: S.of(context).profile_confirm_pass,
                        isabvious: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          txt: isSaving
                              ? S.of(context).profile_saving
                              : S.of(context).profile_btn1,
                          onpressed: isSaving ? null : _save,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          txt: S.of(context).profile_btn2,
                          c: const Color(0xffCCCCCC),
                          onpressed: isSaving
                              ? null
                              : () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
