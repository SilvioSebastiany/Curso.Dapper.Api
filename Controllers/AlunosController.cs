using Curso.Dapper.Api.Entidades;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using SqlKata;
using SqlKata.Compilers;

namespace Curso.Dapper.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class AlunosController : ControllerBase
{
    private readonly string _connectionString;
    private readonly OracleCompiler _compiler;

    public AlunosController(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("OracleConnection") ??
                          "Data Source=localhost:1521/XEPDB1;User Id=system;Password=oracle;";
        _compiler = new OracleCompiler();
    }

    [HttpGet(Name = "BuscarAlunos")]
    public async Task<IActionResult> GetAlunos()
    {
        using var connection = new OracleConnection(_connectionString);

        // Usando SqlKata para construir a query
        var query = new Query("ALUNOS").Select("*").OrderBy("ID");
        var sqlResult = _compiler.Compile(query);

        var alunos = await connection.QueryAsync<Aluno>(sqlResult.Sql, sqlResult.NamedBindings);
        return Ok(alunos);
    }

    [HttpGet("{id}", Name = "BuscarAlunoPorId")]
    public async Task<IActionResult> GetAlunoById(int id)
    {
        using var connection = new OracleConnection(_connectionString);
        var aluno = await connection.QuerySingleOrDefaultAsync<Aluno>(
            "SELECT * FROM ALUNOS WHERE ID = :id", new { id });

        if (aluno == null)
            return NotFound();

        return Ok(aluno);
    }

    [HttpPost(Name = "CadastrarAluno")]
    public async Task<IActionResult> CreateAluno([FromBody] Aluno aluno)
    {
        using var connection = new OracleConnection(_connectionString);
        var sql = @"
            INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, ATIVO, DATA_CADASTRO, CURSO, TURMA, TURNO, USUARIO_CADASTRO)
            VALUES (:nome, :email, :dataNascimento, 1, SYSTIMESTAMP, :curso, :turma, :turno, USER)
            RETURNING ID INTO :id
        ";

        var parameters = new
        {
            nome = aluno.Nome,
            email = aluno.Email,
            dataNascimento = aluno.DataNascimento,
            curso = aluno.Curso,
            turma = aluno.Turma,
            turno = aluno.Turno
        };

        var dynamicParams = new DynamicParameters(parameters);
        dynamicParams.Add("id", dbType: System.Data.DbType.Int32, direction: System.Data.ParameterDirection.Output);

        await connection.ExecuteAsync(sql, dynamicParams);
        aluno.Id = dynamicParams.Get<int>("id");

        return CreatedAtRoute("BuscarAlunoPorId", new { id = aluno.Id }, aluno);
    }

    [HttpPut("{id}", Name = "AtualizarAluno")]
    public async Task<IActionResult> UpdateAluno(int id, [FromBody] Aluno aluno)
    {
        using var connection = new OracleConnection(_connectionString);
        var sql = @"
            UPDATE ALUNOS
            SET NOME = :nome,
                EMAIL = :email,
                DATA_NASCIMENTO = :dataNascimento,
                ATIVO = :ativo,
                DATA_ATUALIZACAO = SYSTIMESTAMP,
                CURSO = :curso,
                TURMA = :turma,
                TURNO = :turno,
                USUARIO_ATUALIZACAO = USER
            WHERE ID = :id
        ";

        var affectedRows = await connection.ExecuteAsync(sql, new
        {
            nome = aluno.Nome,
            email = aluno.Email,
            dataNascimento = aluno.DataNascimento,
            ativo = aluno.Ativo ? 1 : 0,
            curso = aluno.Curso,
            turma = aluno.Turma,
            turno = aluno.Turno,
            id
        });

        if (affectedRows == 0)
            return NotFound();

        return NoContent();
    }

    [HttpDelete("{id}", Name = "DeletarAluno")]
    public async Task<IActionResult> DeleteAluno(int id)
    {
        using var connection = new OracleConnection(_connectionString);
        var sql = "DELETE FROM ALUNOS WHERE ID = :id";

        var affectedRows = await connection.ExecuteAsync(sql, new { id });

        if (affectedRows == 0)
            return NotFound();

        return NoContent();
    }
}
