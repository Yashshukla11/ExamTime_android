class Notes {
  String title = '';
  String pdfUrl = '';
  String description = '';

  Notes({required this.title, this.description = '', this.pdfUrl = ''});


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['fileUrl'] = pdfUrl;
    return map;
  }
  // Extract a Note object from a Map object
  Notes.fromMap(Map<String, dynamic> map) {
    title = map['title']??"no title available";
    description = map['description']??"no description available";
    pdfUrl = map['fileUrl']??"no pdfUrl available";
  }
}