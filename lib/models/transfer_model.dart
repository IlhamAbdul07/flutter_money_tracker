class TransferModel {
  final String idTransfer;
  final int nominalTransfer;
  final String sumberRekId;
  final String tujuanRekId;
  final DateTime tanggalTransfer;
  String? catatanTransfer;

  TransferModel({
    required this.idTransfer,
    required this.nominalTransfer,
    required this.sumberRekId,
    required this.tujuanRekId,
    required this.tanggalTransfer,
    this.catatanTransfer,
  });

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      idTransfer: (map['id_transfer'] as String),
      nominalTransfer: (map['nominal_transfer'] as int),
      sumberRekId: (map['sumber_rekening_id'] as String),
      tujuanRekId: (map['tujuan_rekening_id'] as String),
      tanggalTransfer: DateTime.parse(map['tanggal_transfer'] as String),
      catatanTransfer: map['catatan_transfer'] != null
          ? (map['catatan_transfer'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_transfer': idTransfer,
      'nominal_transfer': nominalTransfer,
      'sumber_rekening_id': sumberRekId,
      'tujuan_rekening_id': tujuanRekId,
      'tanggal_transfer': tanggalTransfer.toIso8601String(),
      'catatan_transfer': catatanTransfer,
    };
  }
}
