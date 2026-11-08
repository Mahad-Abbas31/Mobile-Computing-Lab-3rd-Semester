import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());

}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('I am NavBar'),
        ),

        body: const Center(
          child: Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              Text('Mahad Abbas'),
              Text('Sheraz Abid'),
              Text('Zaryab Khan'),
              ContainerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget{
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(40),
      width: 250,
      height: 250,
      color: Colors.blue,


      child: Text(
        style: TextStyle(
          color: Colors.amber,
          fontSize: 25,
          fontWeight: FontWeight(900),
        ),
        'Mahad Abbas'
        ),
    );
  }

}