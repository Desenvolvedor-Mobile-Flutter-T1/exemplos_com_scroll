import 'package:flutter/material.dart';

class HomePageInfiniteScroll extends StatefulWidget {
  const HomePageInfiniteScroll({super.key});

  @override
  State<HomePageInfiniteScroll> createState() => _HomePageInfiniteScrollState();
}

class _HomePageInfiniteScrollState extends State<HomePageInfiniteScroll> {
  List numeros = List.generate(40, (index) => 'Número = $index');

  ScrollController controller = ScrollController();

  void addNumbers(int lastNumber) {
    numeros.addAll(
      List.generate(30, (index) => 'Número = ${lastNumber + index}'),
    );
  }

  Map map = {"hasMore": true, "page": 3, "products": []};
  late VoidCallback addMoreInTheEnd;

  @override
  void initState() {
    addMoreInTheEnd = () {
      if (controller.position.pixels >=
          (controller.position.maxScrollExtent - 80)) {
        //pixels é a posição atual do scroll, maxScrollExtend é a parte final
        setState(() {
          addNumbers(numeros.length);
        });
      }
    };
    controller.addListener(
      addMoreInTheEnd,
    ); //Todas vez que a tela sobrer scroll ele vai chamar
    //a função que vai verificar se chegou no fim da lista, se chegou vai adicionar mais itens.
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(addMoreInTheEnd);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 43, 75, 44)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: () {
          controller.position.animateTo(
            //Recurso pra ir de uma posição pra outra do scroll com animação
            //No código aqui ele vai pro final da lista, se ao invés de max colocasse min ele iria para o começo
            controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        },
      ),
      body: Stack(
        // Permite Widget se sobreporem, a regra é: O primeiro da lista fica por baixo do seguinte
        children: [
          Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Expanded(
                  //Entre uma Column / Row e um item de scroll precisa ter algum elemento que dite o tamanho máximo para o filho
                  //No caso aqui, o expanded olha pro Column, recebe a altura da tela e passa para o ListView
                  child: ListView.builder(
                    controller: controller,
                    itemCount: numeros.length, //Quantidade de itens na lista
                    itemBuilder: (context, index) {
                      return Container(
                        margin: .all(4),
                        height: 40,
                        color: Colors.lightBlueAccent,
                        child: Text(numeros[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            //Esse item ficara por cima da lista posicionado na parte de baixo central
            bottom: 20,
            left: 0,
            right: 0,

            child: Icon(Icons.ac_unit_rounded),
          ),
        ],
      ),
    );
  }
}
