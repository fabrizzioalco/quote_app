import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote/bloc/quote_bloc.dart';
import 'package:random_quote/repositories/quote_api_client.dart';
import 'package:random_quote/repositories/quote_repository.dart';
import 'package:random_quote/views/home_page.dart';
void main(){
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final QuoteRepository repository = QuoteRepository(
      quoteApiClient: QuoteApiClient(
        httpClient: http.Client()
      )
    );

    runApp(App(
      repository: repository
    ));
  }
class SimpleBlocDelegate extends BlocDelegate{

  @override 
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class App extends StatelessWidget{
  final QuoteRepository repository;

  App({Key key, @required this.repository})
    : assert(repository != null),
    super(key: key);


    @override 
    Widget build(BuildContext context){
      return MaterialApp(
        title: 'Quote App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Quote'),
          ),
          body: BlocProvider(
            create: (context) => QuoteBloc(repository: repository),
            child: HomePage(),
          )
        ),
      );
    }
}