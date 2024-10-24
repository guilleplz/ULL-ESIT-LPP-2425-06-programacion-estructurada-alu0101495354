def conjunto_lectura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:lectura] }.uniq
end

def conjunto_escritura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:escritura] }.uniq
end

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
