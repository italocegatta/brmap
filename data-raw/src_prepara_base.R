library(tidyverse)
library(sf)
library(rmapshaper)
library(mapview)

# ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2017/
# ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2015/

cod_municipios <- "https://servicodados.ibge.gov.br/api/v1/localidades/municipios" %>%
  xml2::read_html() %>%
  rvest::html_text() %>%
  jsonlite::fromJSON(flatten = TRUE) %>%
  dplyr::select(
    municipio_cod = id,
    municipio_nome = nome,
    estado_cod = microrregiao.mesorregiao.UF.id,
    estado_nome = microrregiao.mesorregiao.UF.nome,
    estado_sigla = microrregiao.mesorregiao.UF.sigla,
    regiao_cod = microrregiao.mesorregiao.UF.regiao.id,
    regiao_nome = microrregiao.mesorregiao.UF.regiao.nome,
    regiao_sigla = microrregiao.mesorregiao.UF.regiao.sigla
  ) %>%
  dplyr::as_tibble()

cod_estados <- "https://servicodados.ibge.gov.br/api/v1/localidades/estados" %>%
  xml2::read_html() %>%
  rvest::html_text() %>%
  jsonlite::fromJSON(flatten = TRUE) %>%
  dplyr::select(
    estado_cod = id,
    estado_nome = nome,
    estado_sigla = sigla,
    regiao_cod = regiao.id,
    regiao_nome = regiao.nome,
    regiao_sigla = regiao.sigla
  ) %>%
  dplyr::as_tibble()

municipios_lat_lon <- read_csv2("data-raw/municipio_lat_lon.csv")


# municipio ---------------------------------------------------------------

# add depois fernando de noronha??
mun <- read_sf("data-raw/br_municipios/BRMUE250GC_SIR.shp") %>%
  st_set_crs(4674)

mun_raw <- mun %>%
  select(municipio_cod = CD_GEOCMU) %>%
  filter(!municipio_cod %in% c("4300001", "4300002", "2605459")) %>% # lagoas no RS e fernando de noronha
  mutate(municipio_cod = as.integer(municipio_cod)) %>%
  left_join(cod_municipios, by = "municipio_cod") %>%
  st_cast("POLYGON")

mun_area_pol <- mun_raw %>%
  mutate(area = st_area(.)) %>%
  group_by(municipio_cod) %>%
  mutate(n_id = row_number(-area)) %>%
  ungroup()

mun_mais_1pol <- c(
  1507805,
  2302107,
  5101704,
  5106752,
  5107156,
  5220702,
  5213103,
  2800407
)

brmap_municipio <- mun_area_pol %>%
  filter(municipio_cod %in% mun_mais_1pol | n_id <= 1) %>%
  group_by(municipio_cod, municipio_nome) %>%
  summarise() %>%
  ungroup() %>%
  left_join(cod_municipios) %>%
  left_join(municipios_lat_lon) %>%
  mutate(municipio_cod = as.integer(municipio_cod)) %>%
  select(municipio_cod, estado_cod, municipio_nome, lon, lat, alt) %>%
  arrange(municipio_cod)

# brmap::brmap_municipio
# brmap_municipio

usethis::use_data(brmap_municipio, overwrite = TRUE, compress = "xz")

brmap_municipio_simples <- brmap_municipio %>%
  ms_simplify(keep = 0.1, keep_shapes = TRUE) %>%
  as_tibble() %>%
  st_as_sf()

usethis::use_data(brmap_municipio_simples, overwrite = TRUE, compress = "xz")

rm(mun, mun_raw, mun_area_pol, mun_mais_1pol, brmap_municipio, brmap_municipio_simples)


# estado ------------------------------------------------------------------

est <- read_sf("data-raw/br_unidades_da_federacao/BRUFE250GC_SIR.shp") %>%
  st_set_crs(4674)

