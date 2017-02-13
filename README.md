NGINX + letsencrypt Docker Container
====================================

Docker container that includes simple SSL certificate setup using letsencrypt.
 
 
Usage
-----

**Important Note**

You must agree the Terms of Service for the letsencrypt service, by setting the `AGREE_TOS` environment variable to 
'yes' when running the container.  By doing this, you are accpeting the Terms of Service, as layed out by letsencrypt at 
the time of use.


Docker compose file…

    # docker-compose.yml
    version: '2'
    
    volumes:
      ssl-certificates: ~
    
    services:
      nginx:
        image: cubicmushroom/nginx-letsencrypt
        environment:
          DOMAINS:            www.example.com
          AGREE_TOS:          'yes'
          LETSENCRYPT_EMAIL:  me@example.com
          WEB_ROOT:           /var/www/html
        volumes:
          - ssl-certificates:/etc/letsencrypt


Get initial SSL certificates…

    $ docker-compose run --rm --entrypoint /certs nginx
    
If you want to run this against the letsencrypt staging servers you can include the CERTBOT_STAGING environment variable 
set to anything truthy…

    # docker-compose.yml
    version: '2'
    
    volumes:
      ssl-certificates: ~
    
    services:
      nginx:
        image: cubicmushroom/nginx-letsencrypt
        environment:
          DOMAINS:            www.example.com
          AGREE_TOS:          'yes'
          LETSENCRYPT_EMAIL:  me@example.com
          WEB_ROOT:           /var/www/html
          CERTBOT_STAGING:    'yes'
        volumes:
          - ssl-certificates:/etc/letsencrypt

