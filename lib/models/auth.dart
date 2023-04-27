class AppUser {
  String uuid = '';
  String email;
  String password;
  bool isProfessor = false;

  AppUser(this.email, this.password, this.isProfessor);
}