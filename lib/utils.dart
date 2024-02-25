class NetConfig {
  static const ip = '10.10.16.16';//'192.168.0.9';
  static const port = '8000';
  static const link = '$ip:$port';
}

const List<String> tipos = ['coordenador', 'professor'];

// Recebe um texto em formato 'HH:MM - DIA' e retorna em HHMMDIA
String dataToText(String e) {
  return e[0] + e[1] + e[3] + e[4] + e[8] + e[9] + e[10];
}

// Recebe três parametros de texto e retorna em 'texto1:texto2 - texto3'
String textToDataHora(String h) {
  return '${h.substring(0, 2)}:${h.substring(2, 4)} - ${h.substring(4)}';
}

// Recebe um texto em formato HHMMDIA e retorna em HH:MM - DIA
String textToDataJoin(String hora, String minuto, String dia) {
  return '$hora:$minuto - $dia';
}

// Recebe um texto em DDMMAAAA e retorn em DD/MM/AAAA
String textToData(String h) {
  return '${h.substring(0, 2)}/${h.substring(2, 4)}/${h.substring(4, 8)}';
}

// recebe um dia da semana em formato DIA e retorna a proxima data correspondente
String nextDay(String str) {
  Map<String, int> dayOfWeekMap = {
    'SEG': DateTime.monday,
    'TER': DateTime.tuesday,
    'QUA': DateTime.wednesday,
    'QUI': DateTime.thursday,
    'SEX': DateTime.friday,
    'SAB': DateTime.saturday,
    'DOM': DateTime.sunday,
  };

  DateTime now = DateTime.now();

  int desiredWeekday = dayOfWeekMap[str] ?? -1;
  if (desiredWeekday == -1) {
    return 'invalido';
  }

  DateTime nextDate =
      now.add(Duration(days: (desiredWeekday - now.weekday + 7) % 7));

  String formattedDate =
      '${nextDate.day.toString().padLeft(2, '0')}/${nextDate.month.toString().padLeft(2, '0')}/${nextDate.year}';

  return formattedDate;
}
