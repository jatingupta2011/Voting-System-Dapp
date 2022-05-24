import 'package:flutter/material.dart';
import 'package:voting_system/owner_pages/start_election.dart';
import 'package:voting_system/pages/electionInfo.dart';
import 'package:voting_system/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class OwnerLogin extends StatefulWidget {
  final Web3Client ethClient;
  const OwnerLogin({Key? key, required this.ethClient}) : super(key: key);

  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  TextEditingController publicOwnerController = TextEditingController();
  TextEditingController privateOwnerController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner Login'),
        centerTitle: true,
      ),
      body: (loading)?
      Center(child: CircularProgressIndicator(),)
          : Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextField(
              controller: publicOwnerController,
              decoration: InputDecoration(
                  filled: true, hintText: 'Enter public owner address'),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: privateOwnerController,
              decoration: InputDecoration(
                  filled: true, hintText: 'Enter private owner address'),
            ),
            Spacer(),
            Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                     if(privateOwnerController.text==owner_private_key && publicOwnerController.text == owner_public_key){
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => ElectionInfo(ethClient: widget.ethClient, electionName: "Election")));

                     }
                    },
                    child: Text('Next'))),
          ],
        ),
      ),
    );
  }
}
