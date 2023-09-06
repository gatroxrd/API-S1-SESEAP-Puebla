#!/bin/bash
# Secretaría Ejecutiva del Sistema Estatal Anticorrupción Puebla
# Unidad de Servicios Tecnolǵicos y Plataforma Digital
# Dudas o sugerencias al email
# puebladeclara@seseap.puebla.gob.mx
#Actualizado al 22 de Septiembre 2022
			descargaAPINet()
			{
				#Instalador de desempaquetador del fuente de la aPI Microsoft .NET
				sudo apt install zip unzip
				echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
				echo -e "\e[43mIniciando descarga del proyecto .NET del repositorio GitHub de SESEAP - USTPD \e[0m"
				sudo rm -rf API.S1.SESEAP

				mkdir API.S1.SESEAP
				sudo chmod -R 777 API.S1.SESEAP
				cd API.S1.SESEAP
				curl -L -O https://github.com/gatroxrd/API-S1-SESEAP-Puebla/raw/main/PDEPuebla.S1.PDN.zip --output API.S1.SESEAP/PDEPuebla.S1.PDN.zip
				echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
				echo -e "\033[33mDescomprimiendo archivos .NET dentro de API.S1.SESEAP \033[0m"

				unzip -o PDEPuebla.S1.PDN.zip
				echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
				echo -e "\033[33mEliminando archivo .zip previamente descargado \033[0m"
				rm  -rf PDEPuebla.S1.PDN.zip
				cd ..
				clear
			}

			versionNoGraficaPlana()
				{
					# Crea Carpeta principal de despliegue SESEAP- - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - -
							cd .
							sudo rm -rf SESEAP
							mkdir SESEAP
							sudo chmod -R 777 SESEAP
							FILE=./SESEAP/parametrosConfiguracion.txt
							if test -f "$FILE"; then
									echo "$FILE ya existe."
									cd SESEAP
								else
									cp -a parametrosConfiguracion.txt SESEAP/
									cd SESEAP
							fi
					# Crea Carpeta principal de despliegue - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - -

					# Busca y copia hacia directorio SESEAP el archivo de configuración parametrosConfiguracion.text - - -
					set -a
					source <(cat parametrosConfiguracion.txt|\
									sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
					set +a
					# Busca y copia hacia directorio SESEAP el archivo de configuración parametrosConfiguracion.text - - -

					#Preparación de valores de clientScope read y write
					clientScopeReadaux="$clientScopeRead"
					clientScopeWriteaux="$clientScopeWrite"
					#Preparación de valores de clientScope read y write

					echo -e "\e[43m Secretaría Ejecutiva del Sistema Estatal Anticorrupción Puebla - SESEAP            \e[0m"
					echo -e "\e[43m Unidad de Servicios Tecnológicos y Plataforma Digital (USTPD)              Versión al 22 de Junio de 2022            \e[0m"
					echo "+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + "
					#Proceso de descarga del proyecto API .NET - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
					descargaAPINet
					echo -e "\e[42m Secretaría Ejecutiva del Sistema Estatal Anticorrupción Puebla - SESEAP                                              \e[0m"
					echo -e "\e[42m Unidad de Servicios Tecnológicos y Plataforma Digital (USTPD)              Versión al 22 de Junio de 2022            \e[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\e[45m C O M P O N E N T E    V I S U A L   E S T U D I O   . N E T \e[0m"
					echo ""
					echo -e "\e[37mIniciando descarga del proyecto .NET del repositorio GitHub de SESEAP - USTPD ... Ok \e[0m"
					echo -e "\033[37mDescomprimiendo archivos .NET dentro de API.S1.SESEAP ... Ok \033[0m"
					echo -e "\033[37mEliminando archivo .zip previamente descargado ... Ok \033[0m"
					#Proceso de descarga del proyecto API .NET - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

					echo -e "\e[37mActualizando valores en archivo appsettings.json            \e[0m"

					# Actualizando valores del archivo appsettinges.json - - - - - - - - - - - - - - - - - - - - - - - - -
					cd API.S1.SESEAP

					chmod -R 777 appsettings.json
					# E S T A B L E C I E N D O    V A L O R E S   E N   E L   A P P . S E T T I N G S    D E L    P R O Y E C T O    . N E T
					#sed -i "s/apiName/$apiName/g" appsettings.json
					#sed -i "s/clientId/$clientId/g" appsettings.json
				  	#sed -i "s/clientScopeRead/$clientScopeReadaux/g" appsettings.json
					#sed -i "s/clientScopeWrite/$clientScopeWriteaux/g" appsettings.json
					#sed -i "s/clientDescription/$clientDescription/g" appsettings.json
					#sed -i "s/mongoUsername/$mongoUsername/g" appsettings.json
					#sed -i "s/mongoPassword/$mongoPassword/g" appsettings.json
					#- - - - - --  - - - - - - - - - - - - - - - - - - - - - - -
					#sed -i "s/mongoPort/$mongoPort/g" appsettings.json
					#sed -i "s/mongoDatabase/$mongoDatabase/g" appsettings.json
					#sed -i "s/mongoHostname/$mongoHostname/g" appsettings.json

					#- - - - - - - - - - - - - - - - - - - - - - - -  - - - - - -
					sudo perl -pi -e "s[apiName][$apiName]g" appsettings.json
					sudo perl -pi -e "s[clientId][$clientId]g" appsettings.json
					sudo perl -pi -e "s[clientScopeRead][$clientScopeReadaux]g" appsettings.json
					sudo perl -pi -e  "s[clientScopeWrite][$clientScopeWriteaux]g" appsettings.json
					sudo perl -pi -e  "s[clientDescription][$clientDescription]g" appsettings.json
					sudo perl -pi -e  "s[mongoUsername][$mongoUsername]g" appsettings.json
					sudo perl -pi -e  "s[mongoPassword][$mongoPassword]g" appsettings.json
					#- - - - - --  - - - - - - - - - - - - - - - - - - - - - - -
					sudo perl -pi -e  "s[mongoPort][$mongoPort]g" appsettings.json
					sudo perl -pi -e  "s[mongoDatabase][$mongoDatabase]g" appsettings.json
					sudo perl -pi -e  "s[mongoHostname][$mongoHostname]g" appsettings.json
					#- - - - - - Actualizando el campo VPN - - - -
					sudo perl -pi -e  "s[vpn][$vpn]g" appsettings.json					
					echo -e "\e[37mArchivo appsettings.json actualizado ... Ok           \e[0m"

					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\e[46m C O M P O N E N T E    D O C K E R  \e[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="

					# M O N T A N D O   L A    I M A G E N    Y   D O C K E R   .NET
					echo -e "\e[33mIniciando despliegue de la API Microsoft .NET\e[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  1  I M A G E N = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mEliminando imagen previa del contenedor Docker llamada:\033[0m"
					#sudo docker rm -f dotnet
					sudo docker rm -f api-seseap-interconexion-puebla
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  2  D O C K E R = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mConstruyendo la imagen a partir del proyecto .NET\033[0m"
					sudo docker build -t dotnet -f Dockerfile .
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  3  D E S P L I E G U E = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mID de la imagen dentro del contenedor Docker es:\033[0m"

					#Comandos especiales
					#export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')
					echo "= = = = = = = = = = = = = = = = = = = ="

					#ACTIVO 06 Septiembre  2022
					sudo docker run --restart always --name api-seseap-interconexion-puebla -p $deploymentPort:80 -d dotnet

					#ACTIVO 05 Septiembre  2023 Renombrando a la imagen dotnet - - > API Seseap
					#sudo docker tag api.sea.puebla api.sea.puebla:ver.1.4

					echo -e "\033[33mAbra cualquier navegador aquí o en un equipo de su red local con la url para su nueva API:\033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[32m ${mongoHostname}:${deploymentPort} \033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\e[46m F  E  L  I  C  I  D  A  D  E  S  \e[0m"
					echo -e "\033[32m API de conexión de ${clientDescription} --> SESEAP establecida :) \033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo "Soporte y sugerencias al correo: puebladeclara@seseap.puebla.gob.mx"

					#Actualiza al archivo origen en la ubicacion superior
					cd ..
					cp -a parametrosConfiguracion.txt ../
			        echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = "
					echo "= = El contenedor creado por esta API de interconexión Puebla se identificará con las siguientes etiquetas :  "
					echo "= = NAMES : api-seseap-interconexion-puebla "
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = "
					echo "= = = = = = = = = = = = = = = = = = = = Estatus contenedores Dockers = = = = = = = = = = = = = = = = = = = = = ="
					sudo docker ps

				}

		#Ejecución del script principal # # # # # # # # # # # # # # # # # # # #
		#
		#
		clear
		# # # # # # # # # # # # # # # #  # # # ## # # # # # # # # # # # # # # # #
		versionNoGraficaPlana
