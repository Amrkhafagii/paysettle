import '../../domain/entities/wallet_overview.dart';

class WalletOverviewDto {
  WalletOverviewDto({
    required this.totalBalance,
    required this.totalOwed,
    required this.totalDue,
    required this.collectFrom,
    required this.payTo,
    required this.settlementLog,
    required this.trend,
    required this.paymentMethods,
  });

  factory WalletOverviewDto.fromMap(Map<String, dynamic> map) {
    return WalletOverviewDto(
      totalBalance: walletDtoToDouble(map['total_balance'] ?? map['totalBalance']),
      totalOwed: walletDtoToDouble(map['total_owed'] ?? map['totalOwed']),
      totalDue: walletDtoToDouble(map['total_due'] ?? map['totalDue']),
      collectFrom: _parseCounterparties(
        map['collect_from'] ?? map['collectFrom'],
        WalletDirection.collect,
      ),
      payTo: _parseCounterparties(
        map['pay_to'] ?? map['payTo'],
        WalletDirection.pay,
      ),
      settlementLog: _parseSettlementLog(map['settlement_log'] ?? map['settlementLog']),
      trend: _parseTrend(map['trend']),
      paymentMethods: _parsePaymentMethods(map['payment_methods'] ?? map['paymentMethods']),
    );
  }

  final double totalBalance;
  final double totalOwed;
  final double totalDue;
  final List<WalletCounterparty> collectFrom;
  final List<WalletCounterparty> payTo;
  final List<WalletSettlementLogEntry> settlementLog;
  final List<WalletTrendPoint> trend;
  final List<WalletPaymentMethod> paymentMethods;

  Map<String, dynamic> toJson() {
    return {
      'total_balance': totalBalance,
      'total_owed': totalOwed,
      'total_due': totalDue,
      'collect_from': collectFrom
          .map((entry) => _counterpartyToJson(entry))
          .toList(growable: false),
      'pay_to': payTo
          .map((entry) => _counterpartyToJson(entry))
          .toList(growable: false),
      'settlement_log': settlementLog
          .map((entry) => {
                'eventId': entry.id,
                'transactionId': entry.transactionId,
                'type': entry.eventType.name,
                'amount': entry.amount,
                'counterparty': entry.counterparty,
                'status': entry.status,
                'occurredAt': entry.occurredAt.toIso8601String(),
              })
          .toList(growable: false),
      'trend': trend
          .map((point) => {
                'label': point.label,
                'collect': point.collect,
                'pay': point.pay,
              })
          .toList(growable: false),
      'payment_methods': paymentMethods
          .map((method) => {
                'methodId': method.id,
                'label': method.label,
                'provider': method.provider,
                'type': method.type.name,
                'isPrimary': method.isPrimary,
                'accountNumber': method.accountNumber,
                'instructions': method.instructions,
                'metadata': method.metadata,
              })
          .toList(growable: false),
    };
  }

  WalletOverview toDomain(WalletTimeframe timeframe) {
    return WalletOverview(
      totalBalance: totalBalance,
      totalOwed: totalOwed,
      totalDue: totalDue,
      netValue: totalBalance,
      collectFrom: collectFrom,
      payTo: payTo,
      settlementLog: settlementLog,
      trend: trend,
      paymentMethods: paymentMethods,
      fetchedAt: DateTime.now(),
      timeframe: timeframe,
    );
  }

  static List<WalletCounterparty> _parseCounterparties(
    dynamic raw,
    WalletDirection direction,
  ) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => WalletCounterparty(
              transactionId: '${entry['transactionId'] ?? entry['id']}',
              contactId: entry['contactId']?.toString(),
              journeyId: entry['journeyId']?.toString(),
              name: '${entry['name'] ?? 'Unassigned'}',
              amount: walletDtoToDouble(entry['amount']),
              status: '${entry['status'] ?? 'open'}',
              direction: direction,
              issueDate:
                  walletDtoParseDate(entry['issueDate'] ?? entry['issue_date']),
              dueDate:
                  walletDtoParseDate(entry['dueDate'] ?? entry['due_date']),
            ))
        .toList(growable: false);
  }

  static List<WalletSettlementLogEntry> _parseSettlementLog(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => WalletSettlementLogEntry(
              id: '${entry['eventId'] ?? entry['id']}',
              transactionId: '${entry['transactionId'] ?? ''}',
              eventType: _parseEventType(entry['type']),
              counterparty: '${entry['counterparty'] ?? 'Unknown'}',
              status: '${entry['status'] ?? 'open'}',
              amount: entry['amount'] == null
                  ? null
                  : walletDtoToDouble(entry['amount']),
              occurredAt: walletDtoParseDateTime(
                      entry['occurredAt'] ?? entry['occurred_at']) ??
                  DateTime.now(),
            ))
        .toList(growable: false);
  }

  static List<WalletTrendPoint> _parseTrend(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => WalletTrendPoint(
              label: '${entry['label'] ?? ''}',
              collect: walletDtoToDouble(entry['collect']),
              pay: walletDtoToDouble(entry['pay']),
            ))
        .toList(growable: false);
  }

  static List<WalletPaymentMethod> _parsePaymentMethods(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .whereType<Map>()
        .map((entry) => WalletPaymentMethod(
              id: '${entry['methodId'] ?? entry['id']}',
              label: '${entry['label'] ?? ''}',
              provider: '${entry['provider'] ?? ''}',
              type: _parsePaymentMethodType(entry['type']),
              isPrimary: entry['isPrimary'] == true,
              accountNumber: entry['accountNumber']?.toString(),
              instructions: entry['instructions']?.toString(),
              metadata: (entry['metadata'] as Map?)?.cast<String, dynamic>() ??
                  const {},
            ))
        .toList(growable: false);
  }

  static WalletSettlementEventType _parseEventType(dynamic raw) {
    final value = '${raw ?? ''}'.toLowerCase();
    switch (value) {
      case 'reminder':
        return WalletSettlementEventType.reminder;
      case 'payment':
        return WalletSettlementEventType.payment;
      case 'note':
        return WalletSettlementEventType.note;
      case 'request':
      default:
        return WalletSettlementEventType.request;
    }
  }

  static WalletPaymentMethodType _parsePaymentMethodType(dynamic raw) {
    final value = '${raw ?? ''}'.toLowerCase();
    switch (value) {
      case 'vodafone_cash':
        return WalletPaymentMethodType.vodafoneCash;
      case 'instapay':
        return WalletPaymentMethodType.instapay;
      case 'bank':
        return WalletPaymentMethodType.bank;
      default:
        return WalletPaymentMethodType.other;
    }
  }

  Map<String, dynamic> _counterpartyToJson(WalletCounterparty counterparty) {
    return {
      'transactionId': counterparty.transactionId,
      'contactId': counterparty.contactId,
      'journeyId': counterparty.journeyId,
      'name': counterparty.name,
      'amount': counterparty.amount,
      'status': counterparty.status,
      'direction': counterparty.direction.name,
      'issueDate': counterparty.issueDate?.toIso8601String(),
      'dueDate': counterparty.dueDate?.toIso8601String(),
    };
  }
}

double walletDtoToDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

DateTime? walletDtoParseDate(dynamic value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString());
}

DateTime? walletDtoParseDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString());
}
