# SIAD\com.isel.siad.sv1213.bit

# Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes:
Considerando que (local repositories) é o caminho para a pasta onde se encontra a pasta de repositorio local com.isel.siad.sv1213.bit
No ficheiro:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\OperationalPackage.SqlScripts.Path.dtsConfig
	
Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::SQLETLPath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\#SQL\ETL\</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\

No ficheiro:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.Variables.dtsConfig
	
Substituir directoria:

	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::FinacialPackagePath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx</ConfiguredValue>
	</Configuration>
	
Por directoria:

	(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\FinacialPackage.dtsx
	