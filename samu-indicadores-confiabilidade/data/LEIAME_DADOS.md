# Amostra derivada e anonimizada — indicadores de resposta do SAMU 192 (Minas Gerais)

Amostra de apoio ao projeto prático **"Confiabilidade e desempenho dos indicadores de resposta do SAMU 192 em Minas Gerais"**
(disciplina de ciência de dados, projeto individual de Paolla [SOBRENOME]).

## O que é

Uma amostra **derivada** de registros de atendimentos do SAMU 192 de Minas Gerais (sistema de regulação VELP), com até 5.000 atendimentos
por consórcio, sorteados de forma reprodutível. Período: de 2019 a 2025, variando por consórcio (alguns consórcios começam em 2021 ou 2022). **Não é a base original**: a base institucional contém dados de saúde e identificadores
pessoais e não é pública (LGPD). Aqui só há informações derivadas, para que o código e as análises do projeto possam ser reproduzidos.

## Arquivos

| Arquivo | Conteúdo |
|---|---|
| `amostra_samu_derivada.csv` | Uma linha por atendimento |
| `dicionario_dados.csv` | Descrição de cada campo |

## O que a amostra contém

- **Durações em minutos** entre os marcos do atendimento (criação, TARM, regulador, acionamento da ambulância, deslocamento, chegada à cena, saída da cena, chegada ao hospital).
- **Indicadores de preenchimento** de cada marco, último dígito do minuto e se o segundo é zero (para testes de qualidade).
- **Sinais de qualidade de GPS**: coordenada nula por marco e distância em linha reta (km, uma casa decimal).
- **Classificação e desfecho**: prioridade ou tipo da chamada, se houve atendimento com recurso, tipo de unidade (USB/USA), tipo de transporte, se houve transporte, óbito e tipo de óbito.
- **Faixa etária e sexo**; ano, dia da semana e faixa horária de 6 horas.

## Como foi anonimizada

- Nenhuma data ou hora absoluta, coordenada, nome de paciente ou de profissional, telefone, endereço, hospital ou placa.
- Chaves de chamada e de atendimento **embaralhadas** com segredo descartado, portanto irreversíveis.
- **k-anonimato (k mínimo de 5)** sobre consórcio, ano, faixa etária, sexo, transporte e óbito: combinações raras foram generalizadas em etapas (tipo de óbito, depois sexo, depois faixa etária, marcados como "suprimido") ou removidas.
- Trava automática que impede a exportação de colunas com nomes de campos identificadores.

## Limitações

- Não reproduz análises que dependam de data ou hora exatas (sazonalidade fina, cruzamento com fontes externas).
- A amostra é limitada por consórcio; **proporções e contagens da amostra não representam o volume real** do serviço.
- Consórcios têm tamanhos e períodos diferentes; interprete resultados por consórcio e considere os intervalos de confiança.
- A faixa horária é provisória e não corresponde ao turno institucional.
- A anonimização reduz o risco de reidentificação, mas não é uma garantia jurídica; a avaliação final cabe ao encarregado de dados da SES-MG.

## Uso

Uso restrito a fins acadêmicos e de avaliação da disciplina. **É proibido tentar reidentificar pessoas ou atendimentos.**
Licença e condições de uso: [DEFINIR COM A SES-MG].

Contato: [E-MAIL]
