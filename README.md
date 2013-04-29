# SIAD\com.isel.siad.sv1213.bit

# Configuration Notes[PT]:
Antes de abrir a solucao com.isel.siad.sv1213.bit.sln, efectuar as seguintes configuracoes
No ficheiro:
	"(local repositories)\com.isel.siad.sv1213.bit\com.isel.siad.sv1213.bit.ssis\OperationalPackage.dtsConfig"
Substituir:
	<Configuration ConfiguredType="Property" Path="\Package.Variables[User::SQLETLPath].Properties[Value]" ValueType="String">
		<ConfiguredValue>D:\ISEL@Local\SIAD\com.isel.siad.sv1213.bit\#SQL\ETL\</ConfiguredValue>
	</Configuration>
Por:
	"(local repositories)\com.isel.siad.sv1213.bit\#SQL\ETL\"
Onde (local repositories) é o caminho para a pasta onde se encontra a pasta de repositorio local com.isel.siad.sv1213.bit
