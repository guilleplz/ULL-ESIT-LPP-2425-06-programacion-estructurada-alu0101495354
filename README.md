# Practica 06 - Programación estructurada
**Guillermo Plaza Gayan** - *alu0101495354*

---

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

---

## Funciones

### conjunto_lectura(instrucciones)

Esta función recibe un array de instrucciones y devuelve un array con las variables que son leídas (lectura) en todas las instrucciones. No permite duplicados en el conjunto de variables de lectura.

``` rb
def conjunto_lectura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:lectura] }.uniq
end
```

### conjunto_escritura(instrucciones)

Esta función recibe un array de instrucciones y devuelve un array con las variables que son escritas (escritura) en todas las instrucciones. Al igual que conjunto_lectura, no permite duplicados en el conjunto de variables de escritura.

``` rb
def conjunto_escritura(instrucciones) 
  instrucciones.flat_map { |instruccion| instruccion[] }.uniq 
end
```

### verificar_condiciones_bernstein(intrucciones_1, instrucciones_2):

Esta función determina si dos conjuntos de instrucciones pueden ejecutarse en paralelo. Utiliza las Condiciones de Bernstein, que requieren que:

Las variables leídas en una secuencia no sean escritas en la otra.
Las variables escritas en una secuencia no sean leídas en la otra.
Las variables escritas no deben ser escritas en la otra secuencia.
Si estas condiciones se cumplen, las secuencias pueden ejecutarse en paralelo.

``` rb
def verificar_condiciones_bernstein(instrucciones_1, instrucciones_2)
  lectura_1 = conjunto_lectura(instrucciones_1)
  escritura_1 = conjunto_escritura(instrucciones_1)
  lectura_2 = conjunto_lectura(instrucciones_2)
  escritura_2 = conjunto_escritura(instrucciones_2)

  no_interferencia_1 = (escritura_1 & lectura_2).empty?
  no_interferencia_2 = (escritura_2 & lectura_1).empty?
  no_interferencia_escritura = (escritura_1 & escritura_2).empty?

  no_interferencia_1 && no_interferencia_2 && no_interferencia_escritura
end
```

---

## Pruebas:

Las pruebas están definidas utilizando RSpec y siguen la metodología Test Driven Development (TDD). A continuación se describe la estructura y propósito de los tests.

**Archivo de pruebas:** spec/bernstein_conditions_spec.rb

### Prueba para conjunto_lectura

Esta prueba verifica que la función conjunto_lectura devuelva correctamente las variables leídas por las instrucciones.
``` rb
describe '#conjunto_lectura' do 
  it 'devuelve el conjunto correcto de lectura' do 
    instrucciones = [ { lectura: ['a'], escritura: ['b'] }, { lectura: ['b'], escritura: ['c'] } ] 
    expect(conjunto_lectura(instrucciones)).to eq(['a', 'b']) 
  end 
end

```

### Prueba para conjunto_escritura
Esta prueba verifica que la función conjunto_escritura devuelva correctamente las variables escritas por las instrucciones.

``` rb
describe '#conjunto_escritura' do 
  it 'devuelve el conjunto correcto de escritura' do 
    instrucciones = [ { lectura: ['a'], escritura: ['b'] }, { lectura: ['b'], escritura: ['c'] } ] 
    expect(conjunto_escritura(instrucciones)).to eq(['b', 'c']) 
  end 
end

```

### Prueba para verificar_condiciones_bernstein
Esta prueba verifica si dos conjuntos de instrucciones pueden ejecutarse en paralelo siguiendo las Condiciones de Bernstein.

``` rb
describe '#verificar_condiciones_bernstein' do 

  let() do 
    [ { lectura: ['a'], escritura: ['b'] }, { lectura: ['b'], escritura: ['c'] } ] 
  end

  let() do 
    [ { lectura: ['d'], escritura: ['e'] }, { lectura: ['e'], escritura: ['f'] } ] 
  end

  it 'permite la ejecución concurrente' do 
    expect(verificar_condiciones_bernstein(instrucciones_1, instrucciones_2)).to be true 
  end

  it 'detecta conflictos en ejecución concurrente' do 
    instrucciones_conflictivas = [ { lectura: ['b'], escritura: ['a'] }, { lectura: ['c'], escritura: ['d'] } ] 
    expect(verificar_condiciones_bernstein(instrucciones_1, instrucciones_conflictivas)).to be false 
  end 
end

```

---

## Conclusión:

Este proyecto proporciona una implementación simple pero efectiva para verificar las Condiciones de Bernstein, lo que permite evaluar la posibilidad de ejecución concurrente y paralela de instrucciones en programas. Mediante el uso de RSpec y la metodología de TDD, se garantiza que el código sea confiable y fácil de mantener. Esta herramienta puede ser útil para desarrolladores que busquen optimizar la ejecución de sus programas y entender mejor las interacciones entre diferentes secciones de código.