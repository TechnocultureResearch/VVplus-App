import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/material_request_entry_ddata_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/material_request_entry_post_data_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class ItemCostCenterDropdown11 extends StatefulWidget {
  const ItemCostCenterDropdown11({Key key}) : super(key: key);

  @override
  _ItemCostCenterDropdown11State createState() => _ItemCostCenterDropdown11State();
}

class _ItemCostCenterDropdown11State extends State<ItemCostCenterDropdown11> {
  MaterialRequestEntryPostDataBloc materialRequestEntryPostDataDropdownBloc;
MaterialRequestEntryPostData selectmaterialReqEntryPost;
  @override
  void initState() {
    materialRequestEntryPostDataDropdownBloc = MaterialRequestEntryPostDataBloc();
    super.initState();
  }
  void onDataChange1(MaterialRequestEntryPostData state) {
    setState(() {
      selectmaterialReqEntryPost = state;
    });
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
        child: FutureBuilder<List<MaterialRequestEntryPostData>>(
            future: materialRequestEntryPostDataDropdownBloc.materialRequestEntryPostData,
            builder: (context, snapshot) {
              return StreamBuilder<MaterialRequestEntryPostData>(
                  stream: materialRequestEntryPostDataDropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<MaterialRequestEntryPostData>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: onDataChange1,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<MaterialRequestEntryPostData>>((e) {
                        return DropdownMenuItem<MaterialRequestEntryPostData>(
                          value: e,
                          child: Text(e.indentSubCode??''),
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
