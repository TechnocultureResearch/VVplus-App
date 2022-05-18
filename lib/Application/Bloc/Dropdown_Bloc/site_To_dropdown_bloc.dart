
import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:vvplus_app/infrastructure/Models/site_to_model.dart';
import 'package:vvplus_app/infrastructure/Repository/site_to_repository.dart';

class SiteToDropdownBloc{
  final siteToDropdownRepository = SiteToRepository();
  final siteToDropdownGetData = BehaviorSubject<SiteTo>();

  Future<List<SiteTo>> siteToDropdownData;
  Stream<SiteTo> get selectedSiteToState => siteToDropdownGetData;
  void selectedSiteToStateEvent(SiteTo state) => siteToDropdownGetData.add(state);

  SiteToDropdownBloc(){
    siteToDropdownData = SiteToRepository().getSiteToData();
  }
  void dispose(){
    siteToDropdownGetData.close();
  }
}