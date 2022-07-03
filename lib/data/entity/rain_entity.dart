
class Rain {
  double d3h;
  Rain({required this.d3h});

  factory Rain.fromJson(Map<String, dynamic> json) {
   return Rain(d3h: json['d3h']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['3h'] = d3h;
    return data;
  }
}