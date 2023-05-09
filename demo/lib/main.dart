import 'package:demo/network_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _incrementCounter();
    super.initState();
  }

  int _counter = 0;
  bool gotdata = false;
  late var data;
  void _incrementCounter() async {
    await Networkget().getData().then((value) {
      if (value.length!=0) {
        data = value;

        setState(() {
          gotdata = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              const SizedBox(
                height: 30,
              ),
              gotdata
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 181, 172, 171),
                                    blurRadius: 2,
                                    offset: Offset(0, 1), // Shadow position
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Image(
                                        image:
                                        NetworkImage(data[index]["image"]),
                                        fit: BoxFit.contain,
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.4,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            
                                            Text(data[index]["title"]
                                                .toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                           
                                            Text(data[index]["price"]
                                                .toString(),style:  const TextStyle(fontSize: 16,),),
                                            
                                            Text(data[index]["category"]
                                                .toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          }),
                    )
                  : const Center(
                      child: Text("waiting for response"),
                    )
            ]),
          ),
        ));
  }
}
