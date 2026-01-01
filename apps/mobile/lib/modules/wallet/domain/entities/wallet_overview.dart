import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_overview.freezed.dart';

enum WalletDirection { collect, pay }

enum WalletTimeframe { day, week, month, year }

enum WalletSettlementEventType { request, reminder, payment, note }

enum WalletPaymentMethodType { vodafoneCash, instapay, bank, other }

extension WalletTimeframeX on WalletTimeframe {
  String get label {
    switch (this) {
      case WalletTimeframe.day:
        return 'Day';
      case WalletTimeframe.week:
        return 'Week';
      case WalletTimeframe.month:
        return 'Month';
      case WalletTimeframe.year:
        return 'Year';
    }
  }

  String get rpcValue => name;
}

extension WalletPaymentMethodTypeX on WalletPaymentMethodType {
  String get label {
    switch (this) {
      case WalletPaymentMethodType.vodafoneCash:
        return 'Vodafone Cash';
      case WalletPaymentMethodType.instapay:
        return 'Instapay';
      case WalletPaymentMethodType.bank:
        return 'Bank';
      case WalletPaymentMethodType.other:
        return 'Other';
    }
  }
}

@freezed
class WalletTrendPoint with _$WalletTrendPoint {
  const factory WalletTrendPoint({
    required String label,
    required double collect,
    required double pay,
  }) = _WalletTrendPoint;
}

@freezed
class WalletPaymentMethod with _$WalletPaymentMethod {
  const factory WalletPaymentMethod({
    required String id,
    required String label,
    required String provider,
    required WalletPaymentMethodType type,
    required bool isPrimary,
    String? accountNumber,
    String? instructions,
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _WalletPaymentMethod;
}

@freezed
class WalletCounterparty with _$WalletCounterparty {
  const factory WalletCounterparty({
    required String transactionId,
    String? contactId,
    String? journeyId,
    required String name,
    required double amount,
    required String status,
    required WalletDirection direction,
    DateTime? issueDate,
    DateTime? dueDate,
  }) = _WalletCounterparty;
}

@freezed
class WalletSettlementLogEntry with _$WalletSettlementLogEntry {
  const factory WalletSettlementLogEntry({
    required String id,
    required String transactionId,
    required WalletSettlementEventType eventType,
    required String counterparty,
    required String status,
    double? amount,
    required DateTime occurredAt,
  }) = _WalletSettlementLogEntry;
}

@freezed
class WalletOverview with _$WalletOverview {
  const factory WalletOverview({
    required double totalBalance,
    required double totalOwed,
    required double totalDue,
    required double netValue,
    required List<WalletCounterparty> collectFrom,
    required List<WalletCounterparty> payTo,
    required List<WalletSettlementLogEntry> settlementLog,
    required List<WalletTrendPoint> trend,
    required List<WalletPaymentMethod> paymentMethods,
    required DateTime fetchedAt,
    required WalletTimeframe timeframe,
  }) = _WalletOverview;
}
