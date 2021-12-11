import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/voucher_type_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class VoucherTypeDropdown extends StatefulWidget {
  const VoucherTypeDropdown({Key key}) : super(key: key);

  @override
  _VoucherTypeDropdownState createState() => _VoucherTypeDropdownState();
}

class _VoucherTypeDropdownState extends State<VoucherTypeDropdown> {
  VoucherTypeDropdownBloc voucherTypeDropdownBloc;

  @override
  void initState() {
    voucherTypeDropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: DecorationForms(),
        child: FutureBuilder<List<VoucherType>>(
            future: voucherTypeDropdownBloc.voucherTypeDropdownData,
            builder: (context, snapshot) {
              return StreamBuilder<VoucherType>(
                  stream: voucherTypeDropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<VoucherType>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: voucherTypeDropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<VoucherType>>((e) {
                        return DropdownMenuItem<VoucherType>(
                          value: e,
                          child: Text(e.strName),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}

class VoucherTypeGodownDropdown extends StatefulWidget {
  const VoucherTypeGodownDropdown({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_VoucherTypeGodownDropdown();


}

class _VoucherTypeGodownDropdown extends State<VoucherTypeGodownDropdown> {
  VoucherTypeDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: DecorationForms(),
        child: FutureBuilder<List<StrRecord>>(
            future: _dropdownBloc.data,
            builder: (context, snapshot) {
              return StreamBuilder<StrRecord>(
                  stream: _dropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<StrRecord>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<StrRecord>>((e) {
                        return DropdownMenuItem<StrRecord>(
                          value: e,
                          child: Text(e.Godown),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}

class Purchase_order_selectDropdown extends StatefulWidget {
  const Purchase_order_selectDropdown({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_Purchase_order_selectDropdown();


}

class _Purchase_order_selectDropdown extends State<Purchase_order_selectDropdown> {
  VoucherTypeDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: DecorationForms(),
        child: FutureBuilder<List<StrRecord>>(
            future: _dropdownBloc.data,
            builder: (context, snapshot) {
              return StreamBuilder<StrRecord>(
                  stream: _dropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<StrRecord>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<StrRecord>>((e) {
                        return DropdownMenuItem<StrRecord>(
                          value: e,
                          child: Text(e.Purchase_order_select),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}

class SupplierDropdown extends StatefulWidget {
  const SupplierDropdown({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_SupplierDropdown();


}

class _SupplierDropdown extends State<SupplierDropdown> {
  VoucherTypeDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = VoucherTypeDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: DecorationForms(),
        child: FutureBuilder<List<StrRecord>>(
            future: _dropdownBloc.data,
            builder: (context, snapshot) {
              return StreamBuilder<StrRecord>(
                  stream: _dropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<StrRecord>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<StrRecord>>((e) {
                        return DropdownMenuItem<StrRecord>(
                          value: e,
                          child: Text(e.Supplier),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}



