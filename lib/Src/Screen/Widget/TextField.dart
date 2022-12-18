import 'package:flutter/material.dart';
import '../../Const/Const.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? fieldController;
  final Widget? child;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const InputField({
    super.key,
    required this.title,
    required this.hint,
    this.fieldController,
    this.validator,
    this.onFieldSubmitted,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Themes.titleStyle,
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: Themes.titleStyle,
                  obscureText: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    hintText: hint,
                    filled: true,
                    hintStyle: Themes.subTitleStyle,
                  ),
                  controller: fieldController,
                  validator: validator,
                  onFieldSubmitted: onFieldSubmitted,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
