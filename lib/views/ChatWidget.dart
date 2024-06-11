import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ChatWidget - FRAME
    return Container(
        width: 360,
        height: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1, 3.078285231087447e-15),
              end: Alignment(-1.4043778736905514e-15, -4.938271999359131),
              colors: [
                Color.fromRGBO(119, 18, 18, 1),
                Color.fromRGBO(49, 12, 12, 1)
              ]),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 681,
              left: 265,
              child: Container(
                  width: 153,
                  height: 45,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 160,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Mychatshape.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        top: 14,
                        left: 120,
                        child: Container(
                            width: 21,
                            height: 21,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 21,
                                      height: 21,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/Read.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                            ]))),
                    Positioned(
                        top: 14,
                        left: 15,
                        child: Text(
                          'Hallo juga',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Sansation',
                              fontSize: 16,
                              letterSpacing: -0.30000001192092896,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                    Positioned(
                        top: 20,
                        left: 93,
                        child: Text(
                          '11:43',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Sansation',
                              fontSize: 11,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                  ]))),
          Positioned(
              top: 629,
              left: 2,
              child: Container(
                  width: 113,
                  height: 43,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 113,
                            height: 43,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Chatshape.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        top: 10,
                        left: 23,
                        child: Text(
                          'Hallo ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Sansation',
                              fontSize: 16,
                              letterSpacing: -0.30000001192092896,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                    Positioned(
                        top: 15,
                        left: 63,
                        child: Text(
                          '11:45',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Sansation',
                              fontSize: 11,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                  ]))),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 440,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(166, 166, 170, 1),
                          offset: Offset(0, 0.33000001311302185),
                          blurRadius: 0)
                    ],
                    color: Color.fromRGBO(18, 18, 18, 1),
                  ))),
          Positioned(
              top: 44,
              left: 123,
              child: Container(
                  width: 55,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    image: DecorationImage(
                        image: AssetImage('assets/Image4.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 60,
              left: 185.239990234375,
              child: Text(
                'Kelvyn',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Sansation',
                    fontSize: 16,
                    letterSpacing: -0.30000001192092896,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    decoration: TextDecoration.none),
              )),
          Positioned(
              top: 78.5,
              left: 185.239990234375,
              child: Text(
                'Subik Tugas',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Sansation',
                    fontSize: 12,
                    letterSpacing: -0.009999999776482582,
                    fontWeight: FontWeight.normal,
                    height: 1.3333333333333333,
                    decoration: TextDecoration.none),
              )),
          Positioned(top: 1, left: -5, child: Container()),
          Positioned(
              top: 75,
              left: 370,
              child: Container(
                  width: 30,
                  height: 20,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/lingkaran.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        top: 0,
                        left: 10,
                        child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/lingkaran.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        top: 0,
                        left: 20,
                        child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/lingkaran.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                  ]))),
          Positioned(
              top: 70,
              left: 25,
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon_arrow_left.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 732,
              left: 0,
              child: Container(
                  width: 440,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(166, 166, 170, 1),
                          offset: Offset(0, -0.33000001311302185),
                          blurRadius: 0)
                    ],
                    color: Color.fromRGBO(18, 18, 18, 1),
                  ))),
          Positioned(
              top: 772,
              left: 46.776123046875,
              child: Container(
                  width: 300.8800048828125,
                  height: 100.200000762939453,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 250.8800048828125,
                            height: 35.200000762939453,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              color: Color.fromRGBO(255, 255, 255, 1),
                              border: Border.all(
                                color: Color.fromRGBO(142, 142, 147, 1),
                                width: 0.5,
                              ),
                            ))),
                  ]))),
          Positioned(
              top: 773,
              left: 11,
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/Icon_add.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 773,
              left: 380,
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon_arrow_right.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 768,
              left: 326,
              child: Container(
                  width: 28,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }
}
