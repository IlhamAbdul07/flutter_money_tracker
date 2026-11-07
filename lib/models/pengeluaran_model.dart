class PengeluaranModel {
  final String idPengeluaran;
  final int nominal;
  final DateTime tanggal;
  final String idTujuan;
  final String idRekening;
  String? catatan;

  PengeluaranModel({
    required this.idPengeluaran,
    required this.nominal,
    required this.tanggal,
    required this.idTujuan,
    required this.idRekening,
    this.catatan,
  });

  factory PengeluaranModel.fromMap(Map<String, dynamic> map) {
    return PengeluaranModel(
      idPengeluaran: (map['id_pengeluaran'] as String),
      nominal: (map['nominal'] as int),
      tanggal: DateTime.parse(map['tanggal'] as String),
      idTujuan: (map['id_tujuan'] as String),
      idRekening: (map['id_rekening'] as String),
      catatan: map['catatan'] != null ? (map['catatan'] as String) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_pengeluaran': idPengeluaran,
      'nominal': nominal,
      'tanggal': tanggal.toIso8601String().substring(0, 10),
      'id_tujuan': idTujuan,
      'id_rekening': idRekening,
      'catatan': catatan,
    };
  }
}
