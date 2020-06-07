FROM swift:5.2
WORKDIR /app
COPY . .

RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/known_hosts
RUN cp ./.ssh/* /root/.ssh
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
RUN chmod 400 ./.ssh/key

CMD swift run

# Docker build command:
# docker build -t tag-name .

# Docker run command: 
# docker run tag-name