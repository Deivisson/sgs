module DataHoraHelper
	
	def total_minutos(horas)
		total_segundos(horas)/60
	end

	def total_segundos(horas)
		return 0 if horas.nil? || horas.to_s.empty?
		#horas =  Time.parse(horas) if horas.is_a? String
		#intervalo_segundos =  horas.strftime("%H").to_i * 60 * 60
		#intervalo_segundos += horas.strftime("%M").to_i * 60
		#intervalo_segundos
		horas =  horas.strftime("%H:%M") unless horas.is_a? String
		hora, minuto = horas.to_s.split(":").map(&:to_i)
		intervalo_segundos =  hora * 60 * 60
		intervalo_segundos += minuto * 60
		intervalo_segundos
	end

	def minutos_em_horas(minutos)
		return "00:00" if minutos.nil?
		minutos.to_i.divmod(60).collect{|i|i.to_s.rjust(2,'0')}.join(":")
	end

	def dif_em_minutos(d_ini,d_fim)
		d_ini = d_ini.to_datetime
		d_fim = d_fim.to_datetime
		((d_fim - d_ini) * 24 * 60).to_i
	end
end
