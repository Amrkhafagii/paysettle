class UpdateProfileRequest {
  const UpdateProfileRequest({
    required this.fullName,
    this.phone,
    this.jobTitle,
    this.country,
    this.timezone,
    this.avatarUrl,
  });

  final String fullName;
  final String? phone;
  final String? jobTitle;
  final String? country;
  final String? timezone;
  final String? avatarUrl;
}
