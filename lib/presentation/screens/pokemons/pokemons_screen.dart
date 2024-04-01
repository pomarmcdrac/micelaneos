import 'package:flutter/material.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PokemonsView(),
    );
  }
}

class PokemonsView extends StatefulWidget {
  const PokemonsView({super.key});

  @override
  State<PokemonsView> createState() => _PokemonsViewState();
}

class _PokemonsViewState extends State<PokemonsView> {

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        _PokemonGrid()
      ],
    );
  }
}

class _PokemonGrid extends StatelessWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          //TODO onTab
          child: Image.network(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index+1}.png',
          ),
        );
      },
    );
  }
}