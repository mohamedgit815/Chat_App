import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';

import 'const_functions.dart';
import 'custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DefaultExpandedAuth extends StatelessWidget {
  final Widget child;

  const DefaultExpandedAuth({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 1,),
        Expanded(
            flex: 12,
            child: child
        ),
        const Spacer(flex: 1,),
      ],
    );
  }
}


class DefaultModalBottomSheet extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const DefaultModalBottomSheet({
    Key? key,
    required this.text,
    required this.iconData ,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [

            Icon(
              iconData,
              color: ConstColor.normalBlack,
              size: 30.0,
            ) ,

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0
                ),
                child: CustomText(
                  text: text ,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class DefaultCircleAvatar extends StatelessWidget {
  final UserModel userModel;
  final Color? color , textColor;
  final double? radius;
  final ValueKey? valueKey;

  const DefaultCircleAvatar({Key? key,
    required this.userModel,
    this.color,
    this.textColor ,
    this.radius ,
    this.valueKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      key: valueKey,
      radius: radius ,
      backgroundColor: userModel.image.isEmpty ? color ?? ConstColor.lightMainColor : null,
      backgroundImage: userModel.image.isEmpty ? null : NetworkImage(userModel.image) ,
      child: CustomText(
        text: userModel.first.substring(0,1).toString(),fontSize: 20.0,
        color: textColor ?? ConstColor.normalWhite ,
        key: valueKey,
      ),
    );
  }
}


class DefaultVisibleText extends StatelessWidget {
  final UserModel userModel;
  const DefaultVisibleText({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: userModel.bio.isEmpty ? false : true,
        child: CustomText(
          text: userModel.bio.toString(),
        )
    );
  }
}



class DefaultIconButtonVisibility extends StatelessWidget {
  final IconData icon ;
  final WidgetRef ref;
  final VoidCallback? onPressed ;
  final Color? color ;
  final ChangeNotifierProvider<SwitchState> state ;

  const DefaultIconButtonVisibility({
    super.key ,
    required this.ref ,
    required this.icon ,
    required this.state ,
    this.onPressed ,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed ?? (){
          ref.read(state).funcSwitch();
        },
        icon: Icon(icon,color: color ?? ConstColor.normalWhite ));
  }
}


class DefaultAuthFormField extends StatelessWidget {
  final String hintText;
  final bool? password;
  final Widget? suffixIcon;
  final TextInputAction inputAction ;
  final TextInputType inputType;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String> validator;

  const DefaultAuthFormField({
    Key? key,
    required this.hintText ,
    required this.controller ,
    required this.validator ,
    required this.inputType ,
    required this.inputAction ,
    this.onSubmitted ,
    this.suffixIcon ,
    this.password
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _outlineInputBorder({double? circle}){
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle ?? 25.0) ,
          borderSide: const BorderSide(
              color: ConstColor.normalWhite
          )
      );
    }

    return TextFormField(
      controller: controller ,
      keyboardType: inputType ,
      textInputAction: inputAction ,
      obscureText: password ?? false ,
      cursorColor: ConstColor.normalWhite ,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      style: const TextStyle(color: ConstColor.normalWhite) ,
      decoration: InputDecoration(
          filled: true ,
          fillColor: Colors.transparent ,
          hintText: hintText ,
          suffixIcon: suffixIcon ,
          focusedBorder: _outlineInputBorder() ,
          border: _outlineInputBorder() ,
          enabledBorder: _outlineInputBorder(),
          focusedErrorBorder: _outlineInputBorder(circle: 0.0) ,
          errorBorder: _outlineInputBorder(circle: 0.0) ,
          disabledBorder: _outlineInputBorder(circle: 0.0)
      ),
    );
  }
}


class DefaultTextFormField extends StatelessWidget {

  final ValueChanged<String>? onChange , onSubmitted;
  final ValueChanged? onSave ;
  final FormFieldValidator<String> validator;
  final Widget? suffixIcon , prefixIcon;
  final Color? suffixIconColor , prefixIconColor , fillColor;
  final String? label , hint ;
  final bool? password ;
  final TextInputAction inputAction ;
  final TextInputType inputType ;
  final TextEditingController? controller ;
  final TextStyle? style , hintStyle;
  final OutlineInputBorder? border;

  const DefaultTextFormField({
    Key? key,
    required this.validator ,
    required this.inputType ,
    required this.inputAction ,
    this.onChange ,
    this.style ,
    this.border ,
    this.hintStyle ,
    this.onSave ,
    this.controller ,
    this.onSubmitted ,
    this.password ,
    this.suffixIcon ,
    this.prefixIcon ,
    this.suffixIconColor ,
    this.prefixIconColor ,
    this.fillColor ,
    this.label ,
    this.hint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      autocorrect: true ,
      onChanged: onChange ,
      validator: validator ,
      textDirection: TextDirection.ltr,
      onSaved: onSave,
      keyboardType: inputType ,
      cursorColor: _theme.colorScheme.background,
      textInputAction: inputAction ,
      onFieldSubmitted: onSubmitted ,
      obscureText: password ?? false ,
      autofocus: false,
      style: style,
      decoration: InputDecoration(
          filled: true ,
          fillColor: fillColor ,
          border: border ,
          focusedBorder: border ,
          enabledBorder: border ,
          errorBorder: border ,
          suffixIconColor: suffixIconColor ,
          prefixIconColor: prefixIconColor ,
          suffixIcon: suffixIcon ,
          prefixIcon: prefixIcon ,
          hintStyle: hintStyle ,
          labelText: label ,
          hintText: hint
      ),
    );
  }
}
