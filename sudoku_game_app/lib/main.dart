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

  @override
  Widget build(BuildContext context) {

    /* Random Array Generator */
    // var GRID_TO_SOLVE = [
    //   [Random().nextInt(9)+1,0,0,0,0,0,0,0,0],
    //   [0,0,0,0,Random().nextInt(9)+1,0,0,0,0],
    //   [0,0,0,0,0,0,0,Random().nextInt(9)+1,0],
    //   [0,Random().nextInt(9)+1,0,0,0,0,0,0,0],
    //   [0,0,0,Random().nextInt(9)+1,0,0,0,0,0],
    //   [0,0,0,0,0,0,0,0,Random().nextInt(9)+1],
    //   [0,0,Random().nextInt(9)+1,0,0,0,0,0,0],
    //   [0,0,0,0,0,Random().nextInt(9)+1,0,0,0],
    //   [Random().nextInt(9)+1,0,0,0,0,0,0,0,0],
    // ];

    var GRID_TO_SOLVE = [
      [Random().nextInt(9)+1,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [Random().nextInt(9)+1,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,Random().nextInt(9)+1],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0,Random().nextInt(9)+1],
    ];

    print(GRID_TO_SOLVE);



    // we check if a possible number is already in a row
    bool isInRow(List<List> board,int row, int number) {
      for (int i = 0; i < 9; i++)
        if (board[row][i] == number)
          return true;

      return false;
    }

// we check if a possible number is already in a column
    bool isInCol(List<List> board,int col, int number) {
      for (int i = 0; i < 9; i++)
        if (board[i][col] == number)
          return true;

      return false;
    }

// we check if a possible number is in its 3x3 box
    bool isInBox(List<List> board,int row, int col, int number) {
      int r = row - row % 3;
      int c = col - col % 3;

      for (int i = r; i < r + 3; i++)
        for (int j = c; j < c + 3; j++)
          if (board[i][j] == number)
            return true;

      return false;
    }

// combined method to check if a number possible to a row,col position is ok
    bool isOk(List<List> board,int row, int col, int number) {
      return !isInRow(board,row, number)  &&  !isInCol(board,col, number)  &&  !isInBox(board,row, col, number);
    }

// Solve method. We will use a recursive BackTracking algorithm.
    bool solve(List<List> board) {
      for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
          // we search an empty cell
          if (board[row][col] == 0) {
            // we try possible numbers
            for (int number = 1; number <= 9; number++) {
              if (isOk(board,row, col, number)) {
                // number ok. it respects sudoku constraints
                board[row][col] = number;
                if (solve(board)) { // we start backtracking recursively
                  return true;
                } else { // if not a solution, we empty the cell and we continue
                  board[row][col] = 0;
                }
              }

            }
            return false; // we return fals
          }
        }
      }
      return true; // sudoku solved
    }
    print(solve(GRID_TO_SOLVE));
    print(GRID_TO_SOLVE);

    List<int> answer = [];
    for(int r=0;r<9;r++)
      for(int c=0;c<9;c++){
        answer.add(GRID_TO_SOLVE[r][c]);}
    print(answer);
    List<int> answer2 = [];

    for(int r=0;r<9;r++)
      for(int c=0;c<9;c++){
        answer2.add(GRID_TO_SOLVE[r][c]);}

    List<int> question = answer;
    for(int i=0;i<20;i++){
      question[Random().nextInt(81)]=0;
    }
    print(question);
    /**************************/

    /******* MY Section ******/

    // The random solution sudoku Array
    List<int> cellsSolution = answer2;
    print('cellsSolution');
    print(cellsSolution);

    // The puzzel based on cellsSolution (delete some cells randomly)
    List<int> cellsPuzzel = question;
    print('cellsPuzzel');
    print(cellsPuzzel);


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
    bool areListsEqual(List<int> list1, List<int> list2) {
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


