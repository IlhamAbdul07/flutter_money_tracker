class AnggaranModel {
  final String idAnggaran;
  final String namaAnggaran;
  final int nominalAnggaran;
  final String idJenisPengeluaran;
  final String idIcon;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;

  AnggaranModel({
    required this.idAnggaran,
    required this.namaAnggaran,
    required this.nominalAnggaran,
    required this.idJenisPengeluaran,
    required this.idIcon,
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  factory AnggaranModel.fromMap(Map<String, dynamic> map) {
    return AnggaranModel(
      idAnggaran: (map['id_anggaran'] as String),
      namaAnggaran: (map['nama_anggaran'] as String),
      nominalAnggaran: (map['nominal_anggaran'] as int),
      idJenisPengeluaran: (map['id_jenis_pengeluaran'] as String),
      idIcon: (map['id_icon'] as String),
      tanggalMulai: DateTime.parse(map['tanggal_mulai'] as String),
      tanggalSelesai: DateTime.parse(map['tanggal_selesai'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_anggaran': idAnggaran,
      'nama_anggaran': namaAnggaran,
      'nominal_anggaran': nominalAnggaran,
      'id_jenis_pengeluaran': idJenisPengeluaran,
      'id_icon': idIcon,
      'tanggal_mulai': tanggalMulai.toIso8601String().substring(0, 10),
      'tanggal_selesai': tanggalSelesai.toIso8601String().substring(0, 10),
    };
  }
}
