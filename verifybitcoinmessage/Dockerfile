FROM inutano/wget AS wget
RUN wget -r https://www.verifybitcoinmessage.com/

FROM nginx
COPY --from=wget /www.verifybitcoinmessage.com /usr/share/nginx/html/
