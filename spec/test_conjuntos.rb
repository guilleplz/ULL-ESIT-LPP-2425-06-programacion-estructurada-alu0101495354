require 'conjuntos'

# frozen_string_literal: true

describe "Condiciones de Bernstein" do

  # Declaración de variables para los tests

  let(:instrucciones_1) do
    [
      { lectura: ['a'], escritura: ['b'] },
      { lectura: ['b'], escritura: ['c'] }
    ]
  end

  let(:instrucciones_2) do
    [
      { lectura: ['d'], escritura: ['e'] },
      { lectura: ['e'], escritura: ['f'] }
    ]
  end

  let(:instrucciones_conflictivas) do
    [
      { lectura: ['b'], escritura: ['a'] },
      { lectura: ['c'], escritura: ['d'] }
    ]
  end


  describe '#conjunto_lectura' do
    it 'devuelve el conjunto correcto de lectura' do
      expect(conjunto_lectura(instrucciones_1)).to eq(['a', 'b'])
    end
  end

  describe '#conjunto_escritura' do
    it 'devuelve el conjunto correcto de escritura' do
      expect(conjunto_escritura(instrucciones_1)).to eq(['b', 'c'])
    end
  end

  describe '#verificar_condiciones_bernstein' do
  context 'cuando no hay conflicto entre las secuencias' do
    it 'permite la ejecución concurrente' do
      expect(verificar_condiciones_bernstein(instrucciones_1, instrucciones_2)).to be true
    end
  end

  context 'cuando hay conflicto entre las secuencias' do
    it 'no permite la ejecución concurrente' do
      expect(verificar_condiciones_bernstein(instrucciones_1, instrucciones_conflictivas)).to be false
    end
  end
end

end
