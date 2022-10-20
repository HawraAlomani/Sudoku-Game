import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku Game',
      home: const MyHomePage(title: 'Sudoku Game'),
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
  // The random solution sudoku Array
  List<String> cellsSolution = [
    '5', '3', '4', '6', '7', '8', '9', '1', '2',
    '6', '7', '2', '1', '9', '5', '3', '4', '8',
    '1', '9', '8', '3', '4', '2', '5', '6', '7',

    '8', '5', '9', '7', '6', '1', '4', '2', '3',
    '4', '2', '6', '8', '5', '3', '7', '9', '1',
    '7', '1', '3', '9', '2', '4', '8', '5', '6',

    '9', '6', '1', '5', '3', '7', '2', '8', '4',
    '2', '8', '7', '4', '1', '9', '6', '3', '5',
    '3', '4', '5', '2', '8', '6', '1', '7', '9'
  ];

  // The puzzel based on cellsSolution (delete some cells randomly)
  List<String> cellsPuzzel = [
    '5', '3', '4', '6', '7', '8', '', '1', '2',
    '', '7', '', '1', '9', '', '3', '', '8',
    '1', '9', '', '3', '4', '2', '5', '6', '',

    '', '5', '', '7', '6', '1', '4', '2', '3',
    '', '2', '', '8', '', '3', '7', '9', '',
    '7', '1', '3', '', '2', '4', '8', '5', '6',

    '9', '6', '1', '5', '3', '7', '', '', '4',
    '', '8', '', '', '1', '9', '', '3', '5',
    '3', '4', '5', '2', '8', '6', '', '', ''
  ];

//function to check if the cell is a blank and can be filled later.
  bool isBlank(index){
    for(var i=0;i<cellsPuzzel.length;i++){
        if(cellsPuzzel[index] == ''){
          return true;
        }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sudoku Game',),),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                  itemCount: cellsPuzzel.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      crossAxisCount: 9),
                  itemBuilder: (BuildContext context, int index){
                    if(isBlank(index)){
                      return TextField(
                        enabled: isBlank(index),
                        decoration: InputDecoration(filled: toBeColored(index),
                            fillColor: Colors.black12,
                            enabledBorder: OutlineInputBorder()),
                        textAlign: TextAlign.center,
                      );
                    }
                    else{
                      return Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          color:  toBeColored(index)?Colors.black12: Colors.transparent,
                          child: Center(
                            child: Text(
                              cellsPuzzel[index],
                            ),
                          ),
                        ),
                      );

                    }
                  }),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: ElevatedButton(
                    onPressed: null, /* if all cells are filled then this button can be pressed.*/
                    child: const Text('Check Solution'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: ElevatedButton(
                    onPressed: () {}, /* to generate a new Sudoku. */
                    child: const Text('Refresh'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

  // function to check the index
bool toBeColored(index){
  List<int> myArray=[
    3,4,5,12,13,14,21,22,23, // 1st block indexes
    27,28,29,36,37,38,45,46,47, // 2nd block indexes
    33,34,35,42,43,44,51,52,53, // 3rd block indexes
    57,58,59,66,67,68,75,76,77, // 4th block indexes
  ];
     for(int i=0; i<myArray.length; i++){
     if (myArray[i]==index){
       return true;
     }
}
  return false;
}

