class Hours {
  int? t1;
  int? t2;
  String? desc;

  Hours(this.t1, this.t2, this.desc);

  Hours.fromMap(Map<String, dynamic> res)
      : t1 = res["t1"],
        t2 = res["t2"],
        desc = res["desc"];

  Map<String, Object?> toMap() {
    return {'t1': t1, 't2': t2, 'desc': desc};
  }

  @override
  String toString() {
    return 'Dog{t1: $t1, t2: $t2, desc: $desc}';
  }
}
