import '../entities/settings_overview.dart';

class DataExportRequest {
  const DataExportRequest({
    required this.type,
    required this.format,
  });

  final DataExportType type;
  final DataExportFormat format;
}
