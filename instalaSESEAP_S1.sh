#!/bin/bash

echo -e "\e[32m+ + + + + + + + + + + API S1 Conexión Entes - SESEAP - PDN + + + + + + + + + + + + + + + + + + +\e[0m "
echo -e "\e[32mScript de descarga,instalación y montado en el contenedor Docker de la API SESEAP S1\e[0m"
echo ""
echo "Secretaria Ejecutiva del Sistema Estatal Anticorrupción de Puebla (SESEAP)"
echo "Unidad de Servicios Tecnológicos y Plataforma Digital (USTPD)"
echo "                                                                            Versión al 7 de abril de 2022"
echo "+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + "


obtenerRepositorioSESEAPS1()
{
	
	set -a
	source <(cat parametrosConfiguracion.txt|\
		sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
	set +a
	echo -e "\e[43mIniciando descarga del proyecto .NET del repositorio GitHub de USTPD-SESEAP\e[0m"
        rmdir API.S1.SESEAP
	mkdir API.S1.SESEAP
	cd API.S1.SESEAP
	curl -L -O https://github.com/gatroxrd/API-S1-SESEAP-Puebla/raw/main/PDEPuebla.S1.PDN.zip --output API.S1.SESEAP/PDEPuebla.S1.PDN.zip
	echo -e "\033[33mDescomprimiendo archivos\033[0m"
	
	unzip -o PDEPuebla.S1.PDN.zip
	echo -e "\033[33mEliminando archivo .zip\033[0m"
	rm  PDEPuebla.S1.PDN.zip
	sed -i "s/valorW/$apiname/g" appsettings.json
	sed -i "s/valorX/$clientid/g" appsettings.json
	sed -i "s/valorY/$IP_HOSTNAME/g" appsettings.json
	sed -i "s/valorZ/$entidad/g" appsettings.json
	sed -i "s/valorusr/$MONGO_USERNAME/g" appsettings.json
	sed -i "s/valorpsw/$MONGO_PASSWORD/g" appsettings.json

	echo -e "\033[33mLa informacón que proporciono en su archivo parametrosConfiguracion.txt ya actualizo su archivo appSettings.json\033[0m"
	echo -e "\033[33mLos recursos externos necesarios ya fueron descargados\033[0m"
	echo -e "\033[33mLa información requerida para configurar el entorno de trabajo ya esta lista para consumirse.\033[0m"


	echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
	echo -e "\e[43mIniciando despliegue de la API Microsoft .NET\e[0m"

	echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  1 = = = = = = = = = = = = = = = = = = = = = = ="
	echo -e "\033[33mEliminando imagen previa del contenedor Docker llamada:\033[0m" 
	sudo docker rm -f dotnet
	echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  2 = = = = = = = = = = = = = = = = = = = = = = ="
	echo -e "\033[33mConstruyendo la imagen a partir del proyecto .NET\033[0m"	
	sudo docker build -t dotnet -f Dockerfile .
	echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  3 = = = = = = = = = = = = = = = = = = = = = = ="
	echo -e "\033[33mID de la imagen dentro del contenedor Docker es:\033[0m"
	sudo docker run --name dotnet -p $PORT_HOSTNAME:80 -d dotnet
	echo -e "\033[33mEn adelante usted puede abrir en cualquier navegador de su red local la API capturando la url con la ip de su equipo más el puerto ${puerto}\033[0m"
	echo ""


	# Variables
	_start=1

	# This accounts as the "totalState" variable for the ProgressBar function
	_end=100

	# Proof of concept
	for number in $(seq ${_start} ${_end})
	do
    	sleep 0.1
    	ProgressBar ${number} ${_end}
	done
	printf '\n                            C O N E X I Ó N   E S T A B L E C I D A!\n'
	echo -e "\e[32m        _ ______________________________________________________________________________\e[0m"
}

function ProgressBar {
# Process data
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
# Build progressbar string lengths
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:                           
# 1.2.1.1 Progress : [########################################] 100%
printf "\rEstableciendo conexión hacia SESEAP-USTPD : [${_fill// /#}${_empty// /-}] ${_progress}%%"

}


obtenerRepositorioSESEAPS1



