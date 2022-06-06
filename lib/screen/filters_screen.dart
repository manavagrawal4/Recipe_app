import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function _saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this._saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;

    super.initState();
  }

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget buildSwitchTile(
    bool currentValue,
    String title,
    String description,
    Function(bool) changeValue,
  ) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: changeValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget._saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchTile(
                _glutenFree,
                'Gluten-Free',
                'Only includes gluten-free meals',
                (bool newValue) {
                  setState(
                    () {
                      _glutenFree = newValue;
                    },
                  );
                },
              ),
              buildSwitchTile(_lactoseFree, 'Lactose-Free',
                  'Only includes lactose-free meals', (bool newValue) {
                setState(
                  () {
                    _lactoseFree = newValue;
                  },
                );
              }),
              buildSwitchTile(_vegan, 'Vegan', 'Only includes vegan meals',
                  (bool newValue) {
                setState(
                  () {
                    _vegan = newValue;
                  },
                );
              }),
              buildSwitchTile(
                  _vegetarian, 'Vegetarian', 'Only includes vegetarian meals',
                  (bool newValue) {
                setState(
                  () {
                    _vegetarian = newValue;
                  },
                );
              }),
            ],
          ))
        ],
      ),
    );
  }
}
