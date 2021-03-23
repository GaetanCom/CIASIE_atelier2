class Member {
  int id = -1;
  String firstName = "";
  String lastName = "";
  String mail = "";
  String pseudo = "";
  String password = "";

  Member(i, f, l, m, p, pa) {
    this.id = i;
    this.firstName = f;
    this.lastName = l;
    this.mail = m;
    this.pseudo = p;
    this.password = pa;
  }
  Member.empty();
}
