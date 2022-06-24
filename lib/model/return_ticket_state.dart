abstract class ReturnTicketState {}

class Returnable extends ReturnTicketState {
  final double fee;

  Returnable(this.fee);
}

class OverdueReturning extends ReturnTicketState {}

class NotSuitableTicketClass extends ReturnTicketState {}
