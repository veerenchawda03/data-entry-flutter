/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String number;
  String amount;

  FeedbackForm(this.name, this.number, this.amount);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['number']}", "${json['amount']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'number': number,
        'amount': amount,
      };

  bool contains(FeedbackForm query) {
    // Would still want to check for null etc. first.
    return this.name == query.name && this.number == query.number && this.amount == query.amount;
  }
}
