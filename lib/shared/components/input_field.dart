import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  const InputField({Key? key,
    required this.title,
    required this.note,
    this.controller,
    required this.onTap,
    this.widget,
  }) : super(key: key);

  final String title ;
  final String note ;
  final TextEditingController? controller ;
  final Widget? widget ;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:  const EdgeInsets.only(top : 16),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,),
        Container(
        padding: const EdgeInsets.only(left: 14),
        margin:  const EdgeInsets.only(top: 8),
        height: MediaQuery.of(context).size.height / 13,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
        color: Color(0XFF408080),
        )
        ),
        child: Row(
          children: [
            Expanded(child:
            TextFormField(
              onTap: onTap,
              controller: controller,
              autofocus: false,
              cursorColor: const Color(0XFF408080),
              readOnly: widget != null ? true : false,
              decoration: InputDecoration(
                hoverColor: const Color(0XFF408080),
                hintText: note,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).backgroundColor,
                    width: 0,
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).backgroundColor,
                        width: 0,
                    )
                ),
              ),
            ),
            ),
            widget ?? Container(),
          ],
        )
        ),
      ],
    ),
    );
  }
}
