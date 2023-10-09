class UserPerfil {
  String cedula;
  String nombre;
  String correo;
  String telefono;
  String direccion;

  String foto;

  UserPerfil(
      {required this.cedula,
      required this.nombre,
      required this.correo,
      required this.foto,
      required this.telefono,
      required this.direccion});

  Map<String, dynamic> toJson() => {
        'cedula': cedula,
        'nombre': nombre,
        'correo': correo,
        'foto': foto,
        'telefono': telefono,
        'direccion': direccion
      };

  UserPerfil.fromJson(Map<String, dynamic> json)
      : cedula = json['cedula'],
        nombre = json['nombre'],
        correo = json['correo'],
        foto = json['foto'],
        telefono = json['telefono'],
        direccion = json['direccion'];
}
