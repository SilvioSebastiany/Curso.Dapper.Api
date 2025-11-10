# 🎯 Curso Dapper API - Aprendizado e Documentação

Este projeto é um **laboratório de aprendizado** para dominar o **Dapper**, um micro ORM para .NET que oferece alta performance para acesso a dados.

## 📋 O que é o Dapper?

O **Dapper** é um micro ORM (Object-Relational Mapping) criado pela equipe do Stack Overflow, conhecido por:
- ⚡ **Alta Performance** - Quase tão rápido quanto ADO.NET puro
- 🪶 **Simplicidade** - API minimalista e fácil de usar
- 🎯 **Controle** - Você escreve o SQL, o Dapper mapeia os resultados
- 📦 **Leve** - Adiciona pouco overhead ao projeto

## 🏗️ Arquitetura do Projeto

### Estrutura Atual
```
Curso.Dapper.Api/
├── Controllers/
│   └── AlunosController.cs   # 🎮 Controller REST API com CRUD completo
├── Entidades/
│   └── Aluno.cs              # 📝 Modelo de domínio
├── Scripts/
│   └── Scripts.sql           # 🗄️ Scripts SQL da tabela ALUNOS + dados
├── Properties/
│   └── launchSettings.json   # ⚙️ Configurações de execução
├── .vscode/                  # 🔧 Configurações do VS Code
├── oracle-data/              # 🗄️ Volume Docker (dados Oracle)
├── Program.cs                # 🚀 Entry point da aplicação
├── docker-compose.yaml       # 🐳 Configuração do banco Oracle
├── appsettings.json          # ⚙️ Configurações da aplicação
├── Curso.Dapper.Api.csproj   # 📦 Arquivo do projeto .NET
├── .gitignore                # 🚫 Arquivos ignorados pelo Git
└── README.md                 # 📖 Este arquivo
```

## 🐳 Infraestrutura - Oracle Database

### Docker Compose
O projeto utiliza **Oracle XE 21c** em container Docker para praticar com um banco enterprise:

```yaml
# docker-compose.yaml
services:
  curso.dapper.api:
    image: gvenzl/oracle-xe:21-slim
    ports:
      - "1521:1521"  # Oracle Database
      - "5500:5500"  # Enterprise Manager
    environment:
      - ORACLE_PASSWORD=oracle
      - APP_USER=appuser
      - APP_USER_PASSWORD=app123
    volumes:
      - ./oracle-data:/opt/oracle/oradata  # Persistência
```

### Por que Oracle?
- 🏢 **Enterprise**: Simula ambiente corporativo real
- 🔧 **Recursos avançados**: Procedures, packages, triggers
- 📊 **Performance**: Otimizações e índices complexos
- 🎓 **Aprendizado**: Conhecimento valioso no mercado

### Comandos Docker
```powershell
# Subir o banco
docker-compose up -d

# Ver logs
docker-compose logs -f

# Parar o banco
docker-compose down

# Conectar no banco (dentro do container)
docker exec -it oracle-xe-curso-dapper sqlplus system/oracle@//localhost:1521/XEPDB1
```

## 📊 Modelo de Dados

### 🗄️ Tabela ALUNOS (Oracle)
```sql
CREATE TABLE ALUNOS (
    ID                  NUMBER(10)      NOT NULL,           -- 🔑 Chave primária (auto-increment)
    NOME                VARCHAR2(100),                      -- 👤 Nome completo
    EMAIL               VARCHAR2(150),                      -- 📧 Email único
    DATA_NASCIMENTO     DATE            NOT NULL,           -- 🎂 Data de nascimento
    ATIVO               NUMBER(1)       DEFAULT 1 NOT NULL, -- ✅ Status (1=Ativo, 0=Inativo)
    CURSO               VARCHAR2(100),                      -- 🎓 Nome do curso
    TURMA               VARCHAR2(50),                       -- 👥 Identificação da turma
    TURNO               VARCHAR2(20),                       -- 🕐 Turno (Manhã/Tarde/Noite)
    DATA_CADASTRO       TIMESTAMP,                          -- 📅 Data de criação
    DATA_ATUALIZACAO    TIMESTAMP,                          -- ✏️ Data de atualização
    USUARIO_CADASTRO    VARCHAR2(50),                       -- 👨‍💻 Usuário que criou
    USUARIO_ATUALIZACAO VARCHAR2(50),                       -- 👨‍💻 Usuário que atualizou

    CONSTRAINT PK_ALUNOS PRIMARY KEY (ID)
);
```

