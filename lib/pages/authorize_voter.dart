import 'package:flutter/material.dart';
import 'package:voting_system/pages/candidate_list.dart';
import 'package:voting_system/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class AuthorizeVoter extends StatefulWidget {
  final Web3Client ethClient;

  const AuthorizeVoter(
      {Key? key, required this.ethClient})
      : super(key: key);
  @override
  _AuthorizeVoterState createState() => _AuthorizeVoterState();
}

class _AuthorizeVoterState extends State<AuthorizeVoter> {
  // Client? httpClient;
  // Web3Client? ethClient;
  //TextEditingController controller = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();
  bool loading = false;
  // @override
  // void initState() {
  //   httpClient = Client();
  //   ethClient = Web3Client(infura_url, httpClient!);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorize Voter'),
        centerTitle: true,
      ),
      body: (loading)?
      Center(child: CircularProgressIndicator(),)
          : Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Spacer(),
            TextField(
              controller: authorizeVoterController,
              decoration: InputDecoration(
                  filled: true, hintText: 'Enter public voter address'),
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
                        loading=true;
                      });
                      await authorizeVoter(
                          authorizeVoterController.text, widget.ethClient);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateList(ethClient: widget.ethClient,)));
                      setState(() {
                        loading=false;
                      });
                    },
                    child: Text('Next'))),
          ],
        ),
      ),
    );
  }
}
