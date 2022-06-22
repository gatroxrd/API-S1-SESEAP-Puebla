#!/bin/bash
# Secretaría Ejecutiva del Sistema Estatal Anticorrupción Puebla
# Unidad de Servicios Tecnolǵicos y Plataforma Digital
# Dudas o sugerencias al email
# puebladeclara@seseap.puebla.gob.mx
#Actualizado al 13 Junio 2022
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

			versionGrafica()
				{
						sudo apt install whiptail -y
						executarMontado=0
						banderamongoHostname=0
						banderadeploymentPort=0
						banderamongoDatabase=0
						banderamongoPort=0
						preexisteSESEAP=0
						cd .
						#Crea carpeta de operaciones seseap
						sudo rm -rf SESEAP
						mkdir SESEAP
						sudo chmod -R 777 SESEAP
						FILE=/SESEAP/parametrosConfiguracion.txt
						if test -f "$FILE"; then
						    echo "$FILE ya existe."
								cd SESEAP
							else
								cp -a parametrosConfiguracion.txt SESEAP/
								cd SESEAP
						fi

		        set -a
		        source <(cat parametrosConfiguracion.txt|\
		                sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
		        set +a
						#ls
						#clear

						#Nos quedamos en la carpeta de seseap

						clientScopeReadaux="$clientScopeRead"
						clientScopeWriteaux="$clientScopeWrite"

						while opt=$(zenity --title="$title" --text="$prompt" --list \
						                   --column="Options" "${options[@]}" --width 400 --height 200 --ok-label "Ejecutar" --cancel-label "Salir" )
						do
						    case "$opt" in
						    "${options[0]}") zenity --info --width=350 --text="Se instalará la API con los valores predefinidos en el archivo parametrosConfiguracion.txt "
								descargaAPINet
								#zenity --success --title "Instalación exitosa!" --width 500 --height 100 --text "La instalación de la API ha concluido exitósamente, "
								executarMontado=1
								;;
						    "${options[1]}")
												title2="Modificando instalación previa"
												prompt2="Indique el elemento a personalizar/modificar: "
												options2=("IP del equipo de cómputo" "Puerto de publicación de la API" "Nombre de la Base de Datos Mongo" "Puerto de operación de Mongo")
												descargaAPINet

															#Listado de opciones a modificación
															while opt=$(zenity --title="$title2" --text="$prompt2" --height 200  --ok-label "Ejecutar" --cancel-label "Atrás" --list \
															                   --column="Options" "${options2[@]}")
															do
															    case "$opt" in
															    "${options2[0]}")
																		#Moficando la IP del equipo
																		#zenity --info --text="Capture la nueva IP del equipo servido."
																    mongoHostnameaux=$(whiptail --title "Nueva IP del equipo" --inputbox "Escriba la nueva IP de este equipo servidor: " 8 40 3>&1 1>&2 2>&3)
																		#sed -i "s/$mongoHostname/$mongoHostnameaux/g" appsettings.json
																		zenity --info --title "Modificando IP registrada del equipo" --width 500 --height 100 --text "La IP actual ${mongoHostname} será actualizada a la nueva IP ${mongoHostnameaux}"
																		banderamongoHostname=1
																		#Modificando la IP del equipo
																		;;
															    "${options2[1]}")
																		#Modificando el puerto de publicación de la API
																		#zenity --info --text="Capture el nuevo puerto de la API."
																		banderadeploymentPort=1
																    deploymentPortaux=$(whiptail --title "Nuevo puerto de publicación API" --inputbox "Escriba el nuevo puerto de publicación para la API" 8 40 3>&1 1>&2 2>&3)
																		zenity --info --title "Modificando el puerto de publicación de la API" --width 500 --height 100 --text "El puerto actual de la API ${deploymentPort} será modificado al puerto ${deploymentPortaux}"
																		#sed -i "s/deploymentPort/$deploymentPortaux/g" appsettings.json
																		#Modificando el puerto de publicación de la API
																		;;
															    "${options2[2]}")
																		#Modificando el nombre de la base de datos Mongo
																		#zenity --info --text="Capture el nuevo nombre de la Base de Datos Mongo."
																    mongoDatabaseaux=$(whiptail --title "Nuevo nombre de la BD Mongo" --inputbox "Escriba el nuevo nombre de la base de datos Mongo" 8 40 3>&1 1>&2 2>&3)
																		zenity --info --title "Modificando el nombre de la base de datos" --width 500 --height 100 --text "El nombre actual de la base de datos ${mongoDatabase} será modificado por ${mongoDatabaseaux}"
																		#sed -i "s/mongoDatabase/$mongoDatabaseaux/g" appsettings.json
																		banderamongoDatabase=1
																		#Modificando el nombre de la base de datos Mongo
																		;;
															    "${options2[3]}")
																		#Modificando el número de puerto de la base de datos Mongo
																		#zenity --info --text="Capture el puerto asignado a la Base de Datos Mongo."
																    mongoPortaux=$(whiptail --title "Nuevo puerto de comunicación de la BD Mongo" --inputbox "Escriba el nuevo número de puerto de comunicación la base de datos Mongo" 8 40 3>&1 1>&2 2>&3)
																		zenity --info --title "Modificando el puerto de comunicación de Mongo DB" --width 500 --height 100 --text "El puerto de comunicaciones actual de MongoDb  ${mongoPort} será modificado al puerto ${mongoPortaux}"
																		#sed -i "s/mongoPort/$mongoPortaux/g" appsettings.json
																		banderamongoPort=1
																		;;
																		#Modificando el número de puerto de la base de datos Mongo
																esac
																#Fin del case interno
																#Listado de opciones a modificación
														done
						    ;;
						    "${options[2]}") zenity --info --width 300 --height 90 --text="Se obtendrá la versión más reciente del script de instalación SESEAP desde el repositorio correspondiente."
								clear
								cd /
								sudo curl -L -O https://raw.githubusercontent.com/gatroxrd/API-S1-SESEAP-Puebla/main/instalaSESEAP_S1.sh
								exit
								;;
						    *)
								zenity --error --width 300 --height 90 --text="No selecciono una opción válida del menú, ejecute de nuevo el script por favor."
								#Fin del case Principal
								;;
						    esac

								#-- - - - - - - - - - - - -  - - -  - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - -
								#Se continua proceso principal
								echo -e "\e[43m Actualizando valores en archivo appsettings.json            \e[0m"
								#S I   H U B O  P E R S O N A L I Z A C I Ó N    D E   V A L O R E S    A Q U I   S E   A L M A C E N A N
								#Si hubo cambios en la Ip del equipo se toma el nuevo valor
								#cat parametrosConfiguracion.txt | sed ':a; N; 1,50ba; D'
								if [ $banderamongoHostname -gt 0 ];
									then
										echo -e "\e[43m Actualizando Hostname  \e[0m"
										#Valor original en parametrosConfiguracion.txt
										tempmongoHostname=$mongoHostname

										#Nuevo valor capturado en pantalla
										mongoHostname=$mongoHostnameaux
										echo -e "\033[32m Se substituirá ${tempmongoHostname} por el nuevo valor ${mongoHostname} \033[0m"
										chmod -R 777 parametrosConfiguracion.txt
										sudo sed -i "8 s/"${tempmongoHostname}"/$mongoHostnameaux/g" parametrosConfiguracion.txt
										executarMontado=1
								fi
								#Si hubo cambios en el puerto de despliege de la API se toma el nuevo valor
								if [ $banderadeploymentPort -gt 0 ];
									then
										echo -e "\e[43m Actualizando el puerto de publicación de la API \e[0m"
										tempdeploymentPort=$deploymentPort
										deploymentPort=$deploymentPortaux
										#cd ..
										echo -e "\033[32m Se substituirá ${tempdeploymentPort} por el nuevo valor ${deploymentPort} \033[0m"
										chmod -R 777 parametrosConfiguracion.txt
										sudo sed -i "11 s/"${tempdeploymentPort}"/$deploymentPortaux/g" parametrosConfiguracion.txt
										echo -e "\033[32m Se substituirá ${tempdeploymentPort} por el nuevo valor ${deploymentPortaux} \033[0m"
										executarMontado=1
								fi
								#Si hubo cambios en el nombre de la base de datos Mongo se toma el nuevo valor
								if [ $banderamongoDatabase -gt 0 ];
									then
										echo -e "\e[43m Actualizando el nombre de la base de datos MongoDb \e[0m"
										tempmongoDatabase=$mongoDatabase
										mongoDatabase=$mongoDatabaseaux
										#cd ..
										chmod -R 777 parametrosConfiguracion.txt
										sudo sed -i "10 s/"mongoDatabase=${tempmongoDatabase}"/mongoDatabase=$mongoDatabaseaux/g" parametrosConfiguracion.txt
										echo -e "\033[32m Se substituirá ${tempmongoDatabase} por el nuevo valor ${mongoDatabaseaux} \033[0m"
										executarMontado=1
								fi
								#Si hubo cambios en el puerto de despliege de la API se toma el nuevo valor
								if [ $banderamongoPort -gt 0 ];
									then
										echo -e "\e[43m Actualizando el puerto de comuncaciones de MongoDb  \e[0m"
										tempmongoPort=$mongoPort
										mongoPort=$mongoPortaux
										#cd ..
										chmod -R 777 parametrosConfiguracion.txt
										sudo sed -i "9 s/"${tempmongoPort}"/$mongoPortaux/g" parametrosConfiguracion.txt
										echo -e "\033[32m Se substituirá ${tempmongoPort} por el nuevo valor ${mongoPortaux} \033[0m"
										executarMontado=1
								fi

								#Etapa final de executarMontado
								#- - - - - - - - - - - - -  - - - - - - - - -- - - - - - - - - - - - - -  - - - - -- - - - -- - - -
								if [ $executarMontado -gt 0 ];
									then
												cd API.S1.SESEAP

												chmod -R 777 appsettings.json
												# E S T A B L E C I E N D O    V A L O R E S   E N   E L   A P P . S E T T I N G S    D E L    P R O Y E C T O    . N E T
												sed -i "s/apiName/$apiName/g" appsettings.json
												#--echo -e "\033[32m Posible valor en appsettins.json ${tempmongoHostname} por el nuevo ${apiName} \033[0m"
												sed -i "s/clientId/$clientId/g" appsettings.json
												#echo -e "\033[32m {clienId} por ${clientId} \033[0m"
												sed -i "s/clientScopeRead/$clientScopeReadaux/g" appsettings.json
												sed -i "s/clientScopeWrite/$clientScopeWriteaux/g" appsettings.json
												sed -i "s/clientDescription/$clientDescription/g" appsettings.json
												sed -i "s/mongoUsername/$mongoUsername/g" appsettings.json
												sed -i "s/mongoPassword/$mongoPassword/g" appsettings.json
												#- - - - - --  - - - - - - - - - - - - - - - - - - - - - - -
												sed -i "s/mongoPort/$mongoPort/g" appsettings.json
												sed -i "s/mongoDatabase/$mongoDatabase/g" appsettings.json
												sed -i "s/mongoHostname/$mongoHostname/g" appsettings.json

												# M O N T A N D O   L A    I M A G E N    Y   D O C K E R   .NET
								        echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								        echo -e "\e[43mIniciando despliegue de la API Microsoft .NET\e[0m"

								        echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  1  I M A G E N = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								        echo -e "\033[33mEliminando imagen previa del contenedor Docker llamada:\033[0m"
								        sudo docker rm -f dotnet
								        echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  2  D O C K E R = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								        echo -e "\033[33mConstruyendo la imagen a partir del proyecto .NET\033[0m"
								        sudo docker build -t dotnet -f Dockerfile .
								        echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  3  D E S P L I E G U E = = = = = = = = = = = = = = = = = = = = = = ="
								        echo -e "\033[33mID de la imagen dentro del contenedor Docker es:\033[0m"

												#Levantado servicios definidos para la imagen dotnet
												#sudo docker-compose up

												if [ $banderadeploymentPort -gt 0 ];
													then
								        		sudo docker run --restart always --name dotnet -p $deploymentPortaux:80 -d dotnet
													else
													#sudo docker run --restart always --rm -d --network host--name dotnet -p $deploymentPort:80 -d dotnet
													#sudo docker run --hostname -it --rm -e HOST_IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') --name dotnet -p $deploymentPort:80 -d dotnet
												sudo docker run --hostname -it --rm -e HOST_IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') --name dotnet -p $deploymentPort:80 -d dotnet
												fi

								        echo -e "\033[33mAbra cualquier navegador aquí o en un equipo de su red local con la url para su nueva API:\033[0m"
								        echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
												echo -e "\033[32m ${mongoHostname}:${deploymentPort} \033[0m"
												echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
												echo -e "\033[32m ¡F E L I C I D A D E S! \033[0m"
												echo -e "\033[32m API de conexión de ${clientDescription} --> SESEAP establecida :) \033[0m"

												#Actualiza al archivo origen en la ubicacion superior
												cd ..
												cp -a parametrosConfiguracion.txt ../
								#FINALIZANDO EL SCRIPT
								else
									  clear
										exit
								fi
								done
				 }
		versionNoGrafica()
				{
								#Sección obsoleta al 22 de Junio de 2022
								#Búsqueda , descarga y creción de la carpeta con los fuentes de la API Microsoft.NET
								#Instalando desempaquetador del fuente .Zip
								sudo apt install zip unzip
								set -a
								source <(cat parametrosConfiguracion.txt|\
												sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
								set +a
								clear
								echo -e "\e[43mIniciando descarga del proyecto .NET del repositorio GitHub de USTPD-SESEAP\e[0m"
								sudo rm -rf API.S1.SESEAP
								chmod -R 777 .
								mkdir API.S1.SESEAP
								cd API.S1.SESEAP
								curl -L -O https://github.com/gatroxrd/API-S1-SESEAP-Puebla/raw/main/PDEPuebla.S1.PDN.zip --output API.S1.SESEAP/PDEPuebla.S1.PDN.zip
								echo -e "\033[33mDescomprimiendo archivos\033[0m"

								unzip -o PDEPuebla.S1.PDN.zip
								echo -e "\033[33mEliminando archivo .zip\033[0m"
								rm  PDEPuebla.S1.PDN.zip
								clear
								clientScopeReadaux="read:$clientScopeRead"
								clientScopeWriteaux="write:$clientScopeWrite"
								# E S T A B L E C I E N D O    V A L O R E S   E N   E L   A P P . S E T T I N G S    D E L    P R O Y E C T O    . N E T
								cd API.S1.SESEAP
								sed -i "s/apiName/$apiName/g" appsettings.json
								sed -i "s/clientId/$clientId/g" appsettings.json
								sed -i "s/clientScopeRead/$clientScopeReadaux/g" appsettings.json
								sed -i "s/clientScopeWrite/$clientScopeWriteaux/g" appsettings.json
								sed -i "s/mongoHostname/$mongoHostname/g" appsettings.json
								sed -i "s/clientDescription/$clientDescription/g" appsettings.json
								sed -i "s/mongoUsername/$mongoUsername/g" appsettings.json
								sed -i "s/mongoPassword/$mongoPassword/g" appsettings.json
								sed -i "s/mongoPort/$mongoPort/g" appsettings.json
								sed -i "s/mongoDatabase/$mongoDatabase/g" appsettings.json
								# M O N T A N D O   L A    I M A G E N    Y   D O C K E R   .NET
								echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								echo -e "\e[43mIniciando despliegue de la API Microsoft .NET\e[0m"

								echo "= = = = = = = = = = = = = = = = = = = = = P A S O  1  I M A G E N = = = = = = = = = = = = = = = = = = = = = ="
								echo -e "\033[33mEliminando imagen previa del contenedor Docker llamada:\033[0m"
								sudo docker rm -f dotnet
								echo "= = = = = = = = = = = = = = = = = = = = = P A S O  2  D O C K E R = = = = = = = = = = = = = = = = = = = = = ="
								echo -e "\033[33mConstruyendo la imagen a partir del proyecto .NET\033[0m"
								sudo docker build -t dotnet -f Dockerfile .
								echo "= = = = = = = = = = = = = = = = = = = = = P A S O  3  D E S P L I E G U E = = = = = = = = = = = = = = = = = ="
								echo -e "\033[33mID de la imagen dentro del contenedor Docker es:\033[0m"
								sudo docker run --restart always --name dotnet -p $deploymentPort:80 -d dotnet
								echo -e "\033[33mAbra cualquier navegador aquí o en un equipo de su red local con la url para su nueva API:\033[0m"
								echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								echo -e "\033[32m ${mongoHostname}:${deploymentPort} \033[0m"
								echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
								echo -e "\033[32m ¡F E L I C I D A D E S! \033[0m"
								echo -e "\033[32m API de conexión de ${clientDescription} --> SESEAP establecida :) \033[0m"
				}

				versionNoGraficaPlana()
				{
					# Crea Carpeta principal de despliegue SESEAP- - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - -
							cd .
							sudo rm -rf SESEAP
							mkdir SESEAP
							sudo chmod -R 777 SESEAP
							FILE=/SESEAP/parametrosConfiguracion.txt
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
					sed -i "s/apiName/$apiName/g" appsettings.json
					sed -i "s/clientId/$clientId/g" appsettings.json
					sed -i "s/clientScopeRead/$clientScopeReadaux/g" appsettings.json
					sed -i "s/clientScopeWrite/$clientScopeWriteaux/g" appsettings.json
					sed -i "s/clientDescription/$clientDescription/g" appsettings.json
					sed -i "s/mongoUsername/$mongoUsername/g" appsettings.json
					sed -i "s/mongoPassword/$mongoPassword/g" appsettings.json
					#- - - - - --  - - - - - - - - - - - - - - - - - - - - - - -
					sed -i "s/mongoPort/$mongoPort/g" appsettings.json
					sed -i "s/mongoDatabase/$mongoDatabase/g" appsettings.json
					sed -i "s/mongoHostname/$mongoHostname/g" appsettings.json
					echo -e "\e[37mArchivo appsettings.json actualizado ... Ok           \e[0m"

					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\e[46m C O M P O N E N T E    D O C K E R  \e[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="

					# M O N T A N D O   L A    I M A G E N    Y   D O C K E R   .NET
					echo -e "\e[33mIniciando despliegue de la API Microsoft .NET\e[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  1  I M A G E N = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mEliminando imagen previa del contenedor Docker llamada:\033[0m"
					sudo docker rm -f dotnet
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  2  D O C K E R = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mConstruyendo la imagen a partir del proyecto .NET\033[0m"
					sudo docker build -t dotnet -f Dockerfile .
					echo "= = = = = = = = = = = = = = = = = = = = = = = P A S O  3  D E S P L I E G U E = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[33mID de la imagen dentro del contenedor Docker es:\033[0m"

					#Levantado servicios definidos para la imagen dotnet
					#sudo docker-compose up

					#original abril 2022
					#sudo docker run --restart always --name dotnet -p $deploymentPortaux:80 -d dotnet

					#sudo docker run --restart always --rm -d --network host--name dotnet -p $deploymentPort:80 -d dotnet
					#sudo docker run --hostname -it --rm -e HOST_IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') --name dotnet -p $deploymentPort:80 -d dotnet
					sudo docker run --hostname -it --rm -e HOST_IP=$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p') --name dotnet -p $deploymentPort:80 -d dotnet


					echo -e "\033[33mAbra cualquier navegador aquí o en un equipo de su red local con la url para su nueva API:\033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[32m ${mongoHostname}:${deploymentPort} \033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo -e "\033[32m ¡F E L I C I D A D E S! \033[0m"
					echo -e "\033[32m API de conexión de ${clientDescription} --> SESEAP establecida :) \033[0m"
					echo "= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
					echo "Soporte y sugerencias al correo: puebladeclara@seseap.puebla.gob.mx"

					#Actualiza al archivo origen en la ubicacion superior
					cd ..
					cp -a parametrosConfiguracion.txt ../

				}

		#Ejecución del script principal # # # # # # # # # # # # # # # # # # # #
		#
		#
		clear
		#Sección obsoleta 22 Junio 2002
		#echo " Unidad de Servicios Tecnológicos y Plataforma Digital (USTPD)              Versión al 22 de Junio de 2022"
		#echo "+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + "
		#Sección obsoleta 22 Junio 2002
		#title="API de conexión S1 SESEAP"
		#prompt="Menú principal, seleccione una acción a seguir:"
		#options=("Instalación básica x paramerosConfiguracion.txt" "Modificando parametros ya instalados" "Actualiza script de instalación" )
		#if zenity --info --title "Secretaría Ejecutiva del Sistema Estatal Anticorrupción Puebla" --width 600 --height 100 --text "Instalación y configuración de la API que establecerá una interconexión segura entre su municipio/ente y la Plataforma Digital Nacional PDN para el Sistema de Declaraciones Patrimoniales y de Intereses S1. Proyecto de integración de tecnologías Microsoft.NET - Mongo DB - Docker"
		#then
		#		versionGrafica
		#else
		#    versionNoGrafica
		#fi
		# # # # # # # # # # # # # # # #  # # # ## # # # # # # # # # # # # # # # #
		versionNoGraficaPlana
