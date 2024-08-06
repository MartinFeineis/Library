if ! [[ "18.04 20.04 22.04 23.04" == *"/etc/upstream-release/lsb-release | grep -oP '(?<=DISTRIB_RELEASE=)[\d.]+'"* ]];
then
    echo "Ubuntu /etc/upstream-release/lsb-release | grep -oP '(?<=DISTRIB_RELEASE=)[\d.]+' is not currently supported.";
    exit;
fi

curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

curl https://packages.microsoft.com/config/ubuntu/"cat /etc/upstream-release/lsb-release | grep -oP '(?<=DISTRIB_RELEASE=)[\d.]+'"/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev
