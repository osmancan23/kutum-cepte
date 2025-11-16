enum HayalSubeEnum {
  istanbul,
  ankara,
  izmir,
  mersin,
  almanya;

  String get value {
    switch (this) {
      case HayalSubeEnum.istanbul:
        return 'ISTANBUL';
      case HayalSubeEnum.ankara:
        return 'ANKARA';
      case HayalSubeEnum.izmir:
        return 'IZMIR';
      case HayalSubeEnum.mersin:
        return 'MERSIN';
      case HayalSubeEnum.almanya:
        return 'ALMANYA';
    }
  }
}
