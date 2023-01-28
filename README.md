<p align="center">
  <a href="https://orbisworlds.org">
    <img alt="Hero" src="https://user-images.githubusercontent.com/73176377/215267435-a42ece17-4448-4263-a0d3-c6cd6188e4fa.png" width="75%" />
  </a>
</p>

## Tavsiye Edilen Sistem Gereksinimleri
- CPU: 10 ÇEKİRDEK
- RAM: 32+ GB
- SSD: 1 TB
- İşletim Sistemi: Ubuntu 20.04LTS

- Sui node için Hetzner sistemini kullanıyorum. En sağlıklı ve kaliteli sistemler burada var. Bununla alakalı kullanım ve nasıl ücretsiz 20 Euro alabileceğinizi aşağıdaki videoda anlattım.
    - Hetzner Video >>> https://www.youtube.com/watch?v=LZfNApSfC1Q&t=204s

## Kurulum Adımları ve Kodları
- Tek kod kurulumun yapılması ve node un başlaması için yeterli. Her ihtimale karşı tmux kullanabilirsiniz ama gerekli değil.

```
wget -q -O sui.sh https://raw.githubusercontent.com/okannako/suitestnetwave2/main/sui.sh && chmod +x sui.sh && sudo /bin/bash sui.sh
```

- Logları kontrol etmek

```journalctl -u suid -f```

- Node Stop, Start, Restart
```
sudo systemctl stop suid
sudo systemctl start suid
sudo systemctl restart suid
```

## Node Kontrol Adımları
  
  1-) https://www.scale3labs.com/check/sui sitesine girip IP adresimizi yazdıktan sonra Check butonuna bastıktan kısa bir süre sonra Node durumunu görebilirsiniz

  2-) Aşağıdaki 2 kodu girerek Node un Sui ağının güncel bloğundan ne kadar uzakta olduğunu görebilirsiniz. 1. kod Sui ağı 2. kod sizin node nuzun blok sayısı.
     
```    
curl --location --request POST https://fullnode.testnet.sui.io:443 \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}' 
```    
   
```
curl --location --request POST http://127.0.0.1:9000/ \
--header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}'
```    
  
  3-) Aşağıdaki yöntem ise en önemli kontrol yöntemi. Kodu çalıştırdığınızda Sui ağı ve sizin node nuzun TPS sayılarını karşılaştırarak bir sornuç çıkıyor. Node sisteme eşitlendikten sonra node nuzun TPS değeri Sui Tps e eşit ya da çok yakın olmalıdır. Eğer arada büyük farklılıklar varsa herhangi bir nedenden dolayı node nuzda problem vardır. Son olarak ne olursa olsun TPS değeriniz 0'dan büyük olmalı.

```
wget -O $HOME/check_testnet_tps.sh https://raw.githubusercontent.com/bartosian/sui_helpers/main/check_testnet_tps.sh && chmod +x $HOME/check_testnet_tps.sh && $HOME/check_testnet_tps.sh
```

- Tekrar kontrol etmek için.
```
$HOME/check_testnet_tps.sh
```

NOT: Mail alanlar işlemleri yaptıktan sonra maildeki form ile bilgilerini yollamayı unutmasınlar. 
