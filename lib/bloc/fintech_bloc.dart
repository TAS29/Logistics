import 'package:bloc/bloc.dart';
import 'package:logistics/bloc/fintech_state.dart';
import 'fintech_event.dart';

class FintechBloc extends Bloc<FintechEvent, FintechState> {
  FintechBloc() : super(const FintechState()) {
    on<AddSalaryEvent>(_addSallary);
  }

  Future<void> _addSallary(AddSalaryEvent event, Emitter<FintechState> emitter) async {
    double bal = state.accountBalance + event.updatedBalance;
    List<String> l = [...state.transactionHistory, ...event.updatedHistory];
    emitter(state.copyWith(accountBalance: bal, transactionHistory: l));
  }
}
