+++
date = '2025-08-21T18:27:28+01:00'
draft = false
title = 'Introduction to Nginx'
categories =["Sysadmin & Servers","Self-Hosting"]
tags=["nginx","webdev"]
+++
## Key Features and use cases of Nginx 
Ngix's archiecture and flexibility make it suitablr foe various use  cases
### Web server 
Nginx can serve both static and dynamic content it's highly optimized foe delivering files like HTML,CSS and images very quickly.
### Reverse Proxy 
It acts as an intermediary between client requestes and backend servers,offering features likr caching ,compression and security.
### Load Balancer 
NGINX can distribute incoming reauests across multiple servers balancing the load to improve availability and reliability, and handling trific spikes efficiently.

Nginx  is  Event Driven  and Asynchronous model .

| Nginx         | Apache      |
| ------------- | ------------- |
| -uses an event driven based model  | uses a process based model |
|User cases|
|When hih performance scalability, and serving static content efficiently are key priorities .| when your application requires dynamic content managent ,comllexx configuration or compatibility with legacy system .


### Setps  to install simple Nginx on  linux  

#### Install using  you packge manager 
> Void linux : 
```
sudo xbps-install -S nginx 
```
> debain 
```
 sudo apt install nginx 
```
### After Installation you'll Manage Nginx using you are service manager 
> Void linux 
```
sudo ln -s /etc/sv/nginx /var/service/  
```
### Configer the firewall 'ufw' to manage network traffic and enforce security Policies .  

### Secutity-Enhanced Linux (SELinux ) prorvides an additional security layer for linux system.
Selinux can block Nginx  from function properly if not configured correctly .
### The configuration File  is in /etc/nginx folder 
**Main Context** : Global setting like worker processes .
**Events Context** : Handles connection processing .
**Http Context** : Configures Http server behavior.
**Server Context** : Defines setting for virtual hosts (server blocks).
**Location Context** : sepcifies how to porcess requests for specific locations or URLs.
#### Key Directive in the main configuration file (nginx.conf)
We Have
User Directive they define nginx which user they work with it .
*worker_processes* we put nombre of cpu core 
> &uarr; More Processes  &uarr; More conccurent connections 
> set works_processes to the numbre of CPU cores for optimal performance.

*worker_connections* nombre of conccurent connction the  server can handle or how many simultaneous connections each works can handle.
 max_clients = worker_processes * worker_connection 
Http bloc

#### Configuring Error And Access Logging 
**Access Logs** : store details about requests made to the server .
example access_log /var/log/nginx/access.log main;
**Error logs : Record details about errore encoutered while processing requests .
example : error_log /var/log/nginx/error.log wran;
#### Document Root and Permissions 
*NGINX* involves defining the document root ,which is the directory where website files like index.html are stored. 
Ensure proper permissins are set for the web server to access these files.
```
 server {
      listen 80;
      server_name example.com;
      root /var/www/html;
      index index.html;
 }
```
**Configure the permissions** : 
```
sudo chown -R nginx:nginx /var/www/html
```
#### Managing index.html and 404 error Pages 
*Nginx* Allows you to configure *default index file*  and custom error pages 
```
   Index index.html;

```
Configure a custom 404 error pages as follows 
```
  error_page 404 /404.html;
  location =/404.html{
        root /var/www/html;
      }
```
### Managing Virtual Host (server Blocks)
can prevade to website from seme server evry server block can have his on config .

## Tips For Multiple Enviornments (Development Vs  Production)

In production Environments ,consider enabling caching ,compression and tighter security controls (e,g ,SSL).
*Example*
```
location / {
    Proxy_cach my_chache;
    Proxy_cache_valid 200 1h;
    }
```
In development ,Enable detailed logging and easier access for devugging .

*Example*
 error_log /var/log/nginx/dev_error.log debug;

### Basic URL Rewriting and Redirection 
the Rewrite Directive  allows you to modift the URL before it's processed by the server. 
> we can use  to readirec from old page  to new page 
``` 
rewrite ^/oldpage /newpage permanent;
```

in addition to rewrite , you can use  the return directive  for simple redirects .

```
server {
   listen 80;
   server_name oldsite.com 
   return 301 http:newsite.com$request_uri;
    }
```
but i we use code 302 Redirect  is temporary redirection.

## Practical Example : Configuring nginx with all sections in module2 
In this practical example ,we will walk through the setps required to 
 1 -set up nginx with a basic configuration 
 2 -seve static content from a website .
 3 - configure multiple virtual host (server blocks) for different domains.
 4 -set up custom error pages and directory listings.
 5 -implement basic URL rewriting and redirection.


### Why use  a reverse  proxy  




