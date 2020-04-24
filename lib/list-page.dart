import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'model/paper.model.dart';
import 'form-page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Paper> _papers = [Paper(name: 'MGLU3F'), Paper(name: 'ITSA4F')];

  Future<void> _addPaper() async {
    // Navigate to home page
    var paper = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPage(),
        ));
    if (paper != null) {
      setState(() {
        _papers.add(paper);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _papers
              .map((paper) => Text(
                    paper.name,
                    style: Theme.of(context).textTheme.display1,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPaper,
        tooltip: 'Add Paper',
        child: Icon(Icons.add),
      ),
    );
  }
}
