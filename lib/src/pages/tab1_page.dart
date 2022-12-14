import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab1Page extends StatefulWidget {

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {

    final headlines = Provider.of<NewsService>(context).headlines;
    //newsService.headlines

    return Scaffold(
      // ignore: prefer_is_empty
      body: (headlines.length == 0)
      ? const Center(
        child: CircularProgressIndicator(),
      )
      : ListaNoticias(headlines)
   );
  }

  @override
  bool get wantKeepAlive => true;
}