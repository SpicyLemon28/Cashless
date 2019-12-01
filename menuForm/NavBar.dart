import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int selectedIndex = 0;

  List<NavItem> items = [
    NavItem(Icon(Icons.home), Text('Home')),
    NavItem(Icon(Icons.add), Text('Deposit')),
    NavItem(Icon(Icons.receipt), Text('Transaction')),
  ];

  Widget _buildItem(NavItem item, bool isSelected){
      return Row(
        children: <Widget>[
          item.icon, item.title
        ],
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        height: 56,
         width: MediaQuery.of(context).size.width,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: items.map((item){

            return GestureDetector(
              onTap: (){
                
              },
              child: _buildItem(item, false),
            ); 
           }).toList(),
         ),
      );
    }
  }
  
  class NavItem {
    final Icon icon;
    final Text title;

    NavItem(this.icon, this.title);
}