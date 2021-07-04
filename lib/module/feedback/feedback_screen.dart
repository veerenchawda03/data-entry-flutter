import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sheets_app/module/feedback/feedback_controller.dart';
import 'package:google_sheets_app/module/feedback/feedback_list_view.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feedback Responses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedbackListPage(title: "Responses"));
  }
}

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  var controller = FeedBackController();
  Timer _debounce;

  /// UI property
  final _listViewKey = GlobalKey<FeedBackListViewState>();

  /// UI method
  /// ref: https://stackoverflow.com/a/52930197
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      controller.filterSearchResults(query);
    });
  }

  _onDataChanged() {
    this._listViewKey.currentState.refreshUI();
  }

  @override
  void initState() {
    super.initState();

    /// connect listener of [FeedBackController] to this View (screen)
    controller.onDataChanged = _onDataChanged;

    /// this equal
    // controller.onDataChanged = () {
    //   this._listViewKey.currentState.refreshUI();
    // };

    /// Add a listener here to listen event whenever UI finishes rendering
    WidgetsBinding.instance.addPostFrameCallback((_) => onUIReady(context));
  }

  /// this function is called when UI is completely built for first load.
  /// this moment to fetch data from another source or do something with UI
  void onUIReady(BuildContext context) {
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: FeedBackListView(
              key: _listViewKey,
              delegate: this.controller,
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
