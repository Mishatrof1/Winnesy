FROM python:3.7

###########################################################################
# Set ENV
###########################################################################

ENV PYTHONUNBUFFERED 1
ARG REQUIREMENTS

###########################################################################
# Set Timezone
###########################################################################

ARG TZ=UTC
ENV TZ ${TZ}

ARG REQUIREMENTS=true
ENV REQUIREMENTS $REQUIREMENTS

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

###########################################################################

RUN mkdir -p /var/www

COPY apps/frontend-gateway/ /var/www

COPY requirements.txt /tmp/requirements.txt

RUN set -eux; \
     if [ "$REQUIREMENTS" = "true" ]; then \
         pip install --no-cache-dir -r /tmp/requirements.txt; \
     else \
        readonly PACKAGES=${REQUIREMENTS}; \
        pip install --no-cache-dir ${PACKAGES}; \
     fi

###########################################################################
# Run application
###########################################################################

WORKDIR /var/www

CMD [ "python", "./app.py" ]


#COPY start.sh /

#RUN chmod +x /start.sh

#CMD [ "/start.sh"]