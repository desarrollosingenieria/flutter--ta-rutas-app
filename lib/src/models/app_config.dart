class AppConfig {
  final double factorSize;
  final String factorText;
  final bool editMode;
  final bool highContrast;
  final double ttsVolume; // Range: 0-1
  final double ttsRate; // Range: 0-2
  final double ttsPitch; // Range: 0-2
  final String? ttsText;

  AppConfig({
    required this.highContrast,
    required this.factorSize,
    required this.factorText,
    required this.editMode,
    required this.ttsPitch,
    required this.ttsRate,
    this.ttsText,
    required this.ttsVolume,
  });

  AppConfig copyWith({
    double? factorSize,
    String? factorText,
    bool? editMode,
    bool? highContrast,
    double? ttsVolume,
    double? ttsRate,
    double? ttsPitch,
    String? ttsText,
  }) =>
      AppConfig(
          factorSize: factorSize ?? this.factorSize,
          factorText: factorText ?? this.factorText,
          editMode: editMode ?? this.editMode,
          highContrast: highContrast ?? this.highContrast,
          ttsVolume: ttsVolume ?? this.ttsVolume,
          ttsPitch: ttsPitch ?? this.ttsPitch,
          ttsRate: ttsRate ?? this.ttsRate,
          ttsText: ttsText ?? this.ttsText);
}
