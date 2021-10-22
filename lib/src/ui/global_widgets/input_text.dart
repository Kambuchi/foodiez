import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ui/global_widgets/custom_form.dart';
import '../../utils/colors.dart';

class InputText extends StatefulWidget {
  final Widget? prefixIcon;
  final String? Function(String)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? labelText;

  const InputText({
    Key? key,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.labelText,
  }) : super(key: key);

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  String? _errorText = '';
  late bool _obscureText;
  CustomFormState? _formState;

  String? get errorText => _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _formState = CustomForm.of(context);
      if (_formState != null) {
        _formState?.register(this);
      }
    });
  }

  @override
  void deactivate() {
    _formState = CustomForm.of(context);
    _formState?.remove(this);

    super.deactivate();
  }

  void _validate(String text) {
    if (widget.validator != null) {
      _errorText = widget.validator!(text);
      setState(() {});
    }

    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  void _onVisibleChanged() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _validate,
      keyboardType: widget.keyboardType,
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? CupertinoButton(
                minSize: 25,
                padding: EdgeInsets.all(5),
                child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: _onVisibleChanged,
              )
            : Icon(
                Icons.check_circle,
                color: _errorText == null ? primaryColor : Colors.grey,
              ),
      ),
    );
  }
}
