class Notes {
  String title = '';
  String fileUrl = '';
  String description = '';

  Notes({required this.title, this.description = '', this.fileUrl = ''});


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['fileUrl'] = fileUrl;
    return map;
  }
  // Extract a Note object from a Map object
  Notes.fromMap(Map<String, dynamic> map) {
    title = map['title']??"no title available";
    description = map['description']??"no description available";
    fileUrl = map['fileUrl']??"no pdfUrl available";
  }
}