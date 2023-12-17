abstract class FintechEvent {}

class AddSalaryEvent extends FintechEvent {
  final double updatedBalance;
  final List<String> updatedHistory;

  AddSalaryEvent(this.updatedBalance, this.updatedHistory);
}
