import 'package:flutter/material.dart';

class RegistrationStepTop extends StatelessWidget {
  final String header;
  final int step;
  const RegistrationStepTop({
    Key key,
    @required this.header,
    this.step = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/cambuzz_icon.png',
                width: 90,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cambuzz',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w900,
                        fontSize: 36),
                  ),
                  Text(
                    'For TKM',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ]),
        SizedBox(
          height: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.header,
              style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10),
            Text(
              this.step != -1
                  ? "Step ${this.step.toString()} of 3"
                  : "You're all set to use the app",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 18,
                shadows: <Shadow>[
                    Shadow(
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
