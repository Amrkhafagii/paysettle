import '../../domain/entities/wallet_overview.dart';
import '../dtos/wallet_overview_dto.dart';

class WalletDemoDataSource {
  Future<WalletOverviewDto> loadOverview({required WalletTimeframe timeframe}) async {
    return WalletOverviewDto.fromMap(_demoPayload);
  }

  static Map<String, dynamic> get _demoPayload => {
        'total_balance': -149.86,
        'total_owed': 2984.81,
        'total_due': 3506.56,
        'collect_from': [
          {
            'transactionId': 'txn_collect_1',
            'contactId': 'contact_mayar',
            'name': 'Mayar M.',
            'amount': 889.0,
            'status': 'due',
            'issueDate': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
            'dueDate': DateTime.now().add(const Duration(days: 2)).toIso8601String(),
          },
          {
            'transactionId': 'txn_collect_2',
            'contactId': 'contact_moha',
            'name': 'Moha Mahrous',
            'amount': 23650.0,
            'status': 'open',
            'issueDate': DateTime.now().toIso8601String(),
            'dueDate': DateTime.now().add(const Duration(days: 5)).toIso8601String(),
          },
        ],
        'pay_to': [
          {
            'transactionId': 'txn_pay_1',
            'contactId': 'contact_ahmed',
            'name': 'Ahmed Farouk',
            'amount': 2655.0,
            'status': 'open',
            'issueDate': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
            'dueDate': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
          },
          {
            'transactionId': 'txn_pay_2',
            'contactId': 'contact_noha',
            'name': 'Noha A.',
            'amount': 1200.0,
            'status': 'pending',
            'issueDate': DateTime.now().subtract(const Duration(days: 4)).toIso8601String(),
            'dueDate': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          },
        ],
        'settlement_log': [
          {
            'eventId': 'log_1',
            'transactionId': 'txn_pay_1',
            'type': 'request',
            'amount': 2655.0,
            'counterparty': 'Ahmed Farouk',
            'status': 'pending',
            'occurredAt': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
          },
          {
            'eventId': 'log_2',
            'transactionId': 'txn_collect_2',
            'type': 'reminder',
            'amount': 950.0,
            'counterparty': 'Moha Mahrous',
            'status': 'due',
            'occurredAt': DateTime.now().subtract(const Duration(hours: 12)).toIso8601String(),
          },
        ],
        'trend': List.generate(7, (index) {
          final day = DateTime.now().subtract(Duration(days: 6 - index));
          return {
            'label': _weekdayLabel(day),
            'collect': 500 + (index * 120),
            'pay': 320 + (index * 80),
          };
        }),
        'payment_methods': [
          {
            'methodId': 'wallet_method_vf',
            'label': 'Vodafone Cash',
            'provider': 'Vodafone',
            'type': 'vodafone_cash',
            'isPrimary': true,
            'accountNumber': '0100 555 9912',
            'instructions': 'Send to wallet + screenshot',
            'metadata': {'icon': 'vodafone'},
          },
          {
            'methodId': 'wallet_method_instapay',
            'label': 'Instapay',
            'provider': 'Instapay',
            'type': 'instapay',
            'isPrimary': false,
            'accountNumber': 'paysettle@app',
            'metadata': {'icon': 'instapay'},
          },
          {
            'methodId': 'wallet_method_bank',
            'label': 'Bank Account',
            'provider': 'CIB',
            'type': 'bank',
            'isPrimary': false,
            'accountNumber': 'EG3200 **** 1234',
            'instructions': 'Ref: PAYSETTLE',
            'metadata': {'icon': 'bank'},
          }
        ],
      };

  static String _weekdayLabel(DateTime date) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[date.weekday - 1];
  }
}
