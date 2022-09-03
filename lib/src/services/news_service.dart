import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const _URL_NEWS = 'https://newsapi.org/v2';
// ignore: constant_identifier_names
const _APIKEY = 'c7abbe679beb44eca39f3c4d1e2aa842';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  // ignore: unused_field
  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business','negocios'),
    Category(FontAwesomeIcons.tv, 'entertainment','entretenimiento'),
    Category(FontAwesomeIcons.addressCard, 'general','general'),
    Category(FontAwesomeIcons.headSideVirus, 'health','salud'),
    Category(FontAwesomeIcons.vials, 'science','ciencia'),
    // ignore: deprecated_member_use
    Category(FontAwesomeIcons.volleyballBall, 'sports','deportes'),
    Category(FontAwesomeIcons.memory, 'technology','tecnología'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.name] = List.empty();
    }
    getArticlesByCategory(_selectedCategory); 
  }

  // ignore: recursive_getters
  bool get isLoading => isLoading;

  get selectedCategory_ => _selectedCategory;

  set selectedCategory(String valor){
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this._selectedCategory]!;

  getTopHeadlines() async{
    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx');
    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory (String category) async{
    if (categoryArticles[category]!.isNotEmpty){
      _isLoading = true;
      notifyListeners();
      return categoryArticles[category];
    }
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category');
    final resp = await http.get(url);

    final newsResponse = NewsResponse.fromJson(resp.body);

    //categoryArticles[category]!.addAll(newsResponse.articles);
    categoryArticles[category] = newsResponse.articles;

    _isLoading = false;
    notifyListeners();

    //if (newsResponse != null || newsResponse.articles != []) {
    //  this.categoryArticles[category]!.addAll(newsResponse.articles);
    //  this._isLoading = false;
    //  notifyListeners();
    //}
  }
}