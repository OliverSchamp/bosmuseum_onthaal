# Automatisch PPT

## Installeren van DietPi OS

DietPi is een "lightweight" OS dat sneller runt dan de normale RPI OS. Om het te installeren moet je toegang hebben tot een andere computer om RPI Imager te installeren en gebruiken.

### Flashen op een andere Computer

Eerst download [RPI imager](https://www.raspberrypi.com/software/) voor uw operating systeem. Start het op en steek de MicroSD kaart in de computer. 

Ga naar de [DietPi Website](https://dietpi.com/#downloadinfo) en neem de download die aangeduid is. Expand het van .img.xz naar .img.  

![image](afbeeldingen/dietpi_download.jpeg) 

In RPI Imager, ga naar custom en zoek naar je .img bestand. Klik op "Edit Settings" nadat je je SD kaart hebt geselecteerd. 

![image](afbeeldingen/dietpi_flashing.jpeg)

Ga dan ook naar SERVICES -> Enable SSH (met wachtwoord). Dan klik `SAVE` en `YES`. DietPi wordt geinstalleerd op je SD kaart, en dan kan het in de RPI02W.


### RPI02W Setup

Volg de foto om alles te verbinden met de RPI. Steek de power kabel laatst in zodat je alles zal zien op het scherm. 


### RPI02W Eerste Opstart

Ga door de stappen van DietPi op te zetten op de computer. Aan het einde zal je op de console komen, want er is nog geen GUI geinstalleerd. 

BEELD VAN CONSOLE 

Typ `dietpi-software` en installeer LXDE. MEER UITGEBREIDT 

### Remote verbinden met RPI

```
sudo apt install net-tools
ipconfig -a
```

Dan vindt je het IP-adres van de RPI. 


Als je SSH nog moet enablen:

```
sudo apt install openssh-server
sudo systemctl status ssh 
sudo systemctl enable ssh 
sudo systemctl daemon-reload 
sudo systemctl restart ssh 
```

Dan verbinden via SSH: 

```
ssh pi@192.168.0.100
```

Wachtwoord is raspberry, of iets anders als je het veranderd hebt. 

## Installeren van LibreOffice

LibreOffice is een sneller versie van MicrosoftOffice, gemaakt voor Linux devices. Typ de volgende commando in de LXTerminal om het te installeren. 

```
sudo apt install libreoffice
```


## Veranderingen aan ppt zodat het automatisch speelt. 

## Opzetten van automatisch service met script en .service bestand. 

## Commandos die worden uitgevoerd om zeker te maken dat de ppt aan het runnen is. 

## Maken van circuit met knop om een nieuwe ppt te downloaden van google docs. 

Misschien ook leds voor gelukt of niet gelukt. 

## Programmeren van file voor I/O. 

## Stoppen van de automatisch ppt en de trekken van de nieuwe ppt van de google docs. 