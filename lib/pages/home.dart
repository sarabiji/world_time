import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data =data.isNotEmpty? data : ModalRoute.of(context)!.settings.arguments;

    String bgImage = data['isDayTime']?'day.jpg':'night.jpg';
    Color? bgColor =data['isDayTime']? Colors.blue : Colors.indigo[500]; 
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location':result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDayTime': result['isDayTime'],
                        };
                      });
                    },
                    icon: const Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: const Text("Edit Location",
                    style: TextStyle(
                       color: Colors.grey[300],
                    ))),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],style: const TextStyle(fontSize: 30,letterSpacing: 2,  color: Colors.white,),)
                  ],
                ),
                const SizedBox(height: 20,),
                Text(data['time'],style: const TextStyle(fontSize: 70,letterSpacing: 2,color: Colors.white,),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
