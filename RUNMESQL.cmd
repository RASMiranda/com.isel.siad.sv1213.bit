@setlocal enableextensions
@cd /d "%~dp0"

@echo off
if "%1"=="" goto err
cls
echo no servidor '%1'
echo
sqlcmd -E -S %1 -i ".\#SQL\ETL\00-createPreStaggingBIT.sql"
sqlcmd -E -S %1 -i ".\#SQL\ETL\01-create_db-DataStagingBIT.sql"
REM Ascmd.exe -S %1 -i ".\#XMLA\02-create-com isel siad sv1213 bit ssas.xmla"
echo OK!
goto end
:err
echo uso: %0 nome_da_instancia_de_SQL_Server
goto end
:end 
pause