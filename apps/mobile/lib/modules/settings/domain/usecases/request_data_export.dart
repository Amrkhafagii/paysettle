import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';
import '../value_objects/data_export_request.dart';

class RequestDataExportUseCase {
  RequestDataExportUseCase(this._repository);

  final SettingsRepository _repository;

  Future<DataExportJob> call(DataExportRequest request) {
    return _repository.requestDataExport(request);
  }
}
