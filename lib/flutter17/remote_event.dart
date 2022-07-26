

abstract class RemoteEvent {}

// event tăng âm lượng, user muốn tăng lên bao nhiêu thì truyền vào biến increment
class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment);

  final int increment;
}

// event giảm âm lượng, user muốn giảm bao nhiêu thì truyền vào biến decrement
class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement);

  final int decrement;
}

// event mute
class MuteEvent extends RemoteEvent {}


class IncrementChanelEvent extends RemoteEvent {
  IncrementChanelEvent({this.increment = 1});

  int increment;
}

class DecrementChannelEvent extends RemoteEvent {
  DecrementChannelEvent({this.decrement = 1});

  int decrement;
}

