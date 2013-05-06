# SIAD\com.isel.siad.sv1213.bit

## Requirements[PT]:
Acesso à VPN "homer.refertelecom.pt". SQL Server Business Intelligence Development Studio 9 (2008) instalado e funcional.

## Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes:
Considerando que (local repositories) é o caminho para a pasta onde se encontra a pasta de repositorio local "com.isel.siad.sv1213.bit". No ficheiro:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\BitMainPackage.Variables.dtsConfig
	
Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::FinacialPackagePath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx

Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::SQLETLPath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\#SQL\ETL\</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\	

Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::OperationalPackagePath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\OperationalPackage.dtsx</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\	

Ao abrir solução "com.isel.siad.sv1213.bit.sln" e durante a utilização, se for pedida alguma password colocar "siad_bit_dev" (sem aspas).
Executar pacote BitMainPackage.dtsx (este pacote chamará os outros pacotes).