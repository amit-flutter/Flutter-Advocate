import 'package:advocate/utils/constant/style.dart';
import 'package:advocate/utils/imports.dart';

class WidgetConst {
  static Widget kHeightSpacer({double heightMultiplier = 1}) => SizedBox(height: 10 * heightMultiplier);
  static Widget kWidthSpacer({double widthMultiplier = 1}) => SizedBox(width: 10 * widthMultiplier);

  Future<void> showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String button1Text,
    required String button2Text,
    required Function() button1OnTap,
    required Function() button2OnTap,
  }) =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                onPressed: button1OnTap,
                child: Text(button1Text),
              ),
              TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                onPressed: button2OnTap,
                child: Text(button2Text),
              ),
            ],
          );
        },
      );
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.style = const TextStyle(fontSize: 22, color: Colors.white,height: 2),
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.borderRadius = 7,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;
  final double borderRadius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          // padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          // elevation: MaterialStateProperty.all(8),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
        ),
        child: DefaultText(text: text, maxLines: maxLines, style: style, textAlign: textAlign),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.keyBoardType,
    this.isHideTitle = false,
    this.isSecureText = false,
    this.isSuffixIcon = false,
    this.validation,
    required this.textFieldController,
  }) : super(key: key);

  final String title;
  final TextInputType keyBoardType;
  final bool isHideTitle;
  final bool isSecureText;
  final bool isSuffixIcon;

  final String? Function(String?)? validation;
  final TextEditingController textFieldController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            text: widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryColor),
          ),
          WidgetConst.kHeightSpacer(heightMultiplier: 0.5),
          TextFormField(
            keyboardType: widget.keyBoardType,
            obscureText: widget.isSecureText && _passwordVisible,
            validator: widget.validation,
            controller: widget.textFieldController,
            decoration: InputDecoration(
              //  labelText: widget.title,
              hintText: "enter ${widget.title.toLowerCase()}",

              // hintStyle: WidgetConst.kHighLightDark18.copyWith(color: Colors.grey),
              suffixIcon: widget.isSuffixIcon
                  ? IconButton(
                      padding: const EdgeInsets.only(right: 20),
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        // color: ColorConst.kHighLight3,
                        size: 30,
                      ),
                      onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultText extends StatelessWidget {
  const DefaultText({
    Key? key,
    required this.text,
    this.style = StyleConst.kDefaultTextStyle,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign, maxLines: maxLines);
  }
}
