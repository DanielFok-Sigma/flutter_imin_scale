class IminScaleObj{
  final String weight;
  final String weightStatus;

  IminScaleObj(this.weight, this.weightStatus);

  factory IminScaleObj.fromJson(Map<String, dynamic> json) {
    return IminScaleObj(json['weight'], json['weightStatus']);
  }
}