#!/bin/bash
echo -e "\033[0;37m"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
echo " #####   ####        ####        ####  ####    ######    ##########  ####    ####  ###########   ####  ####";
echo " ######  ####       ######       #### ####    ########   ##########  ####    ####  ####   ####   #### ####";
echo " ####### ####      ###  ###      ########    ####  ####     ####     ####    ####  ####   ####   ########";   
echo " #### #######     ##########     ########   ####    ####    ####     ####    ####  ###########   ########";
echo " ####  ######    ############    #### ####   ####  ####     ####     ####    ####  ####  ####    #### ####";  
echo " ####   #####   ####      ####   ####  ####   ########      ####     ############  ####   ####   ####  ####";
echo " ####    ####  ####        ####  ####   ####    ####        ####     ############  ####    ####  ####   ####";
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
echo -e '\e[36mTwitter:\e[39m' https://twitter.com/NakoTurk
echo -e '\e[36mGithub :\e[39m' https://github.com/okannako
echo -e '\e[36mYoutube :\e[39m' https://www.youtube.com/@CryptoChainNakoTurk
echo -e "\e[0m"
sleep 5
echo -e "\033[0;35m"
echo 'Güncellemeler Yükleniyor..' 
echo -e "\e[0m"
sleep 1
sudo apt-get update \
&& sudo apt-get install -y --no-install-recommends \
tzdata \
ca-certificates \
build-essential \
libssl-dev \
libclang-dev \
pkg-config \
openssl \
protobuf-compiler \
cmake
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
rustc --version
sudo systemctl restart systemd-journald
echo -e "\033[0;35m"
echo 'Dosyalar Yükleniyor..'
echo -e "\e[0m"
cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout -B testnet --track upstream/testnet
sleep 3
mkdir $HOME/.sui
wget -O $HOME/.sui/genesis.blob  https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml
sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml
cargo build --release --bin sui-node
mv ~/sui/target/release/sui-node /usr/local/bin/
sui-node -V
echo "[Unit]
Description=Sui Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/suid.service

mv $HOME/suid.service /etc/systemd/system/

sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
echo -e "\033[0;35m"
echo 'Node Başlatılıyor..'
echo -e "\e[0m"
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid
sleep 3
echo -e "\033[0;35m"
echo 'Yükleme Tamamlandı. Loglardan ve Kontrol Sitesinden Node Durumuna Bakabilirsiniz.'
echo -e "\e[0m"
sleep 5
