double parseDouble(Object? value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

DateTime? parseDate(Object? value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString())?.toLocal();
}

DateTime? parseDateTime(Object? value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString())?.toLocal();
}

Map<String, dynamic> normalizeMap(Map<dynamic, dynamic> raw) {
  return raw.map<String, dynamic>((key, value) => MapEntry('$key', value));
}
