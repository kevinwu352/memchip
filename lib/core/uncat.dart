// final v = ...;
// return v != null ? init(v) : null;
//
// withValue(getMap(key), (v) => v != null ? init(v) : null);
T2 withValue<T1, T2>(T1 v, T2 Function(T1 v) h) => h(v);

// time check
bool timeValid(DateTime? time, Duration duration) => time != null && time.add(duration).isAfter(DateTime.now());
bool timeExpired(DateTime? time, Duration duration) => time == null || time.add(duration).isBefore(DateTime.now());
