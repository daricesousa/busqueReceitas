
class TimerConvert {

  TimerConvert._();
  static String forString(int time){
    if(time == 0){
      return "0m";
    }
    final duration = Duration(minutes: time);
    final list = duration.toString().split(':');
    final hour = int.parse(list[0]);
    final min = int.parse(list[1]);
    String str = '';
    if(hour>0){
      str += "${hour.toString()}h ";
    }
    if(min>0){
      str += "${min.toString()}m";
    }
    return str;
  }
}