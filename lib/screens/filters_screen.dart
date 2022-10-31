import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutinFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutinFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    super.initState();
  }

  Widget _buildSwitchListStyle(String title, String description,
      bool currentvalue, Function(dynamic) updateValue) {
    return SwitchListTile(
      value: currentvalue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutinFree,
                    'lactose': _lactoseFree,
                    'vegetarian': _vegetarian,
                    'vegan': _vegan,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListStyle('Gluten-free',
                    'Only include gluten-free meals.', _glutinFree, (newvalue) {
                  setState(() {
                    _glutinFree = newvalue;
                  });
                }),
                _buildSwitchListStyle(
                    'Lactose-free',
                    'Only include lactose-free meals.',
                    _lactoseFree, (newvalue) {
                  setState(() {
                    _lactoseFree = newvalue;
                  });
                }),
                _buildSwitchListStyle('Vegetarian-free',
                    'Only include vegetarian meals.', _vegetarian, (newvalue) {
                  setState(() {
                    _vegetarian = newvalue;
                  });
                }),
                _buildSwitchListStyle(
                    'Vegan-free', 'Only include vegan meals.', _vegan,
                    (newvalue) {
                  setState(() {
                    _vegan = newvalue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
