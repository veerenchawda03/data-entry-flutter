import 'package:flutter/cupertino.dart';
import 'package:google_sheets_app/controller/form_router.dart';
import 'package:google_sheets_app/macro.dart';
import 'package:google_sheets_app/model/form.dart';
import 'package:google_sheets_app/module/feedback/feedback_list_view.dart';

/// Controller will contain data model and Business logic
class FeedBackController implements IFeedBackListView {
  List<FeedbackForm> feedbackItems = [];
  List<FeedbackForm> filteredItems = [];
  String currentKeyword = '';

  VoidCallback onDataChanged; // this property is connected to main View of whole module

  var router = FormRouter();

  void fetchData() {
    router.getFeedbackList().then((value) {
      print('getFeedbackList: ${value.length}');
      feedbackItems = value;
      onDataChanged();
    }).catchError((error) {
      print(error.toString());
    });
  }

  void filterSearchResults(String query) {
    currentKeyword = query;
    if (query != null) {
      filteredItems.clear(); // clear data

// Method 1: using where to filter item that match condition
      filteredItems = feedbackItems.where((item) => item.number.contains(query)).toList();

// Method 2: using for loop (forEach) to check then add if match condition
      // feedbackItems.forEach((item) {
      //   if (item.name == query) {
      //     filteredItems.add(item);
      //   }
      // });

      /// Tell [FeedbackListScreen] to refresh UI follow new Data
      onDataChanged();
    }
  }

  /// This method will return item at given index to [FeedBackListView]
  @override
  FeedbackForm getItem(int index) {
    if (isNotEmpty(currentKeyword)) {
      return this.filteredItems[index];
    }
    return this.feedbackItems[index];
  }

  /// This method will tell [FeedBackListView] to identify number of item
  @override
  int getItemCount() {
    if (isNotEmpty(currentKeyword)) {
      return this.filteredItems.length;
    }
    return this.feedbackItems.length;
  }
}
