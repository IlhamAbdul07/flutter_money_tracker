class RekeningModel {
  final String idRekening;
  final String namaRekening;
  final int saldo;
  final bool isActive;

  RekeningModel({
    required this.idRekening,
    required this.namaRekening,
    required this.saldo,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_rekening': idRekening,
      'nama_rekening': namaRekening,
      'saldo': saldo,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory RekeningModel.fromMap(Map<String, dynamic> map) {
    return RekeningModel(
      idRekening: (map['id_rekening'] as String),
      namaRekening: (map['nama_rekening'] as String),
      saldo: (map['saldo'] as int),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
