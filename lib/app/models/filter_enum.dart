// ignore_for_file: constant_identifier_names, camel_case_types

enum FILTER_ENUM {
  TODAY,
  TOMORROW,
  WEEK,
}

extension FilterDescription on FILTER_ENUM {
  String get description {
    switch(this) {      
      case FILTER_ENUM.TODAY:
        return 'TASK\'S DE HOJE';
        
      case FILTER_ENUM.TOMORROW:
        return 'TASK\'S DE AMANHÃ';
        
      case FILTER_ENUM.WEEK:
        return 'TASK\'S DA SEMANA';
        
    }
  }
}