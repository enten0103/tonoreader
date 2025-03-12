import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/tool/margin.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReversedColumn(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
        ),
        Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
        Margin(
            margin: EdgeInsets.only(),
            child: Column(children: [
              Container(
                height: 100,
                width: double.infinity,
                margin: EdgeInsets.only(top: 40),
                color: Colors.green,
                child: Text("12"),
              )
            ])),
        Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(top: 40),
          color: Colors.black,
        ),
        Container(
          height: 100,
          margin: EdgeInsets.only(top: 40),
          width: 100,
          color: Colors.blue,
        )
      ],
    );
  }
}