### 📝 Entidade C# - Aluno
```csharp
public class Aluno
{
    public int Id { get; set; }                    // 🔑 Chave primária
    public string Nome { get; set; }               // 👤 Nome completo
    public string Email { get; set; }              // 📧 Email único
    public DateTime DataNascimento { get; set; }   // 🎂 Data de nascimento
    public bool Ativo { get; set; }                // ✅ Status ativo/inativo
    public DateTime DataCadastro { get; set; }     // 📅 Timestamp criação
    public DateTime? DataAtualizacao { get; set; } // ✏️ Timestamp atualização
    public string Curso { get; set; }              // 🎓 Nome do curso
    public string Turma { get; set; }              // 👥 Identificação da turma
    public string Turno { get; set; }              // 🕐 Manhã/Tarde/Noite
}
```

### 🔧 Recursos Implementados
- ✅ **Auto-increment**: Sequência `SEQ_ALUNOS_ID` + Trigger `TRG_ALUNOS_ID`
- ✅ **Constraint**: Primary Key na coluna ID
- ✅ **Valores padrão**: ATIVO = 1 (ativo por padrão)
- ✅ **Auditoria**: Campos para controle de usuário e data
- ✅ **Tipos Oracle**: NUMBER, VARCHAR2, DATE, TIMESTAMP

### 📁 Scripts SQL Organizados
O arquivo `Scripts/Scripts.sql` contém:
```sql
-- Criação da tabela ALUNOS com todos os campos
CREATE TABLE ALUNOS (...)

-- Sequência para auto-increment
CREATE SEQUENCE SEQ_ALUNOS_ID START WITH 1;

-- Trigger para popular ID automaticamente
CREATE OR REPLACE TRIGGER TRG_ALUNOS_ID ...

-- 15 registros de exemplo inseridos
INSERT INTO ALUNOS (NOME, EMAIL, ...) VALUES (...)

-- Consultas de verificação e estatísticas
SELECT * FROM ALUNOS;
```

## 🎮 **API REST Implementada**

### 📋 **Endpoints Disponíveis:**

| Método | Endpoint | Descrição | Status |
|--------|----------|-----------|---------|
| GET | `/Alunos` | Listar todos os alunos | ✅ Funcionando |
| GET | `/Alunos/{id}` | Buscar aluno por ID | ✅ Funcionando |
| POST | `/Alunos` | Cadastrar novo aluno | ✅ Funcionando |
| PUT | `/Alunos/{id}` | Atualizar aluno completo | ✅ Funcionando |
| DELETE | `/Alunos/{id}` | Deletar aluno | ✅ Funcionando |

### 🔧 **Tecnologias Implementadas:**

#### **Dapper + Oracle:**
```csharp
// Conexão Oracle configurada
using var connection = new OracleConnection(_connectionString);

// Sintaxe Oracle com parâmetros nomeados
var aluno = await connection.QuerySingleOrDefaultAsync<Aluno>(
    "SELECT * FROM ALUNOS WHERE ID = :id", new { id });
```

#### **SqlKata Query Builder:**
```csharp
// Query Builder para consultas dinâmicas
var query = new Query("ALUNOS").Select("*").OrderBy("ID");
var sqlResult = _compiler.Compile(query);
var alunos = await connection.QueryAsync<Aluno>(sqlResult.Sql, sqlResult.NamedBindings);
```

#### **Oracle Features:**
```csharp
// INSERT com RETURNING (Oracle específico)
INSERT INTO ALUNOS (...) VALUES (...) RETURNING ID INTO :id

// Funções Oracle
SYSTIMESTAMP, USER, // AUTO-INCREMENT via SEQUENCE + TRIGGER
```

## 🧪 **Exemplos de Uso da API**

### 📋 **1. Listar Todos os Alunos**
```bash
GET https://localhost:7275/Alunos
```
**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "João Silva Santos",
    "email": "joao.silva@email.com",
    "dataNascimento": "1995-03-15T00:00:00",
    "ativo": true,
    "dataCadastro": "2025-11-08T10:30:00",
    "dataAtualizacao": null,
    "curso": "Engenharia de Software",
    "turma": "ES-2024-1",
    "turno": "NOITE"
  }
]
```

### 🔍 **2. Buscar Aluno por ID**
```bash
GET https://localhost:7275/Alunos/1
```

### ➕ **3. Cadastrar Novo Aluno**
```bash
POST https://localhost:7275/Alunos
Content-Type: application/json

