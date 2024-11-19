import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class readBookWidget extends StatelessWidget {
  const readBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return       // Figma Flutter Generator Group479Widget - GROUP
      SizedBox(
          width: 390,
          height: 844,

          child: Stack(
              children: <Widget>[
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 390,
                        height: 844,
                        decoration: const BoxDecoration(
                          gradient : LinearGradient(
                              begin: Alignment(6.123234262925839e-17,1),
                              end: Alignment(-1.99,6.123234262925839e-17),
                              colors: [Color.fromRGBO(255, 236, 208, 1), Color.fromRGBO(255, 57, 116, 1)]
                          ),
                        ),
                        child: Stack(
                            children: <Widget>[
                              const Positioned(
                                  top: 49,
                                  left: 160,
                                  child: SizedBox(
                                      width: 71,
                                      height: 25,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Text('Books', textAlign: TextAlign.center, style: TextStyle(
                                                    color: Color.fromRGBO(255, 236, 208, 1),
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 22,
                                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                    fontWeight: FontWeight.normal,
                                                    height: 1
                                                ),)
                                            ),
                                          ]
                                      )
                                  )
                              ),const Positioned(
                                  top: 46,
                                  left: 332,
                                  child: SizedBox(
                                      width: 37,
                                      height: 26.875398635864258,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 17,
                                                child: FaIcon(
                                                  FontAwesomeIcons.plus, //
                                                  size: 22,
                                                  color: Color.fromRGBO(255, 236, 208, 1),
                                                ),
                                            ),Positioned(
                                                top: 5,
                                                left: 0,
                                                child: FaIcon(
                                                  FontAwesomeIcons.solidHeart, //
                                                  size: 22,
                                                  color: Color.fromRGBO(255, 236, 208, 1),
                                                ),
                                            ),
                                          ]
                                      )
                                  )
                              ),Positioned(
                                  top: 109,
                                  left: 0,
                                  child: SizedBox(
                                      width: 390,
                                      height: 246,

                                      child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Container(
                                                    width: 390,
                                                    height: 246,
                                                    decoration: const BoxDecoration(
                                                      gradient : LinearGradient(
                                                          begin: Alignment(6.123234262925839e-17,1),
                                                          end: Alignment(-1,6.123234262925839e-17),
                                                          colors: [Color.fromRGBO(255, 236, 208, 1),
                                                            Color.fromRGBO(255, 236, 208, 1)]
                                                      ),
                                                    )
                                                )
                                            ),Positioned(
                                                top: 16,
                                                left: 117,
                                                child: Container(
                                                    width: 156,
                                                    height: 214,
                                                    decoration: const BoxDecoration(
                                                      boxShadow : [BoxShadow(
                                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                                          offset: Offset(15,4),
                                                          blurRadius: 4
                                                      )],
                                                      image : DecorationImage(
                                                          image: AssetImage('assets/images/book1.png'),
                                                          fit: BoxFit.fitWidth
                                                      ),
                                                    )
                                                )
                                            ),const Positioned(
                                                top: 16,
                                                left: 361,
                                                child: FaIcon(
                                                  FontAwesomeIcons.ellipsisV,
                                                  size: 22,
                                                  color: Colors.black,
                                                ),
                                            ),
                                          ]
                                      )
                                  )
                              ),
                            ]
                        )
                    )
                ),
              ]
          )
      );
  }

}