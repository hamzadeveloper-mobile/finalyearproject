import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expilert/constants.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  void itemScreen() async {
    await for (var snapshot
        in _firestore.collection('entereditemsdata').snapshots()) {
      for (var itemsPresent in snapshot.docs) {
        print(itemsPresent.data());
      }
    }
  }

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formattedDate = formatter.format(now);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ItemsStream(
          todayDate: formattedDate,
        ),
      ),
    );
  }
}

class ItemsStream extends StatelessWidget {
  final String todayDate;
  ItemsStream({this.todayDate});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('entereditemsdata').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        List<Widget> itemCards = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        String theDatabaseDate;
        final items = snapshot.data.docs;

        for (var item in items) {
          final itemData = item.data();
          final productName = itemData['productName'];
          final expiryDate = itemData['expiryDate'];
          final openingDate = itemData['openingDate'];
          final noOfItems = itemData['noOfItems'];

          final itemCard = ItemsCard(
            pName: productName,
            eDate: expiryDate,
            oDate: openingDate,
            noOfItems: noOfItems,
            tDate: todayDate,
          );
          theDatabaseDate = itemData['expiryDate'];

          itemCards.add(Dismissible(
              key: ObjectKey(snapshot.data.docs.elementAt(0)),
              onDismissed: (direction) async {
                _firestore.collection('entereditemsdata').doc(item.id).delete();
              },
              child: itemCard));
        }

        return Expanded(
          child: ListView(
            children: itemCards,
          ),
        );
      },
    );
  }
}

class ItemsCard extends StatelessWidget {
  ItemsCard({this.pName, this.eDate, this.oDate, this.noOfItems, this.tDate});

  final String pName;
  final String eDate;
  final String oDate;
  final String noOfItems;
  final String tDate;
  final bool condition = false;

  Color cardColorChanger() {
    if (eDate == tDate) {
      return Color(0xff990000);
    } else {
      return Color(0xffFDDB27);
    }
  }

  Color pNameColorChanger() {
    if (eDate == tDate) {
      return Color(0xffff7373);
    } else {
      return Color(0xff00B1D2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 120,
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: cardColorChanger(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                    child: Text(
                      pName,
                      style: TextStyle(
                        color: pNameColorChanger(),
                        fontFamily: 'Avenir',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                      'Opening Date: $oDate',
                      style: kItemsCardTextStyling,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Text(
                      'Expiry Date: $eDate',
                      style: kItemsCardTextStyling,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Text(
                      'Number of Items: $noOfItems',
                      style: kItemsCardTextStyling,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
