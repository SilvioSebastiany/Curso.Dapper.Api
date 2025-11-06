using System.Data;

namespace Controllers.Entidades
{
    public class Aluno
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public string Email { get; set; }
        public DateTime DataNascimento { get; set; }
        public bool Ativo { get; set; }
        public DateTime DataCadastro { get; set; }
        public DateTime? DataAtualizacao { get; set; }

        public string Curso { get; set; }
        public string Turma { get; set; }
        public string Turno { get; set; }
    }
}
