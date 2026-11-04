class SumberPemasukanModel {
  final String idSumber;
  final String idJenisPemasukan;
  final String sumberPemasukan;
  final bool isActive;

  SumberPemasukanModel({
    required this.idSumber,
    required this.idJenisPemasukan,
    required this.sumberPemasukan,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_sumber': idSumber,
      'id_jenis_pemasukan': idJenisPemasukan,
      'sumber_pemasukan': sumberPemasukan,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory SumberPemasukanModel.fromMap(Map<String, dynamic> map) {
    return SumberPemasukanModel(
      idSumber: (map['id_sumber'] as String),
      idJenisPemasukan: (map['id_jenis_pemasukan'] as String),
      sumberPemasukan: (map['sumber_pemasukan'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
