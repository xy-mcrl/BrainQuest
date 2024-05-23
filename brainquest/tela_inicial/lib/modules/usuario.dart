enum UsuarioType { aluno, professor }

class Usuario {
  String nome;
  String email;
  String senha;
  String matricula;
  String serie;
  String? instituicao;
  UsuarioType tipoUsuario;

  Usuario(
      {required this.nome,
      required this.email,
      required this.senha,
      required this.matricula,
      required this.serie,
      this.instituicao,
      required this.tipoUsuario});
}

List<Usuario> usuarios = [
  Usuario(nome: 'a', email: 'a', senha: 'a', matricula: 'a', serie: 'a', tipoUsuario: UsuarioType.aluno)
];