import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/bloc/fintech_bloc.dart';
import 'package:logistics/bloc/fintech_event.dart';
import 'package:logistics/bloc/fintech_state.dart';
import 'package:logistics/constants/theme_constants.dart';
import 'package:logistics/views/search_cities_page.dart';
import 'package:logistics/widgets/monthly_overview_dialog_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FintechBloc, FintechState>(
      builder: (context, state) {
        return _buildUI(state.accountBalance, state.transactionHistory);
      },
    );
  }

  Widget _buildUI(double accountBalance, List<String> transactionHistory) {
    return Scaffold(
      backgroundColor: ThemeConstants.black,
      appBar: AppBar(
        title: const Text('Fintech App'),
        backgroundColor: ThemeConstants.red,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => SearchCitiesPage()));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Account Balance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {},
                ),
              ],
            ),
            Text(
              '\$${accountBalance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.read<FintechBloc>().add(
                      AddSalaryEvent(
                        1000.0,
                        ['Received \$1000 as salary'],
                      ),
                    );
              },
              icon: Icon(Icons.attach_money),
              label: Text('Add Salary'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Show monthly overview dialog
                showMonthlyOverviewDialog(accountBalance, context);
              },
              icon: Icon(Icons.calendar_today),
              label: Text('Monthly Overview'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(transactionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
