# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

user = User.find_or_create_by!(email_address: "usuario@exemplo.com") do |u|
  u.password = "senha123"
  u.password_confirmation = "senha123"
end

Todo.destroy_all
List.destroy_all


mercado = user.lists.create!(
  name: "Compras do Mercado",
  description: "Lista de compras para a semana"
)

mercado.todos.create!([
  { name: "Arroz", description: "2 pacotes de 5kg", completed: true },
  { name: "Feijão", description: "3 pacotes de 1kg", completed: true },
  { name: "Frutas", description: "Maçã, banana e laranja", completed: true },
  { name: "Legumes", description: "Tomate, cebola e batata", completed: false },
  { name: "Carne", description: "1kg de carne moída e frango", completed: false },
  { name: "Pão", description: "Pão francês e integral", completed: false },
  { name: "Leite", description: "4 litros de leite integral", completed: true },
  { name: "Ovos", description: "2 dúzias", completed: true }
])

casa = user.lists.create!(
  name: "Tarefas de Casa",
  description: "Limpeza e organização do lar"
)

casa.todos.create!([
  { name: "Limpar a cozinha", description: "Lavar louça e limpar fogão", completed: true },
  { name: "Aspirar a sala", description: "Passar aspirador em todos os cômodos", completed: true },
  { name: "Lavar roupa", description: "Separar e lavar roupas brancas e coloridas", completed: false },
  { name: "Trocar lençóis", description: "Trocar lençóis de todos os quartos", completed: false },
  { name: "Limpar banheiros", description: "Desinfetar e organizar", completed: true },
  { name: "Organizar armários", description: "Revisar e organizar armários da cozinha", completed: false }
])

trabalho = user.lists.create!(
  name: "Projetos de Trabalho",
  description: "Tarefas profissionais da semana"
)

trabalho.todos.create!([
  { name: "Reunião com cliente", description: "Apresentar proposta do novo projeto", completed: true },
  { name: "Revisar código", description: "Code review do PR #123", completed: true },
  { name: "Atualizar documentação", description: "Documentar novas funcionalidades", completed: false },
  { name: "Implementar testes", description: "Criar testes unitários para módulo de autenticação", completed: false },
  { name: "Deploy em produção", description: "Fazer deploy da versão 2.0", completed: false },
  { name: "Responder e-mails", description: "Verificar e responder e-mails pendentes", completed: true },
  { name: "Atualizar tarefas no Jira", description: "Mover cards para Done", completed: true }
])

estudos = user.lists.create!(
  name: "Estudos e Aprendizado",
  description: "Materiais para estudar e cursos"
)

estudos.todos.create!([
  { name: "Curso de Ruby on Rails", description: "Assistir módulos 5 e 6", completed: true },
  { name: "Ler artigo sobre TDD", description: "Artigo sobre Test-Driven Development", completed: true },
  { name: "Praticar algoritmos", description: "Resolver 5 exercícios no LeetCode", completed: false },
  { name: "Estudar padrões de projeto", description: "Factory, Observer e Decorator", completed: false },
  { name: "Assistir palestra sobre DevOps", description: "Conferência online às 19h", completed: false }
])

viagem = user.lists.create!(
  name: "Viagem de Fim de Semana",
  description: "Preparativos para a viagem à praia"
)

viagem.todos.create!([
  { name: "Reservar hotel", description: "Hotel na praia para 3 noites", completed: true },
  { name: "Comprar protetor solar", description: "FPS 50+", completed: true },
  { name: "Fazer mala", description: "Roupas leves e de banho", completed: false },
  { name: "Separar documentos", description: "RG, CPF e cartão de crédito", completed: false },
  { name: "Verificar previsão do tempo", description: "Checar clima para os próximos dias", completed: true },
  { name: "Abastecer o carro", description: "Encher o tanque antes de viajar", completed: false },
  { name: "Preparar playlist", description: "Criar playlist para a viagem", completed: true }
])

saude = user.lists.create!(
  name: "Academia e Saúde",
  description: "Rotina de exercícios e cuidados com a saúde"
)

saude.todos.create!([
  { name: "Treino de segunda", description: "Peito e tríceps - concluído!", completed: true },
  { name: "Treino de terça", description: "Costas e bíceps - concluído!", completed: true },
  { name: "Treino de quarta", description: "Pernas e ombros", completed: false },
  { name: "Agendar consulta médica", description: "Check-up anual", completed: false },
  { name: "Comprar suplementos", description: "Whey protein e creatina", completed: false },
  { name: "Beber 2 litros de água", description: "Meta diária de hidratação", completed: true }
])

hobbies = user.lists.create!(
  name: "Hobbies e Lazer",
  description: "Atividades de entretenimento"
)

hobbies.todos.create!([
  { name: "Terminar livro atual", description: "Últimos 3 capítulos", completed: true },
  { name: "Assistir filme novo", description: "Novo lançamento no streaming", completed: true },
  { name: "Jogar videogame", description: "Continuar campanha do jogo", completed: true },
  { name: "Praticar violão", description: "30 minutos de prática", completed: true }
])

projetos = user.lists.create!(
  name: "Projetos Pessoais",
  description: "Ideias e projetos para desenvolver"
)
