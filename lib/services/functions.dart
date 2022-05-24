import 'package:flutter/services.dart';
import 'package:voting_system/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contractAddress1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  try{
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(funcname);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  } catch (err) {
    return "Error";
  }
}

Future<String> startElection(String name, Web3Client ethClient) async {
  try {
    var response =
    await callFunction('startElection', [name], ethClient, owner_private_key);
    print('Election started successfully');
    return response;
  } catch (err) {
    return "Error";
  }
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  try {
    var response =
    await callFunction('addCandidate', [name], ethClient, owner_private_key);
    print('Candidate added successfully');
    return response;
  } catch (err) {
    return "Error";
  }
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  try {
    var response = await callFunction('authorizedVoter',
        [EthereumAddress.fromHex(address)], ethClient, owner_private_key);
    print('Voter Authorized successfully');
    print(response.toString());
    return response;
  } catch (err) {
    return "Error";
  }
}

Future<List> getCandidatesNum(Web3Client ethClient) async {

  List<dynamic> result = await ask('getNumCndidates', [], ethClient);
  return result;
}

Future<List> getTotalVotes(Web3Client ethClient) async {
  List<dynamic> result = await ask('getTotalVotes', [], ethClient);
  return result;
}

Future<List> candidateInfo(int index, Web3Client ethClient) async {
  List<dynamic> result =
      await ask('candidateInfo', [BigInt.from(index)], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  try {
    var response = await callFunction(
        "vote", [BigInt.from(candidateIndex)], ethClient, voter_private_key);
    print("Vote counted successfully");
    return response;
  } catch (err){
    return "Error";
  }
}
