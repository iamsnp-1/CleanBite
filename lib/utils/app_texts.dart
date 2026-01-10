class AppTexts {
  static const Map<String, Map<String, String>> values = {
    'en': {
      'welcome': 'Welcome, Vendor!',
      'sendOtp': 'Send OTP',
      'submit': 'Submit Task for Review',
      'notifications': 'Notifications',
    },
    'hi': {
      'welcome': 'स्वागत है विक्रेता!',
      'sendOtp': 'ओटीपी भेजें',
      'submit': 'कार्य सबमिट करें',
      'notifications': 'सूचनाएं',
    },
    'mr': {
      'welcome': 'विक्रेत्याचे स्वागत आहे!',
      'sendOtp': 'ओटीपी पाठवा',
      'submit': 'कार्य सबमिट करा',
      'notifications': 'सूचना',
    },
    'kn': {
      'welcome': 'ಮಾರಾಟಗಾರರಿಗೆ ಸ್ವಾಗತ!',
      'sendOtp': 'OTP ಕಳುಹಿಸಿ',
      'submit': 'ಕಾರ್ಯ ಸಲ್ಲಿಸಿ',
      'notifications': 'ಅಧಿಸೂಚನೆಗಳು',
    },
  };

  static String t(String key, String lang) {
    return values[lang]?[key] ?? key;
  }
}
