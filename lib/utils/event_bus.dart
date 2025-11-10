import 'dart:async';

enum EventType { accountLogin, accountLogout }

class Event {
  final EventType type;
  final dynamic data;

  Event({required this.type, this.data});
}

class EventBus {
  EventBus({bool sync = false}) : _controller = StreamController.broadcast(sync: sync);

  final StreamController<Event> _controller;
  StreamController<Event> get controller => _controller;

  StreamSubscription<Event> listen({required List<EventType> type, required void Function(Event event) onEvent}) {
    return _controller.stream.where((event) => type.contains(event.type)).listen(onEvent);
  }

  void fire({required EventType type, dynamic data}) {
    _controller.add(Event(type: type, data: data));
  }

  void dispose() {
    _controller.close();
  }
}
