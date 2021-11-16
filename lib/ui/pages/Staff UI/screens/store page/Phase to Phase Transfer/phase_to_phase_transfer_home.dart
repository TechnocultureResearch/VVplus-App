import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/staff_provider.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Phase%20to%20Phase%20Transfer/phase_to_phase_transfer_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class PhaseToPhaseTransferPage extends StatefulWidget{
  const PhaseToPhaseTransferPage({Key key}) : super(key: key);

  @override
  _PhaseToPhaseTransferPageState createState() => _PhaseToPhaseTransferPageState();
}

class _PhaseToPhaseTransferPageState extends State<PhaseToPhaseTransferPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialProvider(
      child: Scaffold(
        appBar: AppBarSatff("Phase to Phase Transfer"),
        body: const PhaseToPhaseTransferBody(),
        bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}

