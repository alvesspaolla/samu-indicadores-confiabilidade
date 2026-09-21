
WITH cfg AS (
  /* TROQUE o texto do segredo por um texto aleatorio longo (nao compartilhe). Para teste rapido use max_por_consorcio = 200. */
  SELECT 'TROQUE-POR-UM-TEXTO-ALEATORIO-LONGO' AS salt, 5000 AS max_por_consorcio, 5 AS k_min
),
/* 1) unioes das tabelas, so com colunas da lista branca (nenhum campo de identificacao e lido) */
u AS (
  SELECT 'cisdeste' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisdeste
  UNION ALL
  SELECT 'cisnorje' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisnorje
  UNION ALL
  SELECT 'cisreuno' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisreuno
  UNION ALL
  SELECT 'cisru' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisru
  UNION ALL
  SELECT 'cisrun' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisrun
  UNION ALL
  SELECT 'cissul' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cissul
  UNION ALL
  SELECT 'cistri' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cistri
  UNION ALL
  SELECT 'cisurg_oeste' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.cisurg_oeste
  UNION ALL
  SELECT 'consurge_gv' AS consorcio, IdSamu, NumOcorrencia, IdOcorrencia, Codigo, ComAtendimento, TipoUnidade, TipoTransporte, Obito, TipoObito, Idade, Sexo, HospitalDestino, DataCriacao, DataTarm, DataRegulador, DataRadioOperador, Pj9, Pj10, Sj9, Sj10, LatPj9, LongPj9, LatPj10, LongPj10, LatSj9, LongSj9, LatSj10, LongSj10 FROM prata_dev.vskysamu.consurge_gv
),
/* 2) tipagem e limpeza (vazio vira nulo; horarios dd/MM/yyyy HH:mm:ss ou ISO) */
t AS (
  SELECT consorcio,
  CAST(IdSamu AS STRING) AS idsamu,
  CAST(NumOcorrencia AS STRING) AS numocorrencia,
  CAST(IdOcorrencia AS STRING) AS idocorrencia,
  UPPER(NULLIF(TRIM(CAST(Codigo AS STRING)), '')) AS codigo,
  UPPER(NULLIF(TRIM(CAST(ComAtendimento AS STRING)), '')) AS comatendimento,
  UPPER(NULLIF(TRIM(CAST(TipoUnidade AS STRING)), '')) AS tipounidade,
  NULLIF(TRIM(CAST(TipoTransporte AS STRING)), '') AS tipotransporte,
  UPPER(NULLIF(TRIM(CAST(Obito AS STRING)), '')) AS obito,
  NULLIF(TRIM(CAST(TipoObito AS STRING)), '') AS tipo_obito,
  UPPER(NULLIF(TRIM(CAST(Sexo AS STRING)), '')) AS sexo,
  TRY_CAST(NULLIF(TRIM(CAST(Idade AS STRING)), '') AS INT) AS idade,
  (NULLIF(TRIM(CAST(HospitalDestino AS STRING)), '') IS NOT NULL) AS tem_hosp,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataCriacao AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataCriacao AS STRING)), ''))) AS dc,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataTarm AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataTarm AS STRING)), ''))) AS dtarm,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataRegulador AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataRegulador AS STRING)), ''))) AS dreg,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataRadioOperador AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(DataRadioOperador AS STRING)), ''))) AS drad,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Pj9 AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Pj9 AS STRING)), ''))) AS p9,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Pj10 AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Pj10 AS STRING)), ''))) AS p10,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Sj9 AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Sj9 AS STRING)), ''))) AS s9,
  COALESCE(TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Sj10 AS STRING)), ''), 'dd/MM/yyyy HH:mm:ss'), TRY_TO_TIMESTAMP(NULLIF(TRIM(CAST(Sj10 AS STRING)), ''))) AS s10,
  TRY_CAST(NULLIF(TRIM(CAST(LatPj9 AS STRING)), '') AS DOUBLE) AS lat_p9,
  TRY_CAST(NULLIF(TRIM(CAST(LongPj9 AS STRING)), '') AS DOUBLE) AS lon_p9,
  TRY_CAST(NULLIF(TRIM(CAST(LatPj10 AS STRING)), '') AS DOUBLE) AS lat_p10,
  TRY_CAST(NULLIF(TRIM(CAST(LongPj10 AS STRING)), '') AS DOUBLE) AS lon_p10,
  TRY_CAST(NULLIF(TRIM(CAST(LatSj9 AS STRING)), '') AS DOUBLE) AS lat_s9,
  TRY_CAST(NULLIF(TRIM(CAST(LongSj9 AS STRING)), '') AS DOUBLE) AS lon_s9,
  TRY_CAST(NULLIF(TRIM(CAST(LatSj10 AS STRING)), '') AS DOUBLE) AS lat_s10,
  TRY_CAST(NULLIF(TRIM(CAST(LongSj10 AS STRING)), '') AS DOUBLE) AS lon_s10
  FROM u
),
/* 3) um atendimento por linha (mantem a linha mais completa nos marcos de tempo) */
a AS (
  SELECT *, ROW_NUMBER() OVER (
      PARTITION BY idsamu, idocorrencia
      ORDER BY (CAST(dc IS NOT NULL AS INT) + CAST(dtarm IS NOT NULL AS INT) + CAST(dreg IS NOT NULL AS INT) + CAST(drad IS NOT NULL AS INT) + CAST(p9 IS NOT NULL AS INT) + CAST(p10 IS NOT NULL AS INT) + CAST(s9 IS NOT NULL AS INT) + CAST(s10 IS NOT NULL AS INT)) DESC, dc ASC) AS rn_at
  FROM t
  WHERE idocorrencia IS NOT NULL
),
/* 4) derivacao: nenhum horario absoluto sai daqui */
d AS (
  SELECT
  a.consorcio,
  substring(sha2(concat(cfg.salt, a.idsamu, '|', CAST(year(a.dc) AS STRING), '|', a.numocorrencia), 256), 1, 16) AS id_chamada_pseudo,
  substring(sha2(concat(cfg.salt, a.idsamu, '|', a.idocorrencia), 256), 1, 16) AS id_atend_pseudo,
  year(a.dc) AS ano,
  dayofweek(a.dc) AS dia_semana,
  CASE WHEN hour(a.dc) BETWEEN 0 AND 5 THEN '00-05' WHEN hour(a.dc) BETWEEN 6 AND 11 THEN '06-11'
       WHEN hour(a.dc) BETWEEN 12 AND 17 THEN '12-17' WHEN hour(a.dc) IS NOT NULL THEN '18-23' END AS faixa_horaria,
  a.codigo, a.comatendimento, a.tipounidade, a.tipotransporte,
  CAST(a.tem_hosp AS INT) AS tem_transporte,
  ROUND((unix_timestamp(dtarm) - unix_timestamp(dc)) / 60.0, 2) AS d_criacao_tarm,
  ROUND((unix_timestamp(dreg) - unix_timestamp(dtarm)) / 60.0, 2) AS d_tarm_regulador,
  ROUND((unix_timestamp(drad) - unix_timestamp(dreg)) / 60.0, 2) AS d_regulador_radio,
  ROUND((unix_timestamp(drad) - unix_timestamp(dc)) / 60.0, 2) AS d_criacao_radio,
  ROUND((unix_timestamp(p9) - unix_timestamp(drad)) / 60.0, 2) AS d_radio_pj9,
  ROUND((unix_timestamp(p10) - unix_timestamp(p9)) / 60.0, 2) AS d_pj9_pj10,
  ROUND((unix_timestamp(p10) - unix_timestamp(drad)) / 60.0, 2) AS d_radio_pj10,
  ROUND((unix_timestamp(s9) - unix_timestamp(p10)) / 60.0, 2) AS d_pj10_sj9,
  ROUND((unix_timestamp(s10) - unix_timestamp(s9)) / 60.0, 2) AS d_sj9_sj10,
  ROUND((unix_timestamp(s10) - unix_timestamp(p10)) / 60.0, 2) AS d_pj10_sj10,
  CAST(dc IS NOT NULL AS INT) AS tem_datacriacao,
  CAST(dtarm IS NOT NULL AS INT) AS tem_datatarm,
  CAST(dreg IS NOT NULL AS INT) AS tem_dataregulador,
  CAST(drad IS NOT NULL AS INT) AS tem_dataradiooperador,
  CAST(p9 IS NOT NULL AS INT) AS tem_pj9,
  CAST(p10 IS NOT NULL AS INT) AS tem_pj10,
  CAST(s9 IS NOT NULL AS INT) AS tem_sj9,
  CAST(s10 IS NOT NULL AS INT) AS tem_sj10,
  (minute(dc) % 10) AS dig_min_datacriacao,
  (minute(dtarm) % 10) AS dig_min_datatarm,
  (minute(dreg) % 10) AS dig_min_dataregulador,
  (minute(drad) % 10) AS dig_min_dataradiooperador,
  (minute(p9) % 10) AS dig_min_pj9,
  (minute(p10) % 10) AS dig_min_pj10,
  (minute(s9) % 10) AS dig_min_sj9,
  (minute(s10) % 10) AS dig_min_sj10,
  CASE WHEN dc IS NULL THEN NULL WHEN second(dc) = 0 THEN 1 ELSE 0 END AS seg0_datacriacao,
  CASE WHEN dtarm IS NULL THEN NULL WHEN second(dtarm) = 0 THEN 1 ELSE 0 END AS seg0_datatarm,
  CASE WHEN dreg IS NULL THEN NULL WHEN second(dreg) = 0 THEN 1 ELSE 0 END AS seg0_dataregulador,
  CASE WHEN drad IS NULL THEN NULL WHEN second(drad) = 0 THEN 1 ELSE 0 END AS seg0_dataradiooperador,
  CASE WHEN p9 IS NULL THEN NULL WHEN second(p9) = 0 THEN 1 ELSE 0 END AS seg0_pj9,
  CASE WHEN p10 IS NULL THEN NULL WHEN second(p10) = 0 THEN 1 ELSE 0 END AS seg0_pj10,
  CASE WHEN s9 IS NULL THEN NULL WHEN second(s9) = 0 THEN 1 ELSE 0 END AS seg0_sj9,
  CASE WHEN s10 IS NULL THEN NULL WHEN second(s10) = 0 THEN 1 ELSE 0 END AS seg0_sj10,
  CASE WHEN p9 IS NULL THEN NULL WHEN lat_p9 = 0 THEN 1 ELSE 0 END AS coord_nula_pj9,
  CASE WHEN p10 IS NULL THEN NULL WHEN lat_p10 = 0 THEN 1 ELSE 0 END AS coord_nula_pj10,
  CASE WHEN s9 IS NULL THEN NULL WHEN lat_s9 = 0 THEN 1 ELSE 0 END AS coord_nula_sj9,
  CASE WHEN s10 IS NULL THEN NULL WHEN lat_s10 = 0 THEN 1 ELSE 0 END AS coord_nula_sj10,
  CASE WHEN (lat_p9 BETWEEN -23.0 AND -14.0 AND lon_p9 BETWEEN -52.0 AND -39.0) AND (lat_p10 BETWEEN -23.0 AND -14.0 AND lon_p10 BETWEEN -52.0 AND -39.0) THEN ROUND(2 * 6371.0 * asin(sqrt(power(sin(radians(lat_p10 - lat_p9) / 2), 2) + cos(radians(lat_p9)) * cos(radians(lat_p10)) * power(sin(radians(lon_p10 - lon_p9) / 2), 2))), 1) END AS dist_km_pj9_pj10,
  CASE WHEN (lat_s9 BETWEEN -23.0 AND -14.0 AND lon_s9 BETWEEN -52.0 AND -39.0) AND (lat_s10 BETWEEN -23.0 AND -14.0 AND lon_s10 BETWEEN -52.0 AND -39.0) THEN ROUND(2 * 6371.0 * asin(sqrt(power(sin(radians(lat_s10 - lat_s9) / 2), 2) + cos(radians(lat_s9)) * cos(radians(lat_s10)) * power(sin(radians(lon_s10 - lon_s9) / 2), 2))), 1) END AS dist_km_sj9_sj10,
  CASE WHEN a.idade IS NULL THEN 'nao_informado' WHEN a.idade = 0 THEN 'zero_registrado'
       WHEN a.idade < 0 OR a.idade > 120 THEN 'fora_0_120' WHEN a.idade <= 11 THEN '0-11'
       WHEN a.idade <= 17 THEN '12-17' WHEN a.idade <= 59 THEN '18-59' ELSE '60+' END AS faixa_etaria,
  a.sexo, a.obito, a.tipo_obito,
  cfg.max_por_consorcio, cfg.k_min
  FROM a CROSS JOIN cfg
  WHERE a.rn_at = 1
),
/* 5) amostra equilibrada por consorcio (reprodutivel: semente 42) */
s AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY consorcio ORDER BY rand(42)) AS rn_s FROM d
),
s2 AS (SELECT * EXCEPT (rn_s) FROM s WHERE rn_s <= max_por_consorcio),
/* 6) k-anonimato em etapas: generaliza primeiro tipo de obito, depois sexo, depois faixa etaria; remove o que ainda ficar raro */
c1 AS (
  SELECT *, COUNT(*) OVER (PARTITION BY consorcio, ano, faixa_etaria, sexo, tem_transporte, obito, tipo_obito) AS k1 FROM s2
),
g1 AS (
  SELECT * EXCEPT (tipo_obito, k1),
    CASE WHEN k1 < k_min THEN 'suprimido' ELSE tipo_obito END AS tipo_obito
  FROM c1
),
c2 AS (
  SELECT *, COUNT(*) OVER (PARTITION BY consorcio, ano, faixa_etaria, sexo, tem_transporte, obito, tipo_obito) AS k2 FROM g1
),
g2 AS (
  SELECT * EXCEPT (sexo, k2),
    CASE WHEN k2 < k_min THEN 'suprimido' ELSE sexo END AS sexo
  FROM c2
),
c3 AS (
  SELECT *, COUNT(*) OVER (PARTITION BY consorcio, ano, faixa_etaria, sexo, tem_transporte, obito, tipo_obito) AS k3 FROM g2
),
g3 AS (
  SELECT * EXCEPT (faixa_etaria, k3),
    CASE WHEN k3 < k_min THEN 'suprimido' ELSE faixa_etaria END AS faixa_etaria
  FROM c3
),
kf AS (
  SELECT *, COUNT(*) OVER (PARTITION BY consorcio, ano, faixa_etaria, sexo, tem_transporte, obito, tipo_obito) AS k_fin FROM g3
)
SELECT * EXCEPT (max_por_consorcio, k_min, k_fin)
FROM kf
WHERE k_fin >= k_min
ORDER BY consorcio, id_atend_pseudo;
