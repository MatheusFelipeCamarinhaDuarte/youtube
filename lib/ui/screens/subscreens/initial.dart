
import 'package:flutter/material.dart';
import 'package:youtube/app/key/api.dart';

import 'package:youtube/app/viewmodel/initial_viewmodel.dart';
import 'package:youtube/main.dart';
import 'package:youtube/ui/screens/player_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


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
  void initState() {
    super.initState();
    // Faz a construção inicial antes da interface
    print("Chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Usado para quando você possui dependencias para construir a interface
    // e que sem elas, você não precisa construir a interface
    print("Chamado 2 - didChangeDependencies");
  }
  @override
  void dispose() {
    super.dispose();
    // este aqui só é feito quando há o encerramento do uso.
    // Todos devem ser chamado antes deste.
    // Este aqui tbm é suado para não deixar métodos de StateFull
    // em aberto consumindo memória desnecessáriamente
    print("Chamado Ultimo 4 - Dispose");
  }

  @override
  void didUpdateWidget(covariant Initial oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Este aqui é chamado quando um widget é chamado acima deste e retornam com ele.
    // Chama junto o build
    print("Chamado 2 - didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    // Aqui você constrói a interface gráfica
    print("Chamado 3 - build");

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
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder:
                                    (context) =>PlayerScreen(videoId: viewmodel.videosList[index].url)
                                )
                            );
                          },
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
