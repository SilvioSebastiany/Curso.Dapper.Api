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
│   └── Entidades/
│       └── Aluno.cs          # 📝 Modelo de domínio
├── Properties/
│   └── launchSettings.json   # ⚙️ Configurações de execução
├── oracle-data/              # 🗄️ Volume Docker (dados Oracle)
├── Program.cs                # 🚀 Entry point da aplicação
├── docker-compose.yaml       # 🐳 Configuração do banco Oracle
├── appsettings.json          # ⚙️ Configurações da aplicação
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

### Entidade Aluno
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

## 🛠️ Tecnologias Utilizadas

- **Framework**: .NET 9.0
- **Tipo**: ASP.NET Core Web API
- **ORM**: Dapper (a ser implementado)
- **Banco**: Oracle XE 21c
- **Container**: Docker + Docker Compose
- **IDE**: Visual Studio Code

## 📚 Roadmap de Aprendizado

### ✅ Fase 1: Configuração Base
- [x] Projeto ASP.NET Core Web API criado
- [x] Oracle Database configurado via Docker
- [x] Modelo de entidade `Aluno` definido
- [x] Estrutura de pastas organizada

### 🔄 Fase 2: Implementação Dapper (Em Progresso)
- [ ] Instalar pacote Dapper
- [ ] Configurar string de conexão Oracle
- [ ] Implementar Repository Pattern
- [ ] Criar operações CRUD básicas

### 📋 Fase 3: Operações Avançadas (Planejado)
- [ ] Queries complexas com JOIN
- [ ] Stored Procedures e Packages
- [ ] Transações e controle de concorrência
- [ ] Mapeamento de relacionamentos
- [ ] Paginação e ordenação
- [ ] Bulk operations

### 🎯 Fase 4: Boas Práticas (Planejado)
- [ ] Tratamento de exceções
- [ ] Logging estruturado
- [ ] Testes unitários
- [ ] Performance e otimização
- [ ] Documentação da API (Swagger)

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

4. **Acesse a API**
   - API: `https://localhost:7000`
   - Swagger: `https://localhost:7000/swagger` (quando implementado)

## 📖 Conceitos de Dapper (A Implementar)

### Connection Management
```csharp
// Configuração da conexão
services.AddScoped<IDbConnection>(provider =>
    new OracleConnection(connectionString));
```

### Query Básica
```csharp
// SELECT simples
var alunos = connection.Query<Aluno>("SELECT * FROM ALUNOS");

// SELECT com parâmetros
var aluno = connection.QuerySingle<Aluno>(
    "SELECT * FROM ALUNOS WHERE ID = :id",
    new { id = 1 });
```

### Operações CRUD
```csharp
// INSERT
var novoId = connection.QuerySingle<int>(
    "INSERT INTO ALUNOS (NOME, EMAIL) VALUES (:nome, :email) RETURNING ID",
    new { nome = "João", email = "joao@email.com" });

// UPDATE
var linhasAfetadas = connection.Execute(
    "UPDATE ALUNOS SET NOME = :nome WHERE ID = :id",
    new { nome = "João Silva", id = 1 });

// DELETE
connection.Execute("DELETE FROM ALUNOS WHERE ID = :id", new { id = 1 });
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

