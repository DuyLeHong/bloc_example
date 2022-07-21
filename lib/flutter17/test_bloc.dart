

import 'package:bloc_example/flutter17/remote_bloc.dart';
import 'package:bloc_example/flutter17/remote_event.dart';
import 'package:bloc_example/flutter17/remote_state.dart';

void main() async {
  // tạo đối tượng bloc
  final bloc = RemoteBloc();

  // UI lắng nghe state thay đổi để update UI
  bloc.stateController.stream.listen((RemoteState state) {
    print('Âm lượng hiện tại: ${state.volume}');
  });

  // giả sử 1s sau, user click vào tăng âm lượng thêm 5
  await Future.delayed(Duration(seconds: 1));
  bloc.eventController.sink.add(IncrementEvent(5)); // từ UI push event đến bloc

  // giả sử 2s sau, user click vào giảm âm lượng đi 10
  await Future.delayed(Duration(seconds: 2));
  bloc.eventController.sink.add(DecrementEvent(10)); // từ UI push event đến bloc

  // giả sử 3s sau, user click vào mute luôn
  await Future.delayed(Duration(seconds: 3));
  bloc.eventController.sink.add(MuteEvent()); // từ UI push event đến bloc
}
