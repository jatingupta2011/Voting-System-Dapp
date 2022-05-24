import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voting_system/owner_pages/owner_login.dart';
import 'package:voting_system/pages/authorize_voter.dart';
import 'package:voting_system/pages/electionInfo.dart';
import 'package:voting_system/services/functions.dart';
import 'package:voting_system/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        title: Text('Voting System'),
      ),
      body: Column(
        children: [
          Spacer(),
          Container(

              margin: EdgeInsets.only(top: 10.0),
              height: 150.0,
              // color: Colors.red,
              child: ListView(
                scrollDirection: Axis.horizontal,

                children: <Widget>[
                  SizedBox(width: 100,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OwnerLogin(ethClient: ethClient!,)));
                    },

                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(
                              'assets/images/owner.png',
                              height: 70.0,
                              // width: 110.0,
                            ),
                          ),
                          Text(
                            "Owner",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 30,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AuthorizeVoter(ethClient: ethClient!)));
                    },
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      15),
                                ),
                                child: Image.asset(
                                  'assets/images/voter.png',
                                  height: 70.0,
                                  width: 80.0,
                                ),
                              ),
                              Text(
                                "Voter",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          )
                      ),
                      //color: Colors.green,
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 100,),
                ],
              )),
          Spacer()
        ],
      )
    );
  }
}
