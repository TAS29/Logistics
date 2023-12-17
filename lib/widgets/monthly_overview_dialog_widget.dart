import 'package:flutter/material.dart';

void showMonthlyOverviewDialog(accBal,context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Monthly Overview'),
          content: Text('You spent \$3000 on groceries this month.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

