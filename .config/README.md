# `.config`

## syncthing

- listen address: `tcp4://0.0.0.0:22000`
- discovery servers : `default-v4`

## barrier

- <https://wiki.archlinux.org/title/Barrier>

```
BARRIER_SSL=$XDG_DATA_HOME/barrier/SSL
mkdir -p "$BARRIER_SSL/Fingerprints"
openssl req -x509 -nodes -days 365 -subj /CN=Barrier -newkey rsa:4096 -keyout $BARRIER_SSL/Barrier.pem -out $BARRIER_SSL/Barrier.pem
fingerprint=$(openssl x509 -fingerprint -sha256 -noout -in $BARRIER_SSL/Barrier.pem | cut -d"=" -f2)
echo "v2:sha256:$fingerprint" > $BARRIER_SSL/Fingerprints/Local.txt
barrier --enable-crypto
```

## LibreOffice

- `Tools | Options | Libreoffice | Security | Options | Block any links from documents ...`
