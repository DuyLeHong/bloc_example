

class RemoteState {
  RemoteState({ this.volume,  this.channel});

  int? volume;
  int? channel;

  static const KEY_CURRENT_CHANNEL = 'current_channel';
  static const KEY_CURRENT_VOLUME = 'current_volume';
}

