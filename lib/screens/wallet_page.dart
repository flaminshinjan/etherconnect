import 'package:flutter/material.dart';
import 'package:etherconnect/services/wallet_service.dart';


class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final WalletService _walletService = WalletService();
  String _statusMessage = '';

  void _connectWallet() async {
    try {
      await _walletService.connect();
      setState(() => _statusMessage = 'Wallet Connected');
    } catch (e) {
      setState(() => _statusMessage = 'Error: $e');
    }
  }

  void _signMessage() async {
    try {
      String result = await _walletService.signMessage('Hello MetaMask!');
      setState(() => _statusMessage = 'Signed: $result');
    } catch (e) {
      setState(() => _statusMessage = 'Error: $e');
    }
  }

  void _sendTransaction() async {
    try {
      String txHash = await _walletService.sendTransaction(
          '0xReceiverAddress', '0.01');
      setState(() => _statusMessage = 'Transaction Sent: $txHash');
    } catch (e) {
      setState(() => _statusMessage = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EtherConnect'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _connectWallet,
              child: Text('Connect Wallet'),
            ),
            ElevatedButton(
              onPressed: _signMessage,
              child: Text('Sign Message'),
            ),
            ElevatedButton(
              onPressed: _sendTransaction,
              child: Text('Send Transaction'),
            ),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }
}