est_raw <- est %>%
  select(estado_cod = CD_GEOCUF) %>%
  mutate(estado_cod = as.integer(estado_cod)) %>%
  left_join(cod_estados) %>%
  st_cast("POLYGON")

est_area_pol <- est_raw %>%
  mutate(area = st_area(.)) %>%
  group_by(estado_cod) %>%
  mutate(n_id = row_number(-area)) %>%
  ungroup()

brmap_estado <- est_area_pol %>%
  filter(n_id <= 1) %>%
  select(estado_cod, regiao_cod, estado_nome, estado_sigla) %>%
  arrange(estado_cod)

# brmap::brmap_estado
# brmap_estado

usethis::use_data(brmap_estado, overwrite = TRUE, compress = "xz")

brmap_estado_simples <- brmap_estado %>%
  ms_simplify(keep = 0.1, keep_shapes = TRUE) %>%
  as_tibble() %>%
  st_as_sf()

usethis::use_data(brmap_estado_simples, overwrite = TRUE, compress = "xz")

rm(est, est_raw, est_area_pol, brmap_estado, brmap_estado_simples)


# regiao ----------------------------------------------------------------

reg <- read_sf("data-raw/br/BRUFE250GC_SIR.shp") %>%
  st_set_crs(4674)

reg_raw <- reg %>%
  group_by(
    regiao_cod = as.integer(str_sub(CD_GEOCUF, 1, 1)),
    regiao_nome = str_to_title(NM_REGIAO)
  ) %>%
  summarise() %>%
  ungroup() %>%
  st_cast("MULTIPOLYGON") %>%
  st_cast("POLYGON")

reg_area_pol <- reg_raw %>%
  mutate(area = st_area(.)) %>%
  group_by(regiao_cod) %>%
  mutate(n_id = row_number(-area)) %>%
  ungroup()

brmap_regiao <- reg_area_pol %>%
  filter(n_id <= 1) %>%
  mutate(
    regiao_sigla = case_when(
      regiao_nome == "Norte" ~ "N",
      regiao_nome == "Nordeste" ~ "NE",
      regiao_nome == "Sudeste" ~ "SE",
      regiao_nome == "Sul" ~ "S",
      regiao_nome == "Centro-Oeste" ~ "CO"
    )
  ) %>%
  select(regiao_cod, regiao_nome, regiao_sigla) %>%
  arrange(regiao_cod)

# brmap::brmap_regiao
# brmap_regiao

usethis::use_data(brmap_regiao, overwrite = TRUE, compress = "xz")

brmap_regiao_simples <- brmap_regiao %>%
  ms_simplify(keep = 0.1, keep_shapes = TRUE) %>%
  as_tibble() %>%
  st_as_sf()

usethis::use_data(brmap_regiao_simples, overwrite = TRUE, compress = "xz")

rm(reg, reg_raw, reg_area_pol, brmap_regiao, brmap_regiao_simples)


# brasil ------------------------------------------------------------------

br <- read_sf("data-raw/br/BRUFE250GC_SIR.shp") %>%
  st_set_crs(4674)

br_raw <- br %>%
  group_by(id = 1) %>%
  summarise() %>%
  st_cast("POLYGON")

br_area_pol <- br_raw %>%
  mutate(area = st_area(.)) %>%
  group_by(id) %>%
  mutate(n_id = row_number(-area)) %>%
  ungroup()

brmap_brasil <- br_area_pol %>%
  filter(n_id <= 1) %>%
  select(geometry)

# brmap::brmap_brasil
# brmap_brasil

usethis::use_data(brmap_brasil, overwrite = TRUE, compress = "xz")

brmap_brasil_simples <- brmap_brasil %>%
  ms_simplify(keep = 0.1, keep_shapes = TRUE) %>%
  as_tibble() %>%
  st_as_sf() %>%
  select(geometry)

usethis::use_data(brmap_brasil_simples, overwrite = TRUE, compress = "xz")

rm(br, br_raw, br_area_pol, brmap_brasil, brmap_brasil_simples)

