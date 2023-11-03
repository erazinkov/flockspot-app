class Number {
  int value;

  Number(this.value);

  factory Number.fromJSON(Map<String, dynamic> json) {
    return Number(json['value']);
  }
}
