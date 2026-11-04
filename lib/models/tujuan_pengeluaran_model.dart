class TujuanPengeluaranModel {
  final String idTujuan;
  final String idJenisPengeluaran;
  final String tujuanPengeluaran;
  final bool isActive;

  TujuanPengeluaranModel({
    required this.idTujuan,
    required this.idJenisPengeluaran,
    required this.tujuanPengeluaran,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_Tujuan': idTujuan,
      'id_jenis_Pengeluaran': idJenisPengeluaran,
      'Tujuan_Pengeluaran': tujuanPengeluaran,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory TujuanPengeluaranModel.fromMap(Map<String, dynamic> map) {
    return TujuanPengeluaranModel(
      idTujuan: (map['id_Tujuan'] as String),
      idJenisPengeluaran: (map['id_jenis_Pengeluaran'] as String),
      tujuanPengeluaran: (map['Tujuan_Pengeluaran'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
