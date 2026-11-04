class JenisPengeluaranModel {
  final String idJenisPengeluaran;
  final String jenisPengeluaran;
  final String idIcon;
  final bool isActive;

  JenisPengeluaranModel({
    required this.idJenisPengeluaran,
    required this.jenisPengeluaran,
    required this.idIcon,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_jenis_pengeluaran': idJenisPengeluaran,
      'jenis_pengeluaran': jenisPengeluaran,
      'id_icon': idIcon,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory JenisPengeluaranModel.fromMap(Map<String, dynamic> map) {
    return JenisPengeluaranModel(
      idJenisPengeluaran: (map['id_jenis_pengeluaran'] as String),
      jenisPengeluaran: (map['jenis_pengeluaran'] as String),
      idIcon: (map['id_icon'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
