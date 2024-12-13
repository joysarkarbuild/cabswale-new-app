import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      this.textEditingController,
      this.hintText = '',
      this.readOnly = false,
      this.validator,
      this.onChanged,
      this.prefixicon,
      this.maxLine = 1,
      this.maxLenght,
      this.keyboardType = TextInputType.name,
      this.textInputAction = TextInputAction.done,
      this.borderRadius,
      this.label = ''});

  final TextEditingController? textEditingController;
  final String hintText;
  final String label;
  final int maxLine;
  final int? maxLenght;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onChanged;
  final Widget? prefixicon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool readOnly;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != '')
            Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            maxLines: maxLine,
            keyboardType: keyboardType,
            enabled: !readOnly,
            controller: textEditingController,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: maxLine > 1 ? 10 : 1),
                border: OutlineInputBorder(
                    borderRadius: borderRadius != null
                        ? BorderRadius.all(Radius.circular(borderRadius!))
                        : BorderRadius.zero),
                hintText: hintText,
                prefixIcon: prefixicon),
            maxLength: maxLenght,
            validator: validator ??
                (value) {
                  return null;
                },
            onChanged: onChanged ?? (value) {},
          ),
        ],
      ),
    );
  }
}

class MyTextFormField2 extends StatelessWidget {
  const MyTextFormField2(
      {super.key,
      required TextEditingController textEditingController,
      this.hintText = '',
      this.readOnly = false,
      this.validator,
      this.maxLine = 1,
      this.keyboardType = TextInputType.name,
      this.label = ''})
      : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String hintText;
  final String label;
  final int maxLine;
  final String? Function(String? value)? validator;
  final TextInputType keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (label != '')
          //   Text(
          //     label,
          //     style: const TextStyle(fontSize: 15),
          //   ),
          // const SizedBox(
          //   height: 10,
          // ),
          TextFormField(
              maxLines: maxLine,
              keyboardType: keyboardType,
              enabled: !readOnly,
              controller: _textEditingController,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: maxLine > 1 ? 10 : 1),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                label: Text(label),
                hintText: hintText,
              ),
              validator: validator ??
                  (value) {
                    return null;
                  }),
        ],
      ),
    );
  }
}