{
  "nome": "Ana Costa Silva",
  "email": "ana.costa@email.com",
  "dataNascimento": "1998-05-20",
  "ativo": true,
  "curso": "Ciência da Computação",
  "turma": "CC-2024-2",
  "turno": "MANHÃ"
}
```

### ✏️ **4. Atualizar Aluno**
```bash
PUT https://localhost:7275/Alunos/1
Content-Type: application/json

{
  "nome": "João Silva Santos Junior",
  "email": "joao.junior@email.com",
  "dataNascimento": "1995-03-15",
  "ativo": true,
  "curso": "Engenharia de Software",
  "turma": "ES-2024-1",
  "turno": "INTEGRAL"
}
```

### 🗑️ **5. Deletar Aluno**
```bash
DELETE https://localhost:7275/Alunos/1
```
```

## 🛠️ Tecnologias Utilizadas

- **Framework**: .NET 9.0
- **Tipo**: ASP.NET Core Web API
- **ORM**: Dapper (a ser implementado)
- **Banco**: Oracle XE 21c
- **Container**: Docker + Docker Compose
- **IDE**: Visual Studio Code

### 🔧 Extensões VS Code Recomendadas
- **Oracle SQL Developer Extension** - Extensão oficial para Oracle
- **Database Client** - Interface visual para bancos
- **Language PL/SQL** - Syntax highlighting para PL/SQL
- **GitLens** - Melhor integração com Git

### 📦 Pacotes NuGet Instalados
```xml
<PackageReference Include="Dapper" Version="2.1.66" />
<PackageReference Include="Oracle.ManagedDataAccess.Core" Version="23.26.0" />
<PackageReference Include="SqlKata" Version="4.0.1" />
<PackageReference Include="Swashbuckle.AspNetCore" Version="9.0.6" />
<PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="9.0.10" />
```

## 📚 Roadmap de Aprendizado

### ✅ Fase 1: Configuração Base
- [x] Projeto ASP.NET Core Web API criado
- [x] Oracle Database configurado via Docker
- [x] Modelo de entidade `Aluno` definido
- [x] Estrutura de pastas organizada
- [x] Tabela ALUNOS criada no Oracle
- [x] Sequência e trigger para auto-increment
- [x] Scripts SQL organizados na pasta Scripts/

### ✅ Fase 2: Implementação Dapper (Concluído!)
- [x] Instalar pacote Dapper e Oracle.ManagedDataAccess
- [x] Instalar SqlKata para Query Builder
- [x] Configurar string de conexão Oracle
- [x] Implementar Controller com operações CRUD
- [x] Criar operações CRUD básicas funcionais
- [x] Configurar Swagger/OpenAPI
- [x] Mapear controllers no Program.cs

### � Fase 3: Operações Avançadas (Próximo)
- [ ] Queries complexas com JOIN
- [ ] Stored Procedures e Packages Oracle
- [ ] Transações e controle de concorrência
- [ ] Mapeamento de relacionamentos (1:N, N:N)
- [ ] Paginação e ordenação dinâmica
- [ ] Bulk operations (inserção em lote)
- [ ] Filtros dinâmicos com SqlKata

### 🎯 Fase 4: Boas Práticas (Planejado)
- [ ] Repository Pattern e Dependency Injection
- [ ] Tratamento de exceções personalizado
- [ ] Logging estruturado (Serilog)
- [ ] Testes unitários (xUnit + Moq)
- [ ] Performance e otimização
- [x] Documentação da API (Swagger) ✅
- [ ] Versionamento de API
- [ ] Autenticação e Autorização

## 🚀 Como Executar

### Pré-requisitos
- Docker e Docker Compose
- .NET 9.0 SDK
- Visual Studio Code (recomendado)

### Passos
1. **Clone o repositório**
   ```powershell
   git clone <url-do-repositorio>
   cd Curso.Dapper.Api
   ```

2. **Suba o banco Oracle**
   ```powershell
   docker-compose up -d
   ```

3. **Execute a aplicação**
   ```powershell
   dotnet run
   ```

