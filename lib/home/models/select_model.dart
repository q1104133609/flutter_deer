class SelectModel {
  String _address;
  String _province;
  String _city;
  String _county;
  String _type;
  String _policyNo;
  String _startDate;
  String _endDate;
  String _coinsFlagDesc;
  String _shareholderDesc;
  String _categoryDesc;
  String _riskName;
  String _damageTime;
  String _reportStartTime;
  String _endCaseTime;
  String _caseStatus;
  String _damageReasonDesc;
  String _lossName;

  SelectModel(
      {String province,
      String address,
      String city,
      String county,
      String type,
      String policyNo,
      String startDate,
      String endDate,
      String coinsFlagDesc,
      String shareholderDesc,
      String categoryDesc,
      String riskName,
      String damageTime,
      String reportStartTime,
      String endCaseTime,
      String caseStatus,
      String damageReasonDesc,
      String lossName}) {
    this._province = province;
    this._city = city;
    this._county = county;
    this._type = type;
    this._policyNo = policyNo;
    this._startDate = startDate;
    this._endDate = endDate;
    this._coinsFlagDesc = coinsFlagDesc;
    this._shareholderDesc = shareholderDesc;
    this._categoryDesc = categoryDesc;
    this._riskName = riskName;
    this._damageTime = damageTime;
    this._reportStartTime = reportStartTime;
    this._endCaseTime = endCaseTime;
    this._caseStatus = caseStatus;
    this._damageReasonDesc = damageReasonDesc;
    this._lossName = lossName;
  }

  String get province => _province;
  set province(String province) => _province = province;
  String get city => _city;
  set city(String city) => _city = city;
  String get county => _county;
  set county(String county) => _county = county;
  String get type => _type;
  set type(String type) => _type = type;
  String get policyNo => _policyNo;
  set policyNo(String policyNo) => _policyNo = policyNo;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get coinsFlagDesc => _coinsFlagDesc;
  set coinsFlagDesc(String coinsFlagDesc) => _coinsFlagDesc = coinsFlagDesc;
  String get shareholderDesc => _shareholderDesc;
  set shareholderDesc(String shareholderDesc) =>
      _shareholderDesc = shareholderDesc;
  String get categoryDesc => _categoryDesc;
  set categoryDesc(String categoryDesc) => _categoryDesc = categoryDesc;
  String get riskName => _riskName;
  set riskName(String riskName) => _riskName = riskName;
  String get damageTime => _damageTime;
  set damageTime(String damageTime) => _damageTime = damageTime;
  String get reportStartTime => _reportStartTime;
  set reportStartTime(String reportStartTime) =>
      _reportStartTime = reportStartTime;
  String get endCaseTime => _endCaseTime;
  set endCaseTime(String endCaseTime) => _endCaseTime = endCaseTime;
  String get address => _address;
  set address(String address) => _address = address;
  String get caseStatus => _caseStatus;
  set caseStatus(String caseStatus) => _caseStatus = caseStatus;
  String get damageReasonDesc => _damageReasonDesc;
  set damageReasonDesc(String damageReasonDesc) =>
      _damageReasonDesc = damageReasonDesc;
  String get lossName => _lossName;
  set lossName(String lossName) => _lossName = lossName;

  SelectModel.fromJson(Map<String, dynamic> json) {
    _province = json['province'];
    _city = json['city'];
    _county = json['county'];
    _type = json['type'];
    _policyNo = json['policyNo'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _coinsFlagDesc = json['coinsFlagDesc'];
    _shareholderDesc = json['shareholderDesc'];
    _categoryDesc = json['categoryDesc'];
    _riskName = json['riskName'];
    _damageTime = json['damageTime'];
    _reportStartTime = json['reportStartTime'];
    _endCaseTime = json['endCaseTime'];
    _caseStatus = json['caseStatus'];
    _damageReasonDesc = json['damageReasonDesc'];
    _lossName = json['lossName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this._province;
    data['city'] = this._city;
    data['county'] = this._county;
    data['type'] = this._type;
    data['policyNo'] = this._policyNo;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['coinsFlagDesc'] = this._coinsFlagDesc;
    data['shareholderDesc'] = this._shareholderDesc;
    data['categoryDesc'] = this._categoryDesc;
    data['riskName'] = this._riskName;
    data['damageTime'] = this._damageTime;
    data['reportStartTime'] = this._reportStartTime;
    data['endCaseTime'] = this._endCaseTime;
    data['caseStatus'] = this._caseStatus;
    data['damageReasonDesc'] = this._damageReasonDesc;
    data['lossName'] = this._lossName;
    return data;
  }
}
