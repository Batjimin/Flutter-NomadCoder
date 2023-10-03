class WebtoonEpisodeModel {
  final String id, title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json) //생성자
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
