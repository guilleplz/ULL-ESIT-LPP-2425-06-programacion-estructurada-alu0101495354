# Practica 06 - Programación estructurada
**Guillermo Plaza Gayan** - *alu0101495354*

## Introducción:

Este proyecto implementa una serie de funciones en Ruby para determinar si dos secuencias de instrucciones pueden ejecutarse de forma concurrente o paralela, basándose en las Condiciones de Bernstein. El proyecto también utiliza RSpec para realizar pruebas siguiendo la metodología de Desarrollo Dirigido por Pruebas (TDD).

## Estructura del proyecto:

``` bash
.
├── README.md
├── rakefile
├── lib    
|    └── conjuntos.rb  # Archivo con la lógica de verificación
└── spec
    └── test_conjuntos.rb  # Tests RSpec
```

## Funciones

### conjunto_lectura(instrucciones)

Esta función recibe un array de instrucciones y devuelve un array con las variables que son leídas (lectura) en todas las instrucciones. No permite duplicados en el conjunto de variables de lectura.

``` rb
def conjunto_lectura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:lectura] }.uniq
end
```