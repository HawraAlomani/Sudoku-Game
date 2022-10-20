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
  List<int> cellsSolution = [
    5, 3, 4, 6, 7, 8, 9, 1, 2,
    6, 7, 2, 1, 9, 5, 3, 4, 8,
    1, 9, 8, 3, 4, 2, 5, 6, 7,

    8, 5, 9, 7, 6, 1, 4, 2, 3,
    4, 2, 6, 8, 5, 3, 7, 9, 1,
    7, 1, 3, 9, 2, 4, 8, 5, 6,

    9, 6, 1, 5, 3, 7, 2, 8, 4,
    2, 8, 7, 4, 1, 9, 6, 3, 5,
    3, 4, 5, 2, 8, 6, 1, 7, 9
  ];

  // The puzzel based on cellsSolution (delete some cells randomly)
  List<int> cellsPuzzel = [
    5, 3, 4, 0, 7, 8, 9, 1, 2,
    6, 7, 2, 1, 9, 5, 3, 4, 8,
    1, 0, 8, 0, 4, 2, 5, 6, 7,

    8, 0, 9, 7, 6, 1, 4, 2, 3,
    4, 2, 6, 8, 5, 3, 7, 9, 0,
    7, 0, 3, 9, 2, 4, 8, 5, 6,

    9, 6, 1, 5, 3, 7, 2, 8, 4,
    2, 0, 7, 4, 0, 0, 6, 3, 0,
    3, 4, 5, 2, 8, 6, 1, 0, 0
  ];


//function to check if the cell is a blank and can be filled later.
  bool isBlank(index){
    for(var i=0;i<cellsPuzzel.length;i++){
        if(cellsPuzzel[index] == 0){
          return true;
        }
    }
    return false;
  }

  // function to check if cellsPuzzel is filled without any ''.
  bool isPuzzelFilled(){
    if(cellsPuzzel.contains(0)){
      return false; // this means there is cells unfilled
    }
    else{
      return true; // this means all cells are filled
    }
  }


  // Check if two lists are equal, and when true then you won the game
  bool areListsEqual(var list1, var list2) {
    // check if both are lists
    if(!(list1 is List && list2 is List)
        // check if both have same length
        || list1.length!=list2.length) {
      return false;
    }
    // check if elements are equal
    for(int i=0;i<list1.length;i++) {
      if(list1[i]!=list2[i]) {
        return false;
      }
    }

    return true;
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
                        onChanged: (text){
                          print('First text field: $text in $index');
                          cellsPuzzel[index]= int.parse(text); //replace 0 with input value
                          // print(cellsPuzzel);
                          },
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
                              cellsPuzzel[index].toString(),
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
                    onPressed:() {
                      // Check if all cells are filled before checking the answer.
                      if(isPuzzelFilled()){

                        // check if the two lists are equal
                        if (areListsEqual(cellsPuzzel, cellsSolution)){
                          print('you win');
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('you won'),
                              content: Text('Congrats 👏, you solved the puzzel.'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Go Back'))
                              ],
                            ),
                          );
                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('you lost'),
                              content: Text('you lost the game, try again !! '),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Go Back'))
                              ],
                            ),
                          );
                          print('you lose, try again');
                        }

                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('not complete solution'),
                            content: Text('must fill all cells with numbers'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Go Back'))
                            ],
                          ),
                        );

                      }

                    }, /* if all cells are filled then this button can be pressed.*/
                    child: const Text('Check Solution'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                            (Route<dynamic> route) => false,
                      );
                    }, /* to generate a new Sudoku. */
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

// function to check the index, and color it.
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

