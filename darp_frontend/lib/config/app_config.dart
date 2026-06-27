class AppConfig {
  AppConfig._();

  // ─── Change ONE line here to switch environments ──────────────────────────
  //
  //  Local dev  (same machine):   _env = _Env.localhost
  //  Device / LAN testing:        _env = _Env.localNetwork
  //  Azure deployment:            _env = _Env.azure
  //
  static const _Env _env = _Env.localhost;
  // ─────────────────────────────────────────────────────────────────────────

  static const String _localhost     = 'http://10.0.2.2:7071';
  static const String _localNetwork  = 'http://192.168.1.100:7071'; // replace with your machine's LAN IP
  static const String _azure         = 'https://your-function-app.azurewebsites.net'; // replace after deployment

  static String get baseUrl {
    switch (_env) {
      case _Env.localhost:
        return _localhost;
      case _Env.localNetwork:
        return _localNetwork;
      case _Env.azure:
        return _azure;
    }
  }
}

enum _Env { localhost, localNetwork, azure }
