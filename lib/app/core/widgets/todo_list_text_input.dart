import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/ui/theme_definition.dart';
import 'package:to_do_list/app/core/ui/todo_list_icons.dart';

class TodoListTextInput extends StatelessWidget {
  final String label;
  final bool isObscure;
  final Icon? suffixIcon;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> isObscureVN;
  final TextEditingController? textController;
  final FormFieldValidator<String>? validator;

  TodoListTextInput({
    super.key,
    required this.label,
    this.isObscure = false,
    this.suffixIcon,
    this.suffixIconButton,
    this.validator,
    this.textController,
  })  : assert(isObscure == true ? suffixIconButton == null : true,
            'isObscure + suffixIconButton não da bom'),
        isObscureVN = ValueNotifier(isObscure);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isObscureVN,
      builder: (context, value, child) {
        return TextFormField(
          validator: validator,
          controller: textController,
          cursorColor: ThemeDefinition.primaryColor,
          cursorErrorColor: Colors.red,
          //
          obscureText: isObscureVN.value,
          //
          decoration: InputDecoration(
            isDense: true,
            //
            label: Text(label),
            labelStyle:
                const TextStyle(fontSize: 15, color: ThemeDefinition.textColor),
            //
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(
                color: ThemeDefinition.primaryColor,
              ),
            ),
            //
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(
                color: ThemeDefinition.primaryColor,
              ),
            ),
            //
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            //
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(color: Colors.red),
            ),
            //
            suffixIcon: suffixIcon ??
                (isObscure == true
                    ? IconButton(
                        onPressed: () {
                          isObscureVN.value = !isObscureVN.value;
                        },
                        icon: !isObscureVN.value
                            ? const Icon(
                                TodoListIcons.eye,
                                size: 14,
                              )
                            : const Icon(
                                TodoListIcons.eyeSlash,
                                size: 14,
                              ),
                      )
                    : null),
          ),
        );
      },
    );
  }
}
