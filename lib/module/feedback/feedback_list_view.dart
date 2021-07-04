import 'package:flutter/material.dart';
import 'package:google_sheets_app/model/form.dart';

/// I = Interface
abstract class IFeedBackListView {
  int getItemCount();
  FeedbackForm getItem(int index);
}

/// DO NOT declare any data model (data class, etc) in this class
/// This class is used for handle UI change only
/// You can declare some data model for contain UI stuffs
/// Such as: Animation duration, transformX, height, weight,..
/// This class only contain logic about display data to UI
class FeedBackListView extends StatefulWidget {
  FeedBackListView({Key key, @required this.delegate}) : super(key: key);

  final IFeedBackListView delegate;
  // you can use GlobalKey inside the FeedbackListScreen to access currentState of this Widget
  // I am using common logic, just using OOP and it's design pattern
  final State<StatefulWidget> state = FeedBackListViewState();

  @override
  FeedBackListViewState createState() {
    return this.state;
  }
}

/// DO NOT declare any data model (data class, etc) in this class
/// This class is used for handle UI change only
/// You can declare some data model for contain UI stuffs
/// Such as: Animation duration, transformX, height, weight,..
/// This class only contain logic about display data to UI
class FeedBackListViewState extends State<FeedBackListView> {
  void refreshUI() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.delegate.getItemCount() ?? 0,
      itemBuilder: (context, index) {
        var item = widget.delegate.getItem(index);
        return ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.person),
              Expanded(
                child: Text("${item.name} (${item.number})"),
              )
            ],
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.message),
              Expanded(
                child: Text(item.amount),
              )
            ],
          ),
        );
      },
    );
  }
}
