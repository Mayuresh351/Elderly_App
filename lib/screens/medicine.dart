class Medicine {
  final String medicineName;
  final String medicineType;
  final String selectTime;

  Medicine({

    this.medicineName,
    this.medicineType,
    this.selectTime,

  });

  String get getName => medicineName;

  String get getType => medicineType;

  String get getStartTime => selectTime;


 // Map<String, dynamic> toJson() {
  //  return {

   //   "name": this.medicineName,
   //   "type": this.medicineType,
 //     "select": this.selectTime,
  //  };
 // }

 // factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
 //   return Medicine(

 //     medicineName: parsedJson['name'],
  //    medicineType: parsedJson['type'],
  //    selectTime: parsedJson['start'],
  //  );
  }
