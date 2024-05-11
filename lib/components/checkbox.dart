
import 'package:flutter/material.dart';
import 'package:scanly/bloc/login/login_cubit.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  void initState() {
    LoginCubit.get(context).loadUserEmailPassword();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Color(0xff179BE8);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: LoginCubit.get(context).isChecked,
      onChanged: (bool? value) {
        setState(() {
          LoginCubit.get(context).isChecked  = value!;
        });
      },
    );
  }
}
