import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchBarDemo extends StatefulWidget {
  const SearchBarDemo({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  ScrollController _scrollController = ScrollController();
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isSearchVisible = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isSearchVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrolling Search Bar'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isSearchVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 400),
        child: FloatingActionButton(
          onPressed: () {
            // Your action when the search button is pressed
          },
          tooltip: 'Search',
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
