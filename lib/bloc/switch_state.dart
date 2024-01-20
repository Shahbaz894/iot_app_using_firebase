import 'package:equatable/equatable.dart';

class SwitchState extends Equatable{
  final bool switchValue;
  final double slider;
  const SwitchState({this.slider=1,this.switchValue=false});
  SwitchState copyWith({bool? switchValue,double?slider}){

    return SwitchState(
      switchValue: switchValue ?? this.switchValue,
      slider: slider ??this.slider

    );

}
  @override
  // TODO: implement props
  List<Object?> get props => [switchValue,slider];

}