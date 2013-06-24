@setlocal enableextensions
@cd /d "%~dp0"

cd com.isel.siad.sv1213.bit.ssis

set current_dtsConfig=%cd%\FinancialPackage.Connections.dtsConfig


setx /M BIT_FinancialPackage_Connections_dtsConfig_PATH "%current_dtsConfig%"



set current_dtsConfig=%cd%\FinacialPackage.Variables.dtsConfig

setx /M BIT_FinacialPackage_Variables_dtsConfig_PATH "%current_dtsConfig%"



set current_dtsConfig=%cd%\OperationalPackage.Connections.dtsConfig

setx /M BIT_OperationalPackage_Connections_dtsConfig_PATH "%current_dtsConfig%"



set current_dtsConfig=%cd%\BitMainPackage.Connections.dtsConfig


setx /M BIT_BitMainPackage_Connections_dtsConfig_PATH "%current_dtsConfig%"


set current_dtsConfig=%cd%\BitMainPackage.Variables.dtsConfig


setx /M BIT_BitMainPackage_Variables_dtsConfig_PATH "%current_dtsConfig%"

