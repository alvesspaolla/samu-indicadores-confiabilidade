# Confiabilidade e desempenho dos indicadores de resposta do SAMU 192 em Minas Gerais

Projeto prático individual da disciplina de ciência de dados — Paolla [SOBRENOME] — [MATRÍCULA]

## Resumo

O SAMU 192 de Minas Gerais é operado por consórcios intermunicipais, e a SES-MG precisa acompanhar indicadores de desempenho
(tempos de resposta, resolubilidade e desfecho) em um painel atualizado quase em tempo real. Os registros do sistema de origem
(VELP) têm lacunas e inconsistências. Este projeto (i) caracteriza o desempenho do serviço e (ii) mede quanto de cada indicador pode
ser considerado confiável, produzindo regras de qualidade reaproveitáveis no painel.

## Perguntas de pesquisa

1. **Tempo de resposta:** como variam T1, T2 e T3 entre consórcios, prioridades, tipos de unidade, faixas horárias e anos?
2. **Fatores do tempo:** que fatores explicam o tempo até a chegada à cena, e é possível prever atendimentos acima do percentil 90?
3. **Resolubilidade:** que proporção das chamadas se resolve sem envio de ambulância ou sem transporte, e é possível prever a necessidade de transporte?
4. **Desfecho:** que características e tempos se associam ao óbito e ao momento em que ocorre, dentro de cada prioridade?
5. **Falhas de dados:** qual a extensão das falhas por consórcio e ano, há grupos semelhantes, e quanto os indicadores mudam com registros confiáveis?

## Estrutura do repositório

| Pasta | Conteúdo |
|---|---|
| `data/` | Dicionário de dados, descrição da amostra e a amostra derivada e anonimizada (`amostra_samu_derivada.csv`) |
| `sql/` | Consulta que gera a amostra anonimizada no SQL Editor do Databricks |
| `notebooks/` | Notebooks da análise de qualidade (Entrega 1) e de geração da amostra (alternativa em Python) |
| `docs/` | Relatórios e materiais entregues |

## Dados e privacidade

A base original (sistema VELP, camadas bronze e prata no Databricks da SES-MG) contém dados de saúde e identificadores pessoais e
**não faz parte deste repositório** (LGPD). O que está aqui é uma **amostra derivada e anonimizada**: sem datas ou horas absolutas,
sem coordenadas e sem nomes, com chaves embaralhadas e k-anonimato (k mínimo de 5). Detalhes em [`data/LEIAME_DADOS.md`](data/LEIAME_DADOS.md).
O arquivo `.gitignore` bloqueia exportações brutas (CSV, Excel, JSON, Parquet) para evitar commits acidentais.

## Como reproduzir

**Amostra derivada (SQL):** abra `sql/gerar_amostra_anonimizada.sql` no SQL Editor do Databricks com um SQL Warehouse, troque o segredo
(`TROQUE-POR-UM-TEXTO-ALEATORIO-LONGO`) por um texto aleatório seu, execute sem limite de linhas e baixe o resultado completo.
**Não versione o segredo.**

**Análise de qualidade (Python):** importe `notebooks/entrega1_qualidade_samu_v2.ipynb` em um workspace Databricks com computação Python
(serverless ou cluster), ajuste a primeira célula e execute. As saídas são tabelas agregadas.

## Andamento

- [x] Definição do tema, base e perguntas (Entrega 1)
- [ ] Pipeline de pré-processamento reprodutível e primeiros modelos (Entrega 2)
- [ ] Modelos finais, interpretação e relatório (Entrega final)

## Licença e uso

Uso restrito a fins acadêmicos e de avaliação. É proibido tentar reidentificar pessoas ou atendimentos.
Licença dos dados: [DEFINIR COM A SES-MG]. Licença do código: [DEFINIR].

Contato: [E-MAIL]
