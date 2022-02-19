#!/bin/bash

while [ 0 -eq 0 ]
do
    echo ""
    echo "[---------------------------- +MENU+ --------------------------------]"
    echo ""
    echo "[------------------- SERVICIOS --------------------]"
    echo "1. Comprobar actualizaciones del equipo e instalarlas"
    echo "2. Ver servicios del equipo instalados"
    echo "3. Mostrar estado de un servicio [X]"
    echo "4. Instalación de DHCP"
    echo "5. Datos DHCP"
    echo "5.1 Que es DHCP"
    echo ""
    echo "[-------------------- PAQUETES --------------------]"
    echo "5. Mostrar paquetes instalados"
    echo "6. Mostrar paquete y posible instalacion [X]"
    echo "7. Salir"
    echo ""
    echo "[-------------------------------------------]"
    read -r -p "Dime que opcion quieres: " opcion

    if [ $opcion == "1" ]; then
        echo "[========================================]"
        echo "[===== Se va a actualizar el equipo =====]"
        echo "[========================================]"
        sudo apt update -y
        sudo apt upgrade -y
        sleep 2
        echo "[========================================]"
        echo "[----- Tu equipo se ha actualizado ------]"
        echo "[========================================]"
        sleep 4
        echo ""
    fi


    if [ $opcion == "2" ]; then
        echo ""
        echo "[========================================]"
        echo "[==== Se van a mostrar los servicios ====]"
        echo "[========================================]"
        service --status-all
        sleep 2
        echo ""
        echo "[========================================]"
        echo "[===== Esos son todos los servicios =====]"
        echo "[========================================]"
        sleep 3
        echo ""
        read -r -p "Quieres ver solo los servicios en ejecucion? (Y/N)" ejecucion
        if [ $ejecucion == "Y" ] || [ $ejecucion == "y" ]; then
            service --status-all | grep +
            sleep 3
            echo ""
            echo "[========================================]"
            echo "[===== Esos son todos los servicios =====]"
            echo "[========================================]"
            sleep 3
        else
            echo ""
            echo "[========================================]"
            echo "NO se mostraran los servicios en ejecucion"
            echo "[========================================]"
            sleep 3
        fi   
    fi

    if [ $opcion == "3" ]; then
        read -r -p "Que servicio quieres comprobar?: " servicio1
        if [ $servicio1 ]; then
            echo ""
            echo "[====================================================]"
            echo "[===== Se va a comprobar el servicio $servicio1 =====]"
            echo "[====================================================]"
            echo ""
            sleep 3
            sudo systemctl status $servicio1
            sleep 3
        else
            echo ""
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo "ERROR: No has puesto el servicio a comprobar"
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo ""
            sleep 2
        fi
    fi

    if [ $opcion == "4" ]; then
        echo ""
        echo "[================================================]"
        echo "[==== Va a comenzar la instalación de DHCP ======]"
        echo "[================================================]"
        sleep 3
        echo ""
        echo "[============================================================]"
        echo "[==== Va a comenzar la comprobacion de actualizaciones ======]"
        echo "[============================================================]"
        sleep 3
        sudo apt update; sudo apt upgrade -y
        echo ""
        echo "[======================================================]"
        echo "[===== Tu sistema se ha actualizado correctamente =====]"
        echo "[======================================================]"
        echo ""
        sleep 3
        echo "++++ Inicio de instalacion del servicio DHCP ++++"
        echo ""
        sleep 3
        sudo apt-get install isc-dhcp-server -y
        echo ""
        echo "[======================================================]"
        echo "[========= Servicio instalado correctamente ===========]"
        echo "[======================================================]"
        echo ""
        sleep 2
        read -r -p "Quieres comprobarlo? (Y/N): " comprob
        if [ $comprob == "Y" ] || [ $comprob == "y" ]; then
            echo ""
            sudo /etc/init.d/isc-dhcp-server status
            echo ""
            sleep 3
        else 
            echo ""
            echo "[++++++++++++++++++++++++++++++++++++++++++]"
            echo "ERROR: No se va a comprobar el servicio DHCP"
            echo "[++++++++++++++++++++++++++++++++++++++++++]"
            echo ""
        fi

    fi


    if [ $opcion == "5" ]; then
        echo ""
        echo "[================================================]"
        echo "[===== Se va a mostrar informacion de DHCP  =====]"
        echo "[================================================]"
        sleep 3
        echo ""
        echo "--------------------------------------------------"
        echo "Estas conectado ahora mismo como:" 
        whoami
        echo "--------------------------------------------------"
        echo "Tu IP actual es:"
        hostname -I
        echo "--------------------------------------------------"
        sleep 2
        echo "Tu IP de loopback es:"
        hostname -i
        echo "--------------------------------------------------"
        sleep 2
        echo "Tu mascara de red y tu IP de broadcast es:"
        ifconfig | grep netmask
        echo "--------------------------------------------------"
        sleep 2
        echo "Interfaz de conexion:"
        if [[ `ifconfig | grep eth0` ]]; then
            echo "eth0"
        elif [[ `ifconfig | grep enp0s3` ]]; then
            echo "enp0s3"
        else
            echo "lo"
        fi
        echo "--------------------------------------------------"
        sleep 7
        echo ""
        read -r -p "Quieres ver logs de DHCP? (Y/N): " logs

        if [ $logs == "Y" ] || [ $logs == "y" ]; then
        cat /var/log/syslog | grep -E "dhcp"
        sleep 10
        echo ""
        read -r -p "Quieres ver los dispositivos de red? (Y/N): " int
            echo ""
            if [ $int == "Y" ] || [ $int == "y" ]; then
            arp -a
            sleep 4
            else
                echo "[++++++++++++++++++++++++++++++++++++++++]"
                echo "[+ No se van a mostrar los dispositivos +] "
                echo "[++++++++++++++++++++++++++++++++++++++++]"
                echo ""
                sleep 2
            fi
        echo ""

        else
            echo ""
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo "[++ No se van mostrar los logs de DHCP ++] "
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo ""
            sleep 3
        fi
    fi

    if [ $opcion == "5.1" ]; then
        echo ""
        echo "[========================================]"
        echo "El protocolo de configuración dinámica de host es un protocolo de red de tipo cliente/servidor"
        echo "mediante el cual un servidor DHCP asigna dinámicamente una dirección IP y otros parámetros de configuración de red a cada dispositivo en una red para que puedan"
        echo "comunicarse con otras redes IP"
        echo "[========================================]"
        echo ""
        sleep 7
    fi
    
    if [ $opcion == "5" ]; then
        echo ""
        echo "[========================================]"
        echo "[==== Se van a mostrar los paquetes =====]"
        echo "[========================================]"
        echo ""
        dpkg -l
    fi

    if [ $opcion == "6" ]; then
        echo ""
        read -r -p "Que paquete quieres comprobar?: " paquete1
        if [ $paquete1 ]; then
            echo ""
            echo "[========================================]"
            echo "[============= Comprobacion =============]"
            echo "[========================================]"
            echo ""
            sleep 3
            #Comprobar si esta en el sistema y mostrarlo, sino, dar opcion a instalarlo.
            if [[ `dpkg -l $paquete1` ]]; then
                sleep 5
                echo ""
                echo "[========================================]"
                echo "[====== Tu paquete esta instalado =======]"
                echo "[========================================]"
                sleep 4
    
            else
                read -r -p "Quieres instalarlo? (Y/N): " opcion2
                if [[ $opcion2 == "Y" ]] || [[ $opcion2 == "y" ]]; then
                    echo "[========================================]"
                    echo "[==== Se va a instalar $paquete1 =====]"
                    echo "[========================================]"
                    sudo apt install $paquete1 -y
                    sudo apt update
                    sudo apt upgrade
                    sleep 3
                    echo "[========================================]"
                    echo "[====== Tu paquete esta instalado =======]"
                    echo "[========================================]"
                else
                    echo ""
                    echo "[++++++++++++++++++++++++++++++++++++++++]"
                    echo " No se va a instalar el paquete $paquete1 "
                    echo "[++++++++++++++++++++++++++++++++++++++++]"
                    echo ""
                    sleep 3
                fi
            fi
        else
            echo ""
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo "ERROR: No has puesto el paquete a comprobar"
            echo "[++++++++++++++++++++++++++++++++++++++++]"
            echo ""
            sleep 3
        fi

    fi

    if [ $opcion == "7" ]; then
        echo ""
        echo "[========================================]"
        echo "[=========== Fin del script =============]"
        echo "[========================================]"
        echo ""
        sleep 1
        break
    fi
done