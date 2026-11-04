class IconModel {
  final String idIcon;
  final String namaIcon;
  final bool isActive;

  IconModel({
    required this.idIcon,
    required this.namaIcon,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_icon': idIcon,
      'nama_icon': namaIcon,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory IconModel.fromMap(Map<String, dynamic> map) {
    return IconModel(
      idIcon: (map['id_icon'] as String),
      namaIcon: (map['nama_icon'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
