class AppConstants {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    // defaultValue: 'http://192.168.100.9:8000',
    defaultValue: 'https://api.ericksondutra.cloud',
  );

  static const String escalasEndpoint = '$baseUrl/api/escalas/';
  static const String musicosEndpoint = '$baseUrl/api/musicos/';
  static const String eventosEndpoint = '$baseUrl/api/eventos/';
}

class AppRoutes {
  static const String home = '/home';
  static const String musicos = '/musicos';
  static const String eventos = '/eventos';
  static const String escalas = '/escalas';
}
