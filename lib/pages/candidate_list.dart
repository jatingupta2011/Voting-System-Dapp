import 'package:flutter/material.dart';
import 'package:voting_system/services/functions.dart';
import 'package:web3dart/web3dart.dart';

import 'authorize_private_voter_key.dart';

class CandidateList extends StatefulWidget {
  final Web3Client ethClient;

  const CandidateList(
      {Key? key, required this.ethClient})
      : super(key: key);
  @override
  _CandidateListState createState() => _CandidateListState();
}

class _CandidateListState extends State<CandidateList> {
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Candidate List")),
      body: (loading)
          ? Center(
        child: CircularProgressIndicator(),
      )
          :Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getCandidatesNum(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data==null) {
                            return Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Total Candidates')
                  ],
                ),
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getTotalVotes(widget.ethClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Total Votes')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Divider(),
            FutureBuilder<List>(
              future: getCandidatesNum(widget.ethClient),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.data==null){
                  return Text('No Candidates Available!');
                }
                else {
                  return Column(
                    children: [
                      for (int i = 0; i < snapshot.data![0].toInt(); i++)
                        FutureBuilder<List>(
                            future: candidateInfo(i, widget.ethClient),
                            builder: (context, candidatesnapshot) {
                              if (candidatesnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return ListTile(
                                  title: Text('Name: ' +
                                      candidatesnapshot.data![0][0].toString()),
                                  subtitle: Text('Votes: ' +
                                      candidatesnapshot.data![0][1].toString()),
                                  trailing: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AuthorizePrivateVoterKey(ethClient: widget.ethClient,candidateIndex: i,)));

                                      },
                                      child: Text('Vote')),
                                );
                              }
                            })
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            loading=true;
          });
          setState(() {
            loading=false;
          });
        },
        child: Icon(Icons.refresh_sharp),
      ),
    );
  }
}
