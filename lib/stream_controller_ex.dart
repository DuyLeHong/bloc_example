

import 'dart:async';

void main() async {
  // tạo stream controller
  var streamController = StreamController();

  // lắng nghe
  streamController.stream.listen(hamXuly, onDone: _onDone, onError: (Object error) {
    print(error);
  }, cancelOnError: true);

  //print(100);
  // push events
  streamController.sink.add('CodeFresher');
  streamController.sink.add(1001);

  // Khi không cần sử dụng controller này nữa thì nên close controller
  await Future.delayed(Duration(seconds: 2)); // sau 2 giây ta sẽ close controller
  await streamController.close();

  // sau khi close mà chúng ta vẫn cố push event sẽ gặp Exception:
  // Unhandled exception: Bad state: Cannot add new events after calling close
  //streamController.sink.add(11); // cố push event sau khi controller đã close
}

void hamXuly (dynamic data) {
  print(data);
}

void _onDone () {
  print('Xu ly xong');
}

void _onError (Object error) {
  print(error);
}


