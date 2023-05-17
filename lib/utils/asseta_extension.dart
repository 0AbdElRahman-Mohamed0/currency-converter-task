extension ImagePath on String {
  String get toImage => 'assets/images/$this.png';
  String get toSvg => 'assets/svg/$this.svg';
}
