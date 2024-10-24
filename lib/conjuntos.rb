def conjunto_lectura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:lectura] }.uniq
end

def conjunto_escritura(instrucciones)
  instrucciones.flat_map { |instruccion| instruccion[:escritura] }.uniq
end
