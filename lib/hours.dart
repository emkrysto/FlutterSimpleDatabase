class Hours {
  int? id;
  DateTime? d1;
  int? t1;
  int? t2;
  String desc;

  Hours(this.d1, this.t1, this.t2, this.desc);

  Hours.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        d1 = DateTime.tryParse(res['d1']),
        t1 = res['t1'],
        t2 = res['t2'],
        desc = res['desc'];

  Map<String, Object?> toMap() {
    return {'id': id, 'd1': 'datetime($d1)', 't1': t1, 't2': t2, 'desc': desc};
  }

  Map<String, Object?> updateToMap() {
    return {'d1': 'datetime($d1)', 't1': t1, 't2': t2, 'desc': desc};
  }

  @override
  String toString() {
    return 'Dog{id: $id, d1: $d1, t1: $t1, t2: $t2, desc: $desc}';
  }
}
