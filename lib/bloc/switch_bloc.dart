import 'package:bloc/bloc.dart';
import 'package:iot_app_using_firebase/bloc/switch_events.dart';
import 'package:iot_app_using_firebase/bloc/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent,SwitchState>{
  SwitchBloc():super( const SwitchState()){
    on<SwitchOnOffEvent>(_switchOnOFF);
    on<SliderEvent>(_slider);
  }
  void _switchOnOFF(SwitchOnOffEvent event,Emitter<SwitchState>emit){
    emit(state.copyWith(switchValue:!state.switchValue  ));
  }

  void _slider(SliderEvent event,Emitter<SwitchState>emit){
    emit(state.copyWith(slider:event.slider));
  }
}