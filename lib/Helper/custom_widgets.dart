import 'const_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ScaffoldMessengerState customSnackBar({
  required String text,
  required BuildContext context ,
  final BorderRadius? borderRadius ,
  final EdgeInsets? padding ,
  final Duration? duration ,
  final SnackBarAction? snackBarAction
}) {
  return ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
      SnackBar(
          content: CustomText(text: text),
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(0.0)),
          padding: padding ,
          duration: duration ?? const Duration(seconds: 1) ,
          action: snackBarAction
      ));
}


Future<void> customAlertDialog({
  required VoidCallback onPressed ,
  required BuildContext context
}){
  return showDialog(context: context, builder: (buildContext)=>AlertDialog(
    title: CustomText(text: '${context.translate!.translate(MainEnum.textSure.name)}'),
    actions: [
      CustomElevatedButton(
          onPressed: (){
        Navigator.pop(context);
      }, child: Text('${context.translate!.translate(MainEnum.textNo.name)}')),
      CustomElevatedButton(
          onPressed: onPressed, child: Text('${context.translate!.translate(MainEnum.textYes.name)}')),
    ],
  ));
}


Future<void> customModalBottomSheet({
  required Widget widgets ,
  required BuildContext context
}) async {
  return await showModalBottomSheet(context: context, builder: (buildContext)=>widgets);
}


ScaffoldMessengerState customMaterialBanner({
  required BuildContext context ,
  required String text ,
  required List<Widget> actions ,
  Widget? leading
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(MaterialBanner(
        leading: leading ,
        content: Text(text) ,
        actions: actions
    ));
}


Future<bool> customExitApp({required DateTime dateTime}) async {
  final Duration varDifference = DateTime.now().difference(dateTime);
  final isExitWarning = varDifference >= const Duration(seconds: 2);
  dateTime = DateTime.now();

  if(isExitWarning){
    await Fluttertoast.showToast(msg: 'Press back again to exit',fontSize: 17.0);
    return false;
  }else{
    await Fluttertoast.cancel();
    return true;
  }
}


/// Text

class CustomText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;

  const CustomText({
    Key? key,
    this.decoration,
    required this.text,
    this.maxLine,
    this.style,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  Text build(BuildContext context) {

    return Text(
        text ,
        //textDirection: TextDirection.ltr,
        style: style ??  TextStyle(
            fontFamily: 'lato',
            fontSize: fontSize ?? 15.0,
            fontWeight: fontWeight ,
            color: color,
            decoration: decoration ?? TextDecoration.none
        ),
        textScaleFactor: 1.0 ,
        maxLines: maxLine ?? 1 ,
        overflow: overflow ?? TextOverflow.ellipsis
    );
  }
}



class AnimatedText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  const AnimatedText({Key? key,this.decoration,required this.text, this.maxLine, this.style, this.overflow, this.fontSize, this.fontWeight, this.color,}) : super(key: key);

  @override
  AnimatedDefaultTextStyle build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      child: Text(
        text,
        textScaleFactor: 1.0 ,
      ),

      maxLines: maxLine ?? 1 ,
      style: style ?? TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight ,
          overflow: overflow ?? TextOverflow.ellipsis ,
          decoration: decoration ?? TextDecoration.none
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

}

/// Buttons

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;

  const CustomTextButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );
  }
}


class CustomTextIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;

  const CustomTextIconButton({
    Key? key ,
    this.padding ,
    this.elevation ,
    this.borderRadius ,
    this.size ,
    this.backGroundColor ,
    required this.onPressed,
    required this.child ,
    required this.icon ,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        icon: icon,
        label: child
    );
  }
}


class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide ;

  const CustomOutlinedButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child,
    this.borderSide
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          side: borderSide,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );
  }
}


class CustomOutlinedIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide;

  const CustomOutlinedIconButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child,
    this.borderSide ,
    required this.icon
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: padding,
        elevation: elevation,
        minimumSize: size,
        side: borderSide,
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(0)
        ),
      ) ,
      onPressed: onPressed ,
      icon: icon ,
      label: child ,
    );
  }
}


class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Color? backGroundColor ;
  final Size? size ;

  const CustomElevatedButton({
    Key? key,
    this.padding,
    this.backGroundColor,
    this.elevation,
    this.borderRadius,
    this.size,
    required this.onPressed,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );

  }
}


class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide;


  const CustomElevatedIconButton({
    Key? key ,
    this.padding ,
    this.elevation ,
    this.borderRadius ,
    this.size ,
    this.backGroundColor ,
    required this.onPressed ,
    required this.child ,
    this.borderSide ,
    required this.icon
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        icon: icon ,
        label: child
    );
  }
}