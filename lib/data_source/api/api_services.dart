// get and post urls
class ApiService {
  static const String postApiURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostIndent?StrRecord=${'{"StrIndTypeCode":"IND","StrSiteCode":"AD","StrIndNo":"11","StrIndDate":"10/11/2021","StrDepartmentCode":"AD2","StrIndentorCode":"SG344","StrPreparedByCode":"SA","StrIndGrid":[{"StrItemCode":"PN1","DblQuantity":"100","StrCostCenterCode":"AD1","StrRequiredDate":"10/11/2021","StrRemark":"remark2"}]}'}";

  static const String getIndentorNameURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Indentor","StrSiteCode":"AS","StrV_Type":"IND","StrChkNonStockabl// e":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostC// enterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getDepartmentNameURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Department","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getDepartmentNamenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetDRM?StrRecord=${'{"StrFilter":"PartyName","StrSiteCode":"AD"}'}";

  static const String getVoucherTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockReceive?StrRecord= ${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getVouchertypeStockIssuenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getGoDownnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockReceive?StrRecord=${'{"StrFilter":"Godown","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getStockIssueGodownnewUrl =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"Godown","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getVoucherTypeURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getReceivedBynewUrl =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockReceive?StrRecord=${'{"StrFilter":"ReceivedBy","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getIssuedTonewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"IssuedTo","StrSiteCode":"AD","StrV_Type":" ISU "}'}";

  static const String getStockIssueTonewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"IssuedTo","StrSiteCode":"AD","StrV_Type":" ISU "}'}";

  static const String getItemNameURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"Item","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"N","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getItemCurrentStatusURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"ItemCurrentStatus","StrSiteCode":"","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"AL1","StrCostCenterCode":"AS1","StrAllCostCenter":"","StrUPCostCenter":[{"StrCostCenterCode":"AS1"},{"StrCostCenterCode":"AS1"}]}'}";

  static const String getStockReceiveItemCurrentStatusewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockReceive?StrRecord=${'{"StrFilter":"Item","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getStockIssueItemCurrentStatusnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"Item","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getItemCostCenterURL =
      "http://103.136.82.200:777/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndent?StrRecord=${'{"StrFilter":"ItemCostCenter","StrSiteCode":"AS","StrV_Type":"","StrChkNonStockable":"","StrItemCode":"","StrCostCenterCode":"","StrAllCostCenter":"N","StrUPCostCenter":[{"StrCostCenterCode":""},{"StrCostCenterCode":""}]}'}";

  static const String getItemCostCenternewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockReceive?StrRecord=${'{"StrFilter":"CostCenter","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getStockIssueCostCenternewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStockIssue?StrRecord=${'{"StrFilter":"CostCenter","StrSiteCode":"AD","StrV_Type":""}'}";

  static const String getDailyManpowerCostCenternewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetDRM?StrRecord=${'{"StrFilter":"CostCenter","StrSiteCode":"AD"}'}";

  static const String getDailyManpowerResourceTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetDRM?StrRecord=${'{"StrFilter":"Resource","StrSiteCode":"AD"}'}";

  static const String getChequeReceiveVoucherTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetChequeReceiving?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrV_Type":"","StrCustCode":""}'}";

  static const String getChequePaymentTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetChequeReceiving?StrRecord=${'{"StrFilter":"Type","StrSiteCode":"AD","StrV_Type":"","StrCustCode":""}'}";

  static const String getCreditAccontnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetChequeReceiving?StrRecord=${'{"StrFilter":"CreditAc","StrSiteCode":"AD","StrV_Type":"","StrCustCode":""}'}";

  static const String getDrawnBanknewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetChequeReceiving?StrRecord=${'{"StrFilter":"DrawnBank","StrSiteCode":"AD","StrV_Type":"","StrCustCode":"AD22"}'}";

  static const String postMaterialRequestEntryURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FPostStkReceive";

  static const String getStagenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetOtherSchedule?StrRecord=${'{"StrFilter":"Stage","StrSiteCode":"AD","StrDueDate":"2022-04-25"}'}";

  static const String getBookingIdnewUrl =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetOtherSchedule?StrRecord=${'{"StrFilter":"BookingNo","StrSiteCode":"AD","StrDueDate":""}'}";

  static const String getExtraWorkVouchernewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetOtherSchedule?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrDueDate":""}'}";

  static const String getTaxOHnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetOtherSchedule?StrRecord=${'{"StrFilter":"TaxOH","StrSiteCode":"AD","StrDueDate":""}'}";

  static const String getChangeApplicableURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetUnitCancellation?StrRecord=${'{"StrFilter":"ChangeApplicable","StrSiteCode":"AD"}'}";

  static const String getTaxOHUnitCancelationnewUrl =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetUnitCancellation?StrRecord=${'{"StrFilter":"TaxOH","StrSiteCode":"AD"}'}";

  static const String getPhasetoPhaseVoucherTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseIssuedTonewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord=${'{"StrFilter":"IssuedTo","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseFromGodownnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord= ${'{"StrFilter":"Godown","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseToGodownnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord=${'{"StrFilter":"ToGodown","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseFromCostCenternewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord= ${'{"StrFilter":"CostCenter","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseToCostCenternewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord= ${'{"StrFilter":"ToCostCenter","StrSiteCode":"AD"}'}";

  static const String getPhaseToPhaseItemCurrentStatusnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPhaseTransfer?StrRecord=${'{"StrFilter":"Item","StrSiteCode":"AD"}'}";

  static const String getMaterialReqApprovalIndentSelectionnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetIndentApproval?StrRecord=${'{"StrFilter":"IndentNo","StrSiteCode":"VN","StrV_Date":"",StrIndDocID:[{"StrDocID":""},{"StrDocID":""}]}'}";

  static const String getPOVoucherTypenewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPO?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrStateCode":"","Strv_type":"GORD"}'}";

  static const String getSuppliernewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetPO?StrRecord=${'{"StrFilter":"Supplier","StrSiteCode":"AD","StrStateCode":"BH","Strv_type":"GORD"}'}";

  static const String getBToBSendnewURl =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AD","StrStateCode":"","StrPLTCode":"","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getBToBSendFromCostCenter =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"CostCenter","StrSiteCode":"AD","StrStateCode":"","StrPLTCode":"","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getBToBSendFromGodown =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"Godown","StrSiteCode":"AD","StrStateCode":"","StrPLTCode":"","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getBToBSendToCostCenter =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"CostCenterTo","StrSiteCode":"AA","StrStateCode":"","StrPLTCode":"","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getSiteToBToBSendnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"SiteTo","StrSiteCode":"AD","StrStateCode":"GJ","StrPLTCode":"1","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getIndentNoBToBSendnewURL = "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"IndentNo","StrSiteCode":"AA","StrStateCode":"","StrPLTCode":"","StrIndDocID":"","StrItemCode":"","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getIndentSelectionBToBSendnewURL =
      "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkTrnMan?StrRecord=${'{"StrFilter":"FillSelectedIndent","StrSiteCode":"AA","StrStateCode":"","StrPLTCode":"","StrIndDocID":"DAAIND   2017     202","StrItemCode":"BX154","StrGodown":"","StrMaintainStockValue":""}'}";

  static const String getVouchertypeBToBReceivenewURL = "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkIntransit?StrRecord=${'{"StrFilter":"VoucherType","StrSiteCode":"AA","StrPartyCode":"","StrStkTrnManID":""}'}";

  static const String getSupplierBToBReceivenewURL = "http://43.228.113.108:888/Individual_WebSite/LoginInfo_WS/WCF/WebService_Test.asmx/FGetStkIntransit?StrRecord=${'{"StrFilter":"Supplier","StrSiteCode":"AA","StrPartyCode":"","StrStkTrnManID":""}'}";

  // mock database get url

  static const String mockDataIndentorNameURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/IndentorName.json";

  static const String mockDataDepartmentNameURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/DepartmentName.json";

  static const String mockDataVoucherTypeURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/VoucherType.json";

  static const String mockDataItemNameURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemName.json";

  static const String mockDataItemCurrentStatusURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemCurrentStatus.json";

  static const String mockDataItemCostCenterURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/StrRecord/0/ItemCostCenter.json";

// mock database post url

  static const String materialReqPostURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataMaterialRequestEntry.json";

  static const String mockDataPostDailyManPowerURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/ContractorPageData/0/PostDataDailyManPower.json";

  static const String mockDataPostMaterialRequestEntryURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataMaterialRequestEntry.json";

  static const String mockDataPostPlacePurchaseOrderURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataPlacePurchaseOrder.json";

  static const String mockDataPostGoodsReceiveEntryURL =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostDataGoodsReceiptEntry.json";

  static const String mockDataPostStockIssueEntry =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostStockIssueEntry.json";

  static const String mockDataPostStockReceiveEntry =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostStockReceiveEntry.json";

  static const String mockDataPostPhaseToPhaseTransfer =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostPhaseToPhaseTransfer.json";

  static const String mockDataPostBranchToBranchSend =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostBranchToBranchSend.json";

  static const String mockDataPostBranchToBranchReceive =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/StorePageData/0/PostBranchToBranchReceive.json";

  static const String mockDataPostExtraWorkEntry =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostExtraWorkEntry.json";

  static const String mockDataPostUnitCancellation =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostUnitCancellation.json";

  static const String mockDataPostDiscountApproval =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostDiscountApproval.json";

  static const String mockDataPostChequeReceive =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostChequeReceive.json";

  static const String mockDataPostChequeDeposit =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostChequeDeposit.json";

  static const String mockDataPostChequeCleared =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/SalesPageData/0/PostChequeCleared.json";

  static const String mockDataPostItemDetail =
      "https://vv-plus-app-default-rtdb.firebaseio.com/PostDataRecord/0/PurchasePageData/0/PostItemDetail.json";
}
