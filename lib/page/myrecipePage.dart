import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

const kDefaultPadding = 10.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12,
);

class GetImage extends StatelessWidget {
  final String documentId;

  GetImage({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference Recipe =
        FirebaseFirestore.instance.collection('Recipe');

    return FutureBuilder<DocumentSnapshot>(
      future: Recipe.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Image.network('${data['imageURl']}');
        }
        return Text('Loading');
      }),
    );
  }
}

class GetRecipes extends StatelessWidget {
  final String documentId;

  GetRecipes({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference Recipe =
        FirebaseFirestore.instance.collection('Recipe');

    return FutureBuilder<DocumentSnapshot>(
      future: Recipe.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Size size = MediaQuery.of(context).size;
          // it enable scrolling on small devices
          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: new InkWell(
                            onTap: () {
                              print(documentId);
                            },
                            child: Hero(
                              tag: '${data['Recipe Title']}',
                              child: Image.network(
                                '${data['imageURl']}',
                                fit: BoxFit.cover,
                                width: 350,
                                height: 150,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 3),
                          child: Text(
                            '${data['Recipe Category']}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          '${data['Recipe Description']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: kSecondaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Text(
                            '${data['Recipe Ingredients']}',
                            style: TextStyle(color: kTextLightColor),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text('Loading');
      }),
    );
  }
}
