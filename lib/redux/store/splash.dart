

class Splash {
  final bool shouldShowLoginButton;

  Splash({
    this.shouldShowLoginButton,
  });

  Splash.init()
      : this.shouldShowLoginButton = false;

  Splash copyWith({
    bool shouldShowLoginButton,
  }) =>
      Splash(
        shouldShowLoginButton: shouldShowLoginButton ?? this.shouldShowLoginButton,
      );

  @override
  String toString() {
    return 'Splash{shouldShowLoginButton: $shouldShowLoginButton}';
  }
}
