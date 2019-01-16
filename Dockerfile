FROM heroku/heroku:18-build

# Install the CLI
RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME

RUN mkdir -p /opt/heroku

# Install python and pip
RUN apt-get -y install python3 python3-pip bash && apt-get update
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
# EXPOSE 5000 		

# Run the image as a non-root user
# none root stuff follows
RUN useradd -m heroku
RUN usermod -d $APP_HOME heroku
RUN chown heroku $APP_HOME
USER heroku

ADD . $APP_HOME 

ADD ./heroku-exec.sh /heroku-exec.sh
# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD bash /heroku-exec.sh && gunicorn --bind 0.0.0.0:$PORT wsgi
