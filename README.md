# brmap

Polígonos de unidades territoriais do Brasil em R Simple Feature

----------------------------------------------------------------

Os dados foram retirados do site do IBGE e trabalhados em Excel e ArcGis para melhorar a estetica dos nomes e polígonos.

## Fontes

*  Shapefile: ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2015/Brasil/BR/BR.zip
*  Códigos e nomes: https://sidra.ibge.gov.br/territorio

## Instalação

``` r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("italocegatta/brmap")
```

## Uso

``` r
library(brmap)
```

``` r
brmap_brasil
#> Simple feature collection with 1 feature and 0 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -28.83591 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#>                         geometry
#> 1 MULTIPOLYGON(((-48.82145434...
```

``` r
brmap_regiao
#> Simple feature collection with 5 features and 2 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -28.83591 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#>   cod_regiao       regiao                       geometry
#> 1          1        Norte MULTIPOLYGON(((-46.06094679...
#> 2          2     Nordeste MULTIPOLYGON(((-38.65483855...
#> 3          3      Sudeste MULTIPOLYGON(((-48.00173665...
#> 4          4          Sul MULTIPOLYGON(((-48.82145434...
#> 5          5 Centro-Oeste MULTIPOLYGON(((-57.93438727...
```

``` r
brmap_estado
#> Simple feature collection with 27 features and 3 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -28.83591 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#>    cod_estado              estado sigla                       geometry
#> 1          11            Rondônia    RO MULTIPOLYGON(((-62.86661657...
#> 2          12                Acre    AC MULTIPOLYGON(((-73.18252539...
#> 3          13            Amazonas    AM MULTIPOLYGON(((-67.32608847...
#> 4          14             Roraima    RR MULTIPOLYGON(((-60.20050657...
#> 5          15                Pará    PA MULTIPOLYGON(((-46.06094679...
#> 6          16               Amapá    AP MULTIPOLYGON(((-50.18122558...
#> 7          17           Tocantins    TO MULTIPOLYGON(((-48.35878217...
#> 8          21            Maranhão    MA MULTIPOLYGON(((-43.99912974...
#> 9          22               Piauí    PI MULTIPOLYGON(((-41.74604645...
#> 10         23               Ceará    CE MULTIPOLYGON(((-40.49717147...
#> # ...
```

``` r
#> brmap_municipio
#> Simple feature collection with 5567 features and 5 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -34.79288 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#> First 1000 features:
#>      cod_cidade   regiao    estado sigla                       municipio                       geometry
#> 1       1100015    Norte  Rondônia    RO           Alta Floresta D'Oeste MULTIPOLYGON(((-62.05043777...
#> 2       1100023    Norte  Rondônia    RO                       Ariquemes MULTIPOLYGON(((-62.55475563...
#> 3       1100031    Norte  Rondônia    RO                          Cabixi MULTIPOLYGON(((-60.70931488...
#> 4       1100049    Norte  Rondônia    RO                          Cacoal MULTIPOLYGON(((-61.00059491...
#> 5       1100056    Norte  Rondônia    RO                      Cerejeiras MULTIPOLYGON(((-60.74295829...
#> 6       1100064    Norte  Rondônia    RO               Colorado do Oeste MULTIPOLYGON(((-60.33317134...
#> 7       1100072    Norte  Rondônia    RO                      Corumbiara MULTIPOLYGON(((-60.65201512...
#> 8       1100080    Norte  Rondônia    RO                   Costa Marques MULTIPOLYGON(((-63.67991986...
#> 9       1100098    Norte  Rondônia    RO                 Espigão D'Oeste MULTIPOLYGON(((-60.45852443...
#> 10      1100106    Norte  Rondônia    RO                   Guajará-Mirim MULTIPOLYGON(((-63.70673925...
#> # ...
```
