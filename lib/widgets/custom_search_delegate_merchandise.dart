import 'package:flutter/material.dart';
import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/logic/major_minis_logic.dart';
import 'package:major_kill_minis/pages/view_merch.dart';
import 'package:major_kill_minis/pages/view_mini.dart';

class MySearchDelegateMerch extends SearchDelegate{
  int indexValue = 0;
  final List _list = MajorMiniLogic.getSearchMerch();
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear, color: iconColor,)
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back, color: iconColor,)
  );

  @override
  Widget buildResults(BuildContext context) => _list.isNotEmpty ? ListTile(
    leading: Image.network(_list[indexValue].images[0]),
    title: Text(_list[indexValue].name),
    subtitle: Text('CAD\$${_list[indexValue].price.toString()}0', style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMerch(merch: _list[indexValue])));
    },
  ) :  Center(child: Text('Could not find $query'),);

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = _list.where((element) {
      final elementNameComparison = element.name.toLowerCase();
      final input = query.toLowerCase();
      return elementNameComparison.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context , index) {
        if (suggestions.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Data not currently available please wait')
            ],
          ),);
        }else{
          return ListTile(
            leading: Image.network(suggestions[index].images[0]),
            title: Text(suggestions[index].name),
            subtitle: Text('CAD\$${suggestions[index].price.toString()}0', style: const TextStyle(color: textColor, fontWeight: FontWeight.bold),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewMerch(merch: suggestions[index])));
            },
          );
        }//end if-else
      },
      itemCount: suggestions.length,
    );
  }

}