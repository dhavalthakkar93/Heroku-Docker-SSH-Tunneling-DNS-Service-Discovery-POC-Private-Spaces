# Heroku-Docker-SSH-Tunneling-POC-Private-Spaces

This proof of concept app is intended to demonstrate SSH Tunneling for Docker Containers in Heroku Private Spaces.  

First clone the code

```
git clone https://github.com/dhavalthakkar93/Heroku-Docker-SSH-Tunneling-POC-Private-Spaces
```

Create Heroku App

```
heroku create

Creating app... done, ⬢ still-reaches-17754
https://still-reaches-17754.herokuapp.com/ | https://git.heroku.com/still-reaches-17754.git
```

# Build Image 

- `docker build -t "Heroku-Docker-Exec" .`

# Deploy 

- `heroku container:push web -a <APP_NAME>`
- `heroku container:release web -a <APP_NAME>`

# Scale Dynos (Optional)

```
heroku ps:scale web=3

Scaling dynos... done, now running web at 2:Standard-1X
```

# Check Dynos are up

```
heroku ps -a <APP_NAME>

=== web (Standard-1X): /bin/sh -c bash /heroku-exec.sh && gunicorn --bind 0.0.0.0:$PORT wsgi (3)
web.1: up 2019/01/13 00:48:24 +0530 (~ 12m ago)
web.2: up 2019/01/13 00:48:31 +0530 (~ 12m ago)
web.3: up 2019/01/13 00:48:31 +0530 (~ 12m ago)
```
# SSH into Dyno

```
heroku ps:exec --dyno=web.3 -a <APP_NAME>

Establishing credentials... done
Connecting to web.3 on ⬢ exec-docker... 
~ $ 
```







