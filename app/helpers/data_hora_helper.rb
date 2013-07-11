module DataHoraHelper
	
	def total_minutos(horas)
		total_segundos(horas)/60
	end

	def total_segundos(horas)
		return 0 if horas.nil? || horas.empty?
		horas =  Time.parse(horas) if horas.is_a? String
		intervalo_segundos =  horas.strftime("%H").to_i * 60 * 60
		intervalo_segundos += horas.strftime("%M").to_i * 60
		intervalo_segundos
	end

	def minutos_em_horas(minutos)
		minutos.divmod(60).collect{|i|i.to_s.rjust(2,'0')}.join(":")
	end

end