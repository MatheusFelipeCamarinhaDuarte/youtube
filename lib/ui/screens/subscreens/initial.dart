
import 'package:flutter/material.dart';

import 'package:youtube/app/viewmodel/initial_viewmodel.dart';

// ignore: must_be_immutable
class Initial extends StatefulWidget {
  String search;
  Initial({super.key, required this.search});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {

  InitialViewmodel viewmodel = InitialViewmodel();

  Future<void> refreshGetAll() async{
    setState(() {
      widget.search = '';
      viewmodel = InitialViewmodel();
    });
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: refreshGetAll,
      color: Colors.red,
      child: FutureBuilder(
        future: viewmodel.getVideoSearched(widget.search),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if(snapshot.hasData){
                return CustomScrollView(slivers: [
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(viewmodel.videosList[index].image),fit: BoxFit.cover)
                              ),
                            ),
                            ListTile(
                              title: Text(viewmodel.videosList[index].title),
                              subtitle: Text(viewmodel.videosList[index].channel),
                            )

                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 2, color: Colors.grey,),
                    itemCount: viewmodel.videosList.length,

                  ),
                ]);
              } else{
                return Center(child: Text("Nenhum dado a ser exibido"),);
              }
          }
        },

      ),
    );
  }
}