4. **Execute os scripts SQL**
   ```powershell
   # Conectar no Oracle via VS Code (Oracle SQL Developer Extension)
   # Ou via SQLPlus:
   docker exec -it oracle-xe-curso-dapper sqlplus system/oracle@//localhost:1521/XEPDB1

   # Execute o conteúdo de Scripts/Scripts.sql
   ```

5. **Execute a aplicação**
   ```powershell
   dotnet run
   ```

6. **Acesse a API**
   - API: `https://localhost:7275` (ou porta configurada)
   - Swagger: `https://localhost:7275/swagger`
   - OpenAPI: `https://localhost:7275/openapi/v1.json`

## 📖 Conceitos de Dapper (A Implementar)

### Connection Management Oracle (Implementado)
```csharp
// ✅ Pacotes instalados
// Dapper 2.1.66
// Oracle.ManagedDataAccess.Core 23.26.0
// SqlKata 4.0.1

// ✅ Configuração no appsettings.json
"ConnectionStrings": {
  "OracleConnection": "User Id=appuser;Password=app123;Data Source=localhost:1521/XEPDB1;"
}

// ✅ Configuração no Controller
private readonly string _connectionString;
private readonly OracleCompiler _compiler;

public AlunosController(IConfiguration configuration)
{
    _connectionString = configuration.GetConnectionString("OracleConnection") ??
                      "Data Source=localhost:1521/XEPDB1;User Id=system;Password=oracle;";
    _compiler = new OracleCompiler();
}
```### Query Básica Oracle
```csharp
// SELECT simples
var alunos = connection.Query<Aluno>("SELECT * FROM ALUNOS ORDER BY ID");

// SELECT com parâmetros Oracle (usar :parametro)
var aluno = connection.QuerySingle<Aluno>(
    "SELECT * FROM ALUNOS WHERE ID = :id",
    new { id = 1 });

// SELECT com filtros
var alunosAtivos = connection.Query<Aluno>(
    "SELECT * FROM ALUNOS WHERE ATIVO = :ativo ORDER BY NOME",
    new { ativo = 1 });
```

### Operações CRUD Oracle
```csharp
// INSERT (o ID é gerado automaticamente pelo trigger)
var novoId = connection.QuerySingle<int>(@"
    INSERT INTO ALUNOS (NOME, EMAIL, DATA_NASCIMENTO, CURSO, TURMA, TURNO)
    VALUES (:nome, :email, :dataNascimento, :curso, :turma, :turno)
    RETURNING ID INTO :id",
    new {
        nome = "João Silva",
        email = "joao@email.com",
        dataNascimento = new DateTime(1995, 5, 15),
        curso = "Engenharia de Software",
        turma = "ES-2024-1",
        turno = "NOITE"
    });

// UPDATE
var linhasAfetadas = connection.Execute(@"
    UPDATE ALUNOS
    SET NOME = :nome, EMAIL = :email, CURSO = :curso
    WHERE ID = :id",
    new { nome = "João Santos", email = "joao.santos@email.com", curso = "Ciência da Computação", id = 1 });

// DELETE
connection.Execute("DELETE FROM ALUNOS WHERE ID = :id", new { id = 1 });

// SELECT com mapeamento para propriedades diferentes
var alunos = connection.Query<Aluno>(@"
    SELECT
        ID,
        NOME,
        EMAIL,
        DATA_NASCIMENTO as DataNascimento,
        CASE WHEN ATIVO = 1 THEN 1 ELSE 0 END as Ativo,
        DATA_CADASTRO as DataCadastro,
        DATA_ATUALIZACAO as DataAtualizacao,
        CURSO,
        TURMA,
        TURNO
    FROM ALUNOS
    ORDER BY ID");
```

## 📝 Notas de Aprendizado

### Por que Dapper vs Entity Framework?
- **Dapper**: Controle total do SQL, performance máxima, curva de aprendizado menor
- **EF Core**: Abstração maior, recursos avançados (migrations, change tracking), mais produtivo para CRUDs simples

### Quando usar Dapper?
- ✅ Queries complexas e otimizadas
- ✅ Performance crítica
- ✅ Integração com sistemas legados
- ✅ Controle fino sobre o SQL
- ✅ Stored procedures complexas

## 📄 Licença

Projeto de estudo - uso livre para aprendizado.

