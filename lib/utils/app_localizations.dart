class AppTexts {
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome, Vendor!',
      'sendOtp': 'Send OTP',
      'notifications': 'Notifications',
      'submitTask': 'Submit Task for Review',
    },
    'hi': {
      'welcome': 'स्वागत है विक्रेता!',
      'sendOtp': 'ओटीपी भेजें',
      'notifications': 'सूचनाएं',
      'submitTask': 'कार्य सबमिट करें',
    },
    'mr': {
      'welcome': 'विक्रेत्याचे स्वागत आहे!',
      'sendOtp': 'ओटीपी पाठवा',
      'notifications': 'सूचना',
      'submitTask': 'कार्य सबमिट करा',
    },
    'kn': {
      'welcome': 'ಮಾರಾಟಗಾರರಿಗೆ ಸ್ವಾಗತ!',
      'sendOtp': 'OTP ಕಳುಹಿಸಿ',
      'notifications': 'ಅಧಿಸೂಚನೆಗಳು',
      'submitTask': 'ಕಾರ್ಯ ಸಲ್ಲಿಸಿ',
    },
  };

  static String get(String key, String lang) {
    return _localizedValues[lang]?[key] ?? key;
  }
}
