import 'package:bloc/bloc.dart';
import 'package:logistics/bloc/fintech_state.dart';
import 'fintech_event.dart';

class FintechBloc extends Bloc<FintechEvent, FintechState> {
  FintechBloc() : super(const FintechState()) {
    on<AddSalaryEvent>(_addSalary);
  }

  Future<void> _addSalary(AddSalaryEvent event, Emitter<FintechState> emitter) async {
    double balance = state.accountBalance + event.updatedBalance;
    List<String> list = [...state.transactionHistory, ...event.updatedHistory];
    emitter(state.copyWith(accountBalance: balance, transactionHistory: list));
  }
}
