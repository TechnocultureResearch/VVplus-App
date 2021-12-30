// get and post url
class ApiService{

  static const String postApiURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"10/11/2021","StrDepartmentCode":"AD2","StrIndentorCode":"SG344","StrPreparedByCode":"SA","StrIndGrid":[{"StrItemCode":"PN1","DblQuantity":"100","StrCostCenterCode":"AD1","StrRequiredDate":"10/11/2021","StrRemark":"remark2"}]}'}";

  static const String getIndentorNameURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Indentor","StrSiteCode":"AS","StrV_Type":"IND","StrChkNonStockabl// e":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostC// enterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getDepartmentNameURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Department","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getVoucherTypeURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getItemNameURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Item","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"N","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getItemCurrentStatusURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"ItemCurrentStatus","StrSiteCode":"","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"AL1","StrCostCenterCode":"AS1","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":"AS1"},{"StrCostCenterCode":"AS1"}]}'}";

  static const String getItemCostCenterURL = "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"ItemCostCenter","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"N","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

// mock data get url

  static const String mockDataIndentorNameURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/IndentorName.json";

  static const String mockDataDepartmentNameURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/DepartmentName.json";

  static const String mockDataVoucherTypeURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/VoucherType.json";

  static const String mockDataItemNameURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemName.json";

  static const String mockDataItemCurrentStatusURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemCurrentStatus.json";

  static const String mockDataItemCostCenterURL = "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemCostCenter.json";

// mock data post url

  static const String materialReqPostURL = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataMaterialRequestEntry.json";

  static const String mockDataPostDailyManPowerURL = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/ContractorPageData/0/PostDataDailyManPower.json";

  static const String mockDataPostMaterialRequestEntryURL = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataMaterialRequestEntry.json";

  static const String mockDataPostStockIssueEntry = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostStockIssueEntry.json";

  static const String mockDataPostStockReceiveEntry = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostStockReceiveEntry.json";

  static const String mockDataPostItemDetail = "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostItemDetail.json";

}