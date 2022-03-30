#!/bin/bash


echo "API S1 Conexión Entes-Seseap-PDN Puebla"
echo "+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + "
echo "Script de instalación para crear y montar en un contenedor DOcker la imagen de la API publicada por la Unidad de Servicios Técnologicos  y Plataforma Digital de la Secretaria Ejecutiva  del Sistema Estatal Anticorrupción Puebla."

implementaS1()
{
	sudo docker rm -f dotnet
	sudo docker build -t dotnet -f Dockerfile .
	sudo docker run --name dotnet -p 8095:80 -d dotnet
}

implementaS1

echo "Ahora por ravor abra su navegador y escriba su ip y agregue el puerto 8095"
echo "p.e. 192.168.0.215:8085"
