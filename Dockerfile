FROM gliderlabs/alpine:3.4

MAINTAINER Seth Lakowske <lakowske@gmail.com>

ENV CERTS=/certs
ENV KEYDIR=$CERTS/admin

RUN apk-install openssl

CMD mkdir -p $KEYDIR && \
/usr/bin/openssl  genrsa -out $KEYDIR/admin-key.pem 2048 && \
/usr/bin/openssl req -new -key $KEYDIR/admin-key.pem -out $KEYDIR/admin.csr -subj "/CN=kube-admin" && \
/usr/bin/openssl x509 -req -in $KEYDIR/admin.csr -CA $CERTS/ca.pem -CAkey $CERTS/ca-key.pem -CAcreateserial -out $KEYDIR/admin.pem -days 365
