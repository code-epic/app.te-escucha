class UserPerfil {
  String nombre;
  String correo;
  String foto;

  UserPerfil({required this.nombre, required this.correo, required this.foto});

  Map<String, dynamic> toJson() =>
      {'nombre': nombre, 'correo': correo, 'foto': foto};

  UserPerfil.fromJson(Map<String, dynamic> json)
      : nombre = json['nombre'],
        correo = json['correo'],
        foto = json['foto'];
}
