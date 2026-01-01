enum Flavor {
  dev,
  stg,
  prod,
}

extension FlavorX on Flavor {
  String get nameLabel => switch (this) {
        Flavor.dev => 'Development',
        Flavor.stg => 'Staging',
        Flavor.prod => 'Production',
      };
}
