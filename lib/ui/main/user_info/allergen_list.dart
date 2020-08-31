import 'package:allerternatives/models/user.dart';
import 'package:allerternatives/models/user_data.dart';
import 'package:allerternatives/ui/main/user_info/allergen_box.dart';
import 'package:allerternatives/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllergenList extends StatefulWidget {
  @override
  _AllergenListState createState() => _AllergenListState();
}

class _AllergenListState extends State<AllergenList> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<UserData>(context) != null) {
      final user = Provider.of<User>(context);
      UserData allergens = Provider.of<UserData>(context) ?? [];
      UserData userdata =
          UserData(uid: user.uid, allergenz: allergens.allergens);

      print(userdata.allergens);

      return ListView.builder(
        itemCount: userdata.totalLength,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return AllergenBox(allergenName: userdata.allergens[index]);
        },
      );
    } else {
      return Loading();
    }
  }
}
