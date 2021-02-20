import 'package:flutter/material.dart';

class CardFrontLayout {
  String bankName;
  String cardNumber;
  String cardExpiry;
  String cardHolderName;
  Widget cardTypeIcon;
  double cardWidth;
  double cardHeight;
  Color textColor;
  double textfont;

  CardFrontLayout(
      {this.bankName = "",
      this.cardNumber = "",
      this.cardExpiry = "",
      this.cardHolderName = "",
      this.cardTypeIcon,
      this.cardWidth = 0,
      this.cardHeight = 0,
      this.textfont = 12.5,
      this.textColor});

  Widget layout1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Center(
                  child: Text(
                    bankName,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontFamily: "MavenPro",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Image.asset('images/key.png',
                      fit: BoxFit.fitHeight,
                      width: 30.0,
                      height: 30.0,
                      color: textColor),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              cardNumber == null || cardNumber.isEmpty
                  ? 'XXXX XXXX XXXX XXXX'
                  : cardNumber,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "MavenPro",
                  fontSize: textfont),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           height: 15,
//                         ),
// ,
//                       ],
//                     ),
                    Expanded(
                      child: Text(
                        cardHolderName == null || cardHolderName.isEmpty
                            ? "PassWord"
                            : cardHolderName,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            package: 'awesome_card',
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "MavenPro",
                            fontSize: 17),
                      ),
                    ),
                    cardTypeIcon
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
