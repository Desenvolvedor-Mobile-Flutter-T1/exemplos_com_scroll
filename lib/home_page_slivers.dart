import 'package:flutter/material.dart';

class HomePageSlivers extends StatefulWidget {
  const HomePageSlivers({super.key});

  @override
  State<HomePageSlivers> createState() => _HomePageSliversState();
}

class _HomePageSliversState extends State<HomePageSlivers> {
  List numeros = List.generate(40, (index) => 'Número = $index');

  ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green,
              expandedHeight: 200,
              pinned: true, //Faz ele fica fixo como uma appbar do scafold
              floating: false, //Faz ele só extender quando voltar ao topo
              title: Text(
                'Rumo ao hexa!',
                style: TextStyle(color: Colors.white, fontWeight: .bold),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://img.magnific.com/fotos-premium/bandeira-nacional-do-brasil-fundo-com-bandeira-do-brasil_659987-19394.jpg?semt=ais_hybrid&w=740&q=80',
                  fit: .cover,
                ),
              ),
            ),
            SliverToBoxAdapter(child: Text('List')),
            SliverList.builder(
              itemCount: numeros.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(numeros[index])),
            ),
            SliverToBoxAdapter(child: Text('Grids')),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: numeros.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(numeros[index])),
            ),
          ],
        ),
      ),
    );
  }
}
