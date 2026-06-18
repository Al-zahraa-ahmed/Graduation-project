import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.label,
    this.onsaved,
    this.keyboardtype,
    this.isabvious = false,
    this.validator,
    this.controller,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });
  final String hint, label;
  final void Function(String?)? onsaved;
  final TextInputType? keyboardtype;
  final bool isabvious;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscured = widget.isabvious;

  static const _normalBorder = Color(0xffD6D6F5);
  static const _errorColor = Color(0xffD32F2F);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text ?? '',
      validator: widget.validator,
      onSaved: widget.onsaved,
      builder: (FormFieldState<String> state) {
        final hasError = state.hasError;
        final borderColor = hasError ? _errorColor : _normalBorder;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 8,
                    color: const Color(0xff2B3574).withValues(alpha: 0.1),
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                textInputAction: widget.textInputAction,
                onSubmitted: widget.onFieldSubmitted,
                onChanged: (value) => state.didChange(value),
                obscureText: _obscured,
                keyboardType: widget.keyboardtype,
                readOnly: widget.readOnly,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  hint: Text(
                    widget.hint,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff999999),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  suffixIcon: widget.isabvious
                      ? IconButton(
                          icon: Icon(
                            _obscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xff999999),
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscured = !_obscured),
                          splashRadius: 20,
                        )
                      : null,
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 6, start: 8),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: _errorColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
