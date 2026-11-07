class AnggaranModel {
  final String idAnggaran;
  final String namaAnggaran;
  final int nominalAnggaran;
  final String idRekening;
  final String idIcon;
  final String createdAt;
  final String updatedAt;

  AnggaranModel({
    required this.idAnggaran,
    required this.namaAnggaran,
    required this.nominalAnggaran,
    required this.idRekening,
    required this.idIcon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnggaranModel.fromMap(Map<String, dynamic> map) {
    return AnggaranModel(
      idAnggaran: (map['id_anggaran'] as String),
      namaAnggaran: (map['nama_anggaran'] as String),
      nominalAnggaran: (map['nominal_anggaran'] as int),
      idRekening: (map['id_rekening'] as String),
      idIcon: (map['id_icon'] as String),
      createdAt: (map['created_at'] as String),
      updatedAt: (map['updated_at']as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_anggaran': idAnggaran,
      'nama_anggaran': namaAnggaran,
      'nominal_anggaran': nominalAnggaran,
      'id_rekening': idRekening,
      'id_icon': idIcon,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}