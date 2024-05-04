: << 'COMMENT'

COMMENT

echo
echo
echo

sudo openssl req -new -passout file:passfiles/CA_pass -config _CA.conf -out authority.csr
sudo openssl x509 -req -sha256 -days 365 -in authority.csr -signkey keyfile.key -out authority.crt -passin file:passfiles/CA_pass
sudo openssl req -new -passout file:passfiles/SV_pass -config _SV.conf -out server.csr
sudo openssl rsa -in privkey.pem -passin file:passfiles/SV_pass -out server.key
sudo openssl x509 -req -in server.csr -CA authority.crt -CAkey keyfile.key -CAcreateserial -out server.crt -sha256 -days 2920 -passin file:passfiles/CA_pass
openssl x509 -in authority.crt -text -noout  > results/_CA_ck
openssl x509 -in server.crt -text -noout > results/_SV_ck

echo
echo "Press 1 to copy certificate to /etc/ssl"
read -r res
if [[ "$res" == "1" ]]; then
    sudo cp server.crt /etc/ssl/certs/server.crt
    sudo cp server.key /etc/ssl/private/server.key
fi
sudo mv authority.csr results/authority.csr
sudo mv keyfile.key results/keyfile.key
sudo mv authority.crt results/authority.crt
sudo mv authority.srl results/authority.srl
sudo mv server.csr results/server.csr
sudo mv privkey.pem results/privkey.pem
#sudo mv server.crt results/server.crt
#sudo mv server.key results/server.key






