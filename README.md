# bbb-optimizasyon

## BigBlueButton Sunucusunu Kendimize Göre Özelleştiriyoruz

BigBlueButton sunucusunun tüm özelleştirmelerini apply-config.sh içinde tutun, böylece (1) tüm BBB sunucularınız aynı özelleştirmelere hatasız bir şekilde sahip olur ve (2) yükseltme sırasında bunları kaybetmezsiniz.

Aşağıdaki komutları sırasıyla sunucunuza SSH ile bağlanıp çalıştırın.

```sh
sudo apt-get update -y
sudo apt-get install -y xmlstarlet
git clone https://github.com/uzeportal/bbboptime.git
cd bbboptime
chmod 755 kur.sh
./kur.sh

# PUBLIC_IP'yi BBB sunucunuzun genel IP'sine ayarlamak için apply-config.sh dosyasını düzenleyin


## NOT Problem Olursa Kullanın. Gitup projenizden indirilen ve /root/bbboptime diye oluşan klasörü sunucudan silmek içindir
```sh
rm -r /bbboptime
```

Varsayılan BigBlueButton kurulumunu markanızla eşleşecek şekilde aşağıdaki şekillerde güncelleyebilirsiniz:
1. Sunum alanında görünecek varsayılan PDF
2. Site simgesi olarak görünecek logo (favicon biçimi)
3. "Hakkında" bölümünde görünen uygulama adı - sağ taraftaki menü
4. Genel sohbet alanında görünecek hoş geldiniz mesajı
5. Bir kullanıcı bir sınıftan çıkış yaptığında görünen index.html. Kendi sürümünüzü oluşturun ve `/ var / www / bigbluebutton-default / '' içine koyun.

Ek olarak, apply-config.sh içinde aşağıdaki öğeleri değiştirebilirsiniz:
1. clientTitle
2. appName
3. copyright
4. helpLink

## Kayıtları otomatik mp4 olarak dönüştürür
Eğer mevcut kayıtların tümünü mp4 formatına çevirmek istiyorsan

```sh
bbb-record --rebuildall
```
Şayet tek bir video dosyasını mp4 formatına çevirmek istiyorsan

```sh
./export_presentation.rb -m <meeting_id>
```


