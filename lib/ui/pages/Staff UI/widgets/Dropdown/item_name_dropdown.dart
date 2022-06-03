import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class ItemNameDropdown extends StatefulWidget {
  const ItemNameDropdown({Key key}) : super(key: key);

  @override
  _ItemNameDropdownState createState() => _ItemNameDropdownState();
}

class _ItemNameDropdownState extends State<ItemNameDropdown> {
  ItemNameDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = ItemNameDropdownBloc();
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
        decoration: decorationForms(),
        child: FutureBuilder<List<ItemName>>(
            future: _dropdownBloc.itemMaterialReqEntryDropdownData,
            builder: (context, snapshot) {
              return StreamBuilder<ItemName>(
                  stream: _dropdownBloc.selecteditemMaterialReqEnrtyState,
                  builder: (context, item) {
                    return SearchChoices<ItemName>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selecteditemMaterialReqEnrtyStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<ItemName>>((e) {
                        return DropdownMenuItem<ItemName>(
                          value: e,
                          child: Text(e.strItemName),
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
