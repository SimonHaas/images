# simple-block-explorer

https://github.com/jonasschnelli/simple-block-explorer

https://bitcoin.jonasschnelli.ch/explorer/

``` bash
docker build . -t sbe --build-arg MAIN_ENDPOINT_HOST=3.3.3.3
docker run --rm -it -p 80:80 sbe head -10 index.php
```
