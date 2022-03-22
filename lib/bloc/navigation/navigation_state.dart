import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends NavigationState {
  final int currentIndex;

  const CurrentIndexChanged(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends NavigationState {
  @override
  String toString() => 'PageLoading';
}

class HomePageLoaded extends NavigationState {

  @override
  String toString() => 'HomePageLoaded';
}

class OtherPageLoaded extends NavigationState {

  @override
  String toString() => 'OtherPageLoaded';
}
