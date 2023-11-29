class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇪🇹", "አማርኛ", "am"),
      Language(2, "🇺🇸", "English", "en"),
      Language(3, "🇪🇹", "Afaan Oromoo", "or"),
      Language(4, "🇪🇹/🇸🇴", "Soomaali", "sl"),
      Language(5, "🇪🇹", "Wolaytta", "uk"),
      Language(6, "🇪🇹", "ትግርኛ", "tr"),
      Language(7, "🇰🇪", "Swahili", "sw"),
    ];
  }
}