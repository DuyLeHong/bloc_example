import 'dart:async';

void main() async {
  // tạo broadcast stream controller
  var streamController = StreamController.broadcast();

  // subscription thứ nhất
  streamController.stream.listen((event) {
    if (event is void Function(Object?)) {
      (event).call('subscription thứ 1: call function');
      //print('subscription thứ 1: ${event.call('call function')}');
    } else {
      print('subscription thứ 1: $event');
    }

  }, onError: (Object _error) {
    print('subscription thứ 1: ' + _error.toString());
    //streamController.close();
  });

  // subscription thứ hai sẽ double giá trị của event lên
  // streamController.stream.listen((event) {
  //   print('subscription thứ 2: ${event + event}'); // double value lên
  // });

  // push events
  streamController.sink.add('CodeFresher');

  //streamController.sink.addError('da bi loi gi do');

  await Future.delayed(Duration(seconds: 1));

  streamController.sink.add(1002);

  streamController.sink.add(HamTruyenVao);
}

void HamTruyenVao(Object? data) {
  print(data.toString());
}
