class TextData {
  static Map leadTypeData = {
    'available': {
      'icon': 'assets/icons/available.svg',
      'iconfilled': 'assets/icons/available-filled.svg',
      'name': 'Available'
    },
    'exchange': {
      'icon': 'assets/icons/exchange.svg',
      'iconfilled': 'assets/icons/exchange-filled.svg',
      'name': 'Exchange'
    },
    'commission': {
      'icon': 'assets/icons/commission.svg',
      'iconfilled': 'assets/icons/commission-filled.svg',
      'name': 'Commission'
    }
  };

  static List<String> leadType = [
    'commission',
    'exchange',
    'available',
  ];
}
