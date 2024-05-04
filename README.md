# Generate self-signed certificate for Ssl Apache on Linux

### Script sh of automated generation.

#### Just run create.sh
then these files will be copied in:
server.crt in /etc/ssl/certs/
server.key /etc/ssl/private/

### Configuration files
_CA.conf
_SV.conf
passfiles/CA_pass
passfiles/SV_pass


### These are the commands used

sudo openssl req -new -passout file:passfiles/CA_pass -config _CA.conf -out authority.csr
sudo openssl x509 -req -sha256 -days 365 -in authority.csr -signkey keyfile.key -out authority.crt -passin file:passfiles/CA_pass
sudo openssl req -new -passout file:passfiles/SV_pass -config _SV.conf -out server.csr
sudo openssl rsa -in privkey.pem -passin file:passfiles/SV_pass -out server.key
sudo openssl x509 -req -in server.csr -CA authority.crt -CAkey keyfile.key -CAcreateserial -out server.crt -sha256 -days 2920 -passin file:passfiles/CA_pass

### Alternative commands

sudo openssl req -new -passout pass:111111111 -config _CA.conf -out authority.csr
sudo openssl x509 -req -sha256 -days 365 -in authority.csr -signkey keyfile.key -out authority.crt -passin pass:111111111
sudo openssl req -new -passout pass:222222222222 -config _SV.conf -out server.csr
sudo openssl rsa -in privkey.pem -passin pass:222222222222 -out server.key
sudo openssl x509 -req -in server.csr -CA authority.crt -CAkey keyfile.key -CAcreateserial -out server.crt -sha256 -days 365 -passin pass:111111111
