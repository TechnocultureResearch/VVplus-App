

class ResourceType {
 String SearchCode;
 String Name;
 String Code;

 ResourceType({
   this.SearchCode,
   this.Name,
   this.Code,
});

 factory ResourceType.fromJson(Map<String, dynamic> json) => ResourceType(
   SearchCode: json["SearchCode"],
   Name: json["Name"],
   Code: json["Code"],
 );
 Map<String, dynamic> toJson() => {
   "SearchCode": SearchCode,
   "Name": Name,
   "Code": Code
 };

}