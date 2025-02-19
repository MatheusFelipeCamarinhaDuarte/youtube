import 'package:flutter/material.dart';

class CustomSearchDelegate  extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: (){
        query = '';
      }, icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // print("resultado final $query");
    close(context, query.toString());
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // print("O que estou digitando: $query");

    List<String> list = [];

    if(query.isNotEmpty){
      list = ["Andorid", "IOS", "TESTE","ALGO", "SEI LÁ CARA", "ME AJUDAAAAA", "SOCOROOOOO"]
          .where((text) => text.toLowerCase().startsWith(query.toLowerCase())).toList();
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              close(context,list[index]);
            },
            title: Text(list[index]),
          );
        },
      );
    } else {
      return Center(child: Text("Nenhum dado encontrado para sua pesquisa"),);
    }

  }
}