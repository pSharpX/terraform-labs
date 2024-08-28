
keytool -importcert -alias MySQLCACert.jks -file ./configs/server-ca.pem -keystore ./configs/truststore.jks -storepass mypassword -noprompt
openssl pkcs12 -export -in ./configs/client-cert.pem -inkey ./configs/client-key.pem -out ./configs/certificate.p12 -name "certificate" -password pass:mypassword
keytool -importkeystore -srckeystore ./configs/certificate.p12 -srcstoretype pkcs12 -destkeystore ./configs/client-cert.jks -srcstorepass mypassword -deststorepass mypassword -destkeypass mypassword -noprompt