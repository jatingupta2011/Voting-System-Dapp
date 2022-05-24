import 'package:flutter/material.dart';
import 'package:voting_system/pages/authorize_voter.dart';
import 'package:voting_system/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class AuthorizePrivateVoterKey extends StatefulWidget {
  final Web3Client ethClient;
  final int candidateIndex;

  const AuthorizePrivateVoterKey(
      {Key? key, required this.candidateIndex, required this.ethClient})
      : super(key: key);

  @override
  _AuthorizePrivateVoterKeyState createState() =>
      _AuthorizePrivateVoterKeyState();
}

class _AuthorizePrivateVoterKeyState extends State<AuthorizePrivateVoterKey> {
  TextEditingController authorizeVoterController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
        centerTitle: true,
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Spacer(),
                  TextField(
                    controller: authorizeVoterController,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter your private voter address'),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                           String result = await vote(widget.candidateIndex, widget.ethClient);
                           if(result!="Error"){
                             Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => AuthorizeVoter(
                                         ethClient: widget.ethClient)));
                             final snackBar = SnackBar(
                               content: Text('Your vote is counted successfully!',),
                               duration: Duration(seconds: 5),
                             );
                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             setState(() {
                               loading = false;
                             });
                           }else{
                             setState(() {
                               loading = false;
                             });
                             final snackBar = SnackBar(
                               content: Text('Error! Please try again!',),
                               duration: Duration(seconds: 5),
                             );
                             ScaffoldMessenger.of(context).showSnackBar(snackBar);

                           }



                          },
                          child: Text('Proceed'))),
                ],
              ),
            ),
    );
  }
}
