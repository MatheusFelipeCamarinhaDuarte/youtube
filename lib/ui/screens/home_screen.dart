import 'package:flutter/material.dart';
import 'package:youtube/ui/components/custom_search_delegate.dart';
import 'package:youtube/ui/screens/subscreens/initial.dart';
import 'package:youtube/ui/screens/subscreens/library.dart';
import 'package:youtube/ui/screens/subscreens/subscription.dart';
import 'package:youtube/ui/screens/subscreens/whatshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Initial(search: _result),
      Whatshot(),
      Subscription(),
      Library(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/youtube.png", width: 98, height: 22),
        //title: Text("Youtube"),
        iconTheme: IconThemeData(
          color: Colors.grey,
          // opacity: 1
        ),
        actions: [
          // IconButton(onPressed: (){ print("Ação: videocam");}, icon: Icon(Icons.videocam)),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
                String res = await showSearch(context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _result = res;
                });
            },
          ),
          // IconButton(onPressed: (){ print("Ação: account circle");}, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Carrega TODA vez que clica nela
        child: screens[_currentIndex],
        // Carrega apenas uma vez e permanece em cache seu resultado (Cuidado, pode ser que sua tela trave na mesma coisa!)
        // child: IndexedStack(index: _currentIndex,children: screens,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        // Cria um efeito de cada um ter sua prórpia cor de fundo para a barra
        // type: BottomNavigationBarType.shifting,

        // Deixa todos fixos.
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        items: [
            // os backgrounds só funcionam no shifting
        BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.home), label: "Inicio"
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
            icon: Icon(Icons.whatshot), label: "Em alta"
        ),
        BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.subscriptions), label: "Incrições"
        ),
        BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.library_add), label: "Biblioteca"
        ),

      ])
    );
  }
}
