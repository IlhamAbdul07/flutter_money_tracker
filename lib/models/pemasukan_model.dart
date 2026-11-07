class PemasukanModel {
  final String idPemasukan;
  final int nominal;
  final DateTime tanggal;
  final String idSumber;
  final String idRekening;
  String? catatan;

  PemasukanModel({
    required this.idPemasukan,
    required this.nominal,
    required this.tanggal,
    required this.idSumber,
    required this.idRekening,
    this.catatan,
  });

  factory PemasukanModel.fromMap(Map<String, dynamic> map) {
    return PemasukanModel(
      idPemasukan: (map['id_Pemasukan'] as String),
      nominal: (map['nominal'] as int),
      tanggal: DateTime.parse(map['tanggal'] as String),
      idSumber: (map['id_sumber'] as String),
      idRekening: (map['id_rekening'] as String),
      catatan: map['catatan'] != null ? (map['catatan'] as String) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_Pemasukan': idPemasukan,
      'nominal': nominal,
      'tanggal': tanggal.toIso8601String(),
      'id_sumber': idSumber,
      'id_rekening': idRekening,
      'catatan': catatan,
    };
  }
}
