FROM nginx:1.11

ENV ENDPOINT https://test.sh

WORKDIR /app/

ADD ./generate.sh /app/generate.sh

RUN chmod u+x ./generate.sh

CMD /bin/bash -c "/app/generate.sh && nginx -g 'daemon off;'"
