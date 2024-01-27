
import 'package:flutter_web3/flutter_web3.dart';
import 'package:wallet_connect/wallet_connect.dart';

class WalletService {
  late WalletConnect connector;

  WalletService() {
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'EtherConnect',
        description: 'Connect and transact with MetaMask',
        url: 'https://yourapp.com',
        icons: ['https://yourapp.com/icon.png'],
      ),
    );
  }

  Future<void> connect() async {
    if (!connector.connected) {
      await connector.createSession(onDisplayUri: (uri) async {
        // Implement logic to handle the URI, e.g., show a QR code
      });
    }
  }

  Future<String> signMessage(String message) async {
    if (connector.connected) {
      final signedMessage = await connector.sendCustomRequest(
        method: 'personal_sign',
        params: [message, connector.session.accounts[0]],
      );
      return signedMessage;
    } else {
      throw Exception('Wallet not connected');
    }
  }

  Future<String> sendTransaction(String toAddress, String amount) async {
    if (connector.connected) {
      final transaction = {
        'from': connector.session.accounts[0],
        'to': toAddress,
        'data': '0x',
        'value': '0x${BigInt.parse(amount).toRadixString(16)}',
      };
      final txHash = await connector.sendTransaction(transaction);
      return txHash;
    } else {
      throw Exception('Wallet not connected');
    }
  }
}
