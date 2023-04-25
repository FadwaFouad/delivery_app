import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<String> buttonsTitle = ["All", "Food", "Dessert", "Drinks", "Pizza"];
  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ListView.builder(
        itemCount: buttonsTitle.length,
        itemBuilder: (BuildContext context, int id) {
          return MyCustomButton(
            title: buttonsTitle[id],
            active: id == _active ? true : false,
            onTap: () {
              setState(() {
                _active = id;
              });
            },
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class MyCustomButton extends StatelessWidget {
  final bool active;
  final String title;
  final onTap;
  const MyCustomButton(
      {super.key, required this.active, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 115,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: !active ? Border.all(color: Colors.grey.shade100) : null,
            borderRadius: BorderRadius.circular(21.0),
            gradient: active
                ? LinearGradient(colors: [Colors.yellow, Colors.orange])
                : null,
            color: active ? null : Colors.white,
            boxShadow: [
              active
                  ? BoxShadow(
                      color: Colors.yellow,
                      offset: Offset(0, 3),
                      blurRadius: 5.0,
                    )
                  : BoxShadow()
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 5.0),
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
          child: Text(
            title,
            style: TextStyle(color: active ? Colors.white : Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
