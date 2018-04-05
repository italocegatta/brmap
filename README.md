# brmap

Polígonos de unidades territoriais do Brasil em R Simple Feature

----------------------------------------------------------------

Os dados foram retirados do site do IBGE e trabalhados em Excel e ArcGis para melhorar a estética dos nomes e polígonos.

## Fontes

*  Shapefile: ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2015/Brasil/BR/BR.zip
*  Códigos e nomes: https://sidra.ibge.gov.br/territorio
*  Coordenadas dos municípios: ftp://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/localidades/Shapefile_SHP/

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
#> Simple feature collection with 5 features and 3 fields
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -34.79288 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#> # A tibble: 5 x 4
#>   cod_regiao regiao_nome  regiao_sigla                                    geometry
#>        <int> <chr>        <chr>                                     <POLYGON [Â°]>
#> 1          1 Norte        N            ((-60.20051 5.264343, -60.19828 5.260453, ~
#> 2          2 Nordeste     NE           ((-45.84073 -1.045485, -45.84099 -1.046971~
#> 3          3 Sudeste      SE           ((-44.20984 -14.2446, -44.20912 -14.24667,~
#> 4          4 Sul          S            ((-52.05188 -22.53933, -52.04607 -22.53941~
#> 5          5 Centro-Oeste CO           ((-57.93439 -7.656772, -57.93044 -7.657143~
```

``` r
brmap_estado
#> Simple feature collection with 27 features and 4 fields
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -34.79288 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#> # A tibble: 27 x 5
#>    cod_regiao cod_estado estado_nome estado_sigla                         geometry
#>         <int>      <int> <chr>       <chr>                          <POLYGON [Â°]>
#>  1          1         11 Rondônia    RO           ((-62.86662 -7.975868, -62.8601~
#>  2          1         12 Acre        AC           ((-73.18253 -7.335496, -73.0541~
#>  3          1         13 Amazonas    AM           ((-67.32609 2.029714, -67.31682~
#>  4          1         14 Roraima     RR           ((-60.20051 5.264343, -60.19828~
#>  5          1         15 Pará        PA           ((-54.95431 2.583692, -54.93542~
#>  6          1         16 Amapá       AP           ((-51.1797 4.000081, -51.17784 ~
#>  7          1         17 Tocantins   TO           ((-48.35878 -5.170085, -48.3561~
#>  8          2         21 Maranhão    MA           ((-45.84073 -1.045485, -45.8409~
#>  9          2         22 Piauí       PI           ((-41.74605 -2.803497, -41.7424~
#> 10          2         23 Ceará       CE           ((-40.49717 -2.784509, -40.4917~
#> # ... with 17 more rows
```

``` r
brmap_municipio
#> Simple feature collection with 5567 features and 7 fields
#> geometry type:  MULTIPOLYGON
#> dimension:      XY
#> bbox:           xmin: -73.99045 ymin: -33.75118 xmax: -34.79288 ymax: 5.271841
#> epsg (SRID):    4674
#> proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
#> # A tibble: 5,567 x 8
#>    cod_municipio cod_estado cod_regiao municipio    lon    lat   alt                       geometry
#>            <int>      <int>      <int> <chr>      <dbl>  <dbl> <dbl>            <MULTIPOLYGON [Â°]>
#>  1       1100015         11          1 Alta Flor~ -62.0 -11.9   338. (((-62.05044 -11.86735, -62.0~
#>  2       1100023         11          1 Ariquemes  -63.0  -9.91  139. (((-62.55476 -9.670769, -62.5~
#>  3       1100031         11          1 Cabixi     -60.5 -13.5   236. (((-60.70931 -13.693, -60.717~
#>  4       1100049         11          1 Cacoal     -61.4 -11.4   177. (((-61.00059 -10.99224, -61.0~
#>  5       1100056         11          1 Cerejeiras -60.8 -13.2   263. (((-60.74296 -13.12235, -60.7~
#>  6       1100064         11          1 Colorado ~ -60.6 -13.1   419. (((-60.33317 -13.25798, -60.3~
#>  7       1100072         11          1 Corumbiara -60.9 -13.0   269. (((-60.65202 -12.98131, -60.6~
#>  8       1100080         11          1 Costa Mar~ -64.2 -12.4   145. (((-63.67992 -11.64441, -63.6~
#>  9       1100098         11          1 Espigão D~ -61.0 -11.5   263. (((-60.45852 -10.98931, -60.4~
#> 10       1100106         11          1 Guajará-M~ -65.3 -10.8   133. (((-63.70674 -10.83999, -63.7~
#> # ... with 5,557 more rows
```
