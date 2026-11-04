class JenisPemasukanModel {
  final String idJenisPemasukan;
  final String jenisPemasukan;
  final String idIcon;
  final bool isActive;

  JenisPemasukanModel({
    required this.idJenisPemasukan,
    required this.jenisPemasukan,
    required this.idIcon,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_jenis_Pemasukan': idJenisPemasukan,
      'jenis_Pemasukan': jenisPemasukan,
      'id_icon': idIcon,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory JenisPemasukanModel.fromMap(Map<String, dynamic> map) {
    return JenisPemasukanModel(
      idJenisPemasukan: (map['id_jenis_Pemasukan'] as String),
      jenisPemasukan: (map['jenis_Pemasukan'] as String),
      idIcon: (map['id_icon'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
