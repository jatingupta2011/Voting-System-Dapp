import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voting_system/pages/authorize_voter.dart';
import 'package:voting_system/pages/electionInfo.dart';
import 'package:voting_system/services/functions.dart';
import 'package:voting_system/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class StartElection extends StatefulWidget {
  const StartElection({Key? key}) : super(key: key);

  @override
  _StartElectionState createState() => _StartElectionState();
}

class _StartElectionState extends State<StartElection> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Start Election'),
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                    filled: true, hintText: 'Enter election name'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (controller.text.length > 0) {
                          await startElection(controller.text, ethClient!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ElectionInfo(
                                      ethClient: ethClient!,
                                      electionName: controller.text)));
                        }
                        else{///TODO
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthorizeVoter(ethClient: ethClient!)));

                        }
                      },
                      child: Text('Start Election')))
            ],
          ),
        ),
      );
  }
}
