# How to install a R Server instance in  an Ubuntu Trusty server

## Install R

R provided by normal Ubuntu repos is usually 1-2 years old. 

Add Cran mirror repository address to known repos.

```
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
```

Get relevant keys and get APT

```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
```

Update stuff
```
sudo apt-get update
```

Get R

```
sudo apt-get -y install r-base
```


## Install server

``` 
 sudo apt-get install gdebi-core
 wget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb
 sudo gdebi rstudio-server-0.99.903-amd64.deb
 ```
 
 Is it alive?
 ```
 sudo rstudio-server verify-installation
 ```
 
 #Change Port
 
 Go to folder 
 
 ```
 cd /etc/rstudio
 ls
 ```
 
Rserver.conf should exist. If everything is ok, we edit it.

``` nano rserver.conf
```

Add line ``` www-port = 80 ``` to use port 80.

Restart  Rstudio server

``` sudo rstudio-server ```
 
 
