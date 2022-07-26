import 'dart:async';

import 'package:bloc_example/flutter17/remote_event.dart';
import 'package:bloc_example/flutter17/remote_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteBloc {
  var state; // init giá trị khởi tạo của RemoteState. Giả sử TV ban đầu có âm lượng 70

  // tạo 2 controller
  // 1 cái quản lý event, đảm nhận nhiệm vụ nhận event từ UI
  final eventController = StreamController<RemoteEvent>();

  // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>();

  initValues() async {
    final prefs = await SharedPreferences.getInstance();

    int _initVolume = prefs.getInt(RemoteState.KEY_CURRENT_VOLUME) ?? 0;
    int _initChannel = prefs.getInt(RemoteState.KEY_CURRENT_CHANNEL) ?? 0;

    state = RemoteState(volume: _initVolume, channel: _initChannel);

    stateController.sink.add(state);

    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      // người ta thường tách hàm này ra 1 hàm riêng và đặt tên là: mapEventToState
      // đúng như cái tên, hàm này nhận event xử lý và cho ra output là state

      if (event is IncrementEvent) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng âm lượng
        state.volume = state.volume! + event.increment;
      } else if (event is DecrementEvent) {
        // xử lý giảm âm lượng
        state.volume = state.volume! - event.decrement;
      } else if (event is MuteEvent) {
        // xử lý mute
        state.volume = 0;
      } else if (event is IncrementChanelEvent) {
        state.channel = state.channel! + event.increment;
      } else if (event is DecrementChannelEvent) {
        state.channel = state.channel! - event.decrement;
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);

      (prefs).setInt(RemoteState.KEY_CURRENT_CHANNEL, state.channel!);
      (prefs).setInt(RemoteState.KEY_CURRENT_VOLUME, state.volume!);
    });
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() {
    stateController.close();
    eventController.close();
  }
}
