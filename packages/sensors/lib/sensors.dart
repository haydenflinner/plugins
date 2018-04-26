import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _accelerometerEventChannel =
    const EventChannel('plugins.flutter.io/accelerometer');

const EventChannel _linearEventChannel =
    const EventChannel('plugins.flutter.io/linear');

const EventChannel _gravityEventChannel =
    const EventChannel('plugins.flutter.io/gravity');

const EventChannel _gyroscopeEventChannel =
    const EventChannel('plugins.flutter.io/gyroscope');

class AccelerometerEvent {
  /// Acceleration force along the x axis (including gravity) measured in m/s^2.
  final double x;

  /// Acceleration force along the y axis (including gravity) measured in m/s^2.
  final double y;

  /// Acceleration force along the z axis (including gravity) measured in m/s^2.
  final double z;

  AccelerometerEvent(this.x, this.y, this.z);

  @override
  String toString() => '[AccelerometerEvent (x: $x, y: $y, z: $z)]';
}

/// AccelerometerEvent - GravityEvent = acceleration user is applying to device!
class GravityEvent {
  /// Acceleration force along the x axis of gravity measured in m/s^2.
  final double x;

  /// Acceleration force along the y axis of gravity measured in m/s^2.
  final double y;

  /// Acceleration force along the z axis of gravity measured in m/s^2.
  final double z;

  GravityEvent(this.x, this.y, this.z);

  @override
  String toString() => '[GravityEvent (x: $x, y: $y, z: $z)]';
}

class GyroscopeEvent {
  /// Rate of rotation around the x axis measured in rad/s.
  final double x;

  /// Rate of rotation around the y axis measured in rad/s.
  final double y;

  /// Rate of rotation around the z axis measured in rad/s.
  final double z;

  GyroscopeEvent(this.x, this.y, this.z);

  @override
  String toString() => '[GyroscopeEvent (x: $x, y: $y, z: $z)]';
}

class LinearAccelerometerEvent {
  /// Acceleration force along the x axis (excluding gravity) measured in m/s^2.
  final double x;

  /// Acceleration force along the y axis (excluding gravity) measured in m/s^2.
  final double y;

  /// Acceleration force along the z axis (excluding gravity) measured in m/s^2.
  final double z;

  LinearAccelerometerEvent(this.x, this.y, this.z);

  @override
  String toString() => '[LinearAccelerometerEvent (x: $x, y: $y, z: $z)]';
}

AccelerometerEvent _listToAccelerometerEvent(List<double> list) {
  return new AccelerometerEvent(list[0], list[1], list[2]);
}

LinearAccelerometerEvent _listToLinearAccelerometerEvent(List<double> list) {
  return new LinearAccelerometerEvent(list[0], list[1], list[2]);
}

GravityEvent _listToGravityEvent(List<double> list) {
  return new GravityEvent(list[0], list[1], list[2]);
}

GyroscopeEvent _listToGyroscopeEvent(List<double> list) {
  return new GyroscopeEvent(list[0], list[1], list[2]);
}

Stream<AccelerometerEvent> _accelerometerEvents;
Stream<GravityEvent> _gravityEvents;
Stream<GyroscopeEvent> _gyroscopeEvents;
Stream<LinearAccelerometerEvent> _linearAccelerometerEvents;

/// A broadcast stream of events from the device accelerometer.
Stream<AccelerometerEvent> get accelerometerEvents {
  if (_accelerometerEvents == null) {
    _accelerometerEvents = _accelerometerEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToAccelerometerEvent(event));
  }
  return _accelerometerEvents;
}

/// A broadcast stream of events from the device gravity sensor.
Stream<GravityEvent> get gravityEvents {
  if (_gravityEvents == null) {
    _gravityEvents = _gravityEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToGravityEvent(event));
  }
  return _gravityEvents;
}

/// A broadcast stream of events from the device gyroscope.
Stream<GyroscopeEvent> get gyroscopeEvents {
  if (_gyroscopeEvents == null) {
    _gyroscopeEvents = _gyroscopeEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToGyroscopeEvent(event));
  }
  return _gyroscopeEvents;
}

/// Events from the device accelerometer with gravity removed.
Stream<LinearAccelerometerEvent> get linearAccelerometerEvents {
  if (_linearAccelerometerEvents == null) {
    _linearAccelerometerEvents = _linearEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToLinearAccelerometerEvent(event));
  }
  return _linearAccelerometerEvents;
}
