FROM centos


RUN yum install openssh-server openssh-clients -y

RUN mkdir -p /data/sftp ; \
    chmod 701 /data; \
    groupadd sftpusers; \
    mkdir -p /host_keys/

COPY ./sshd_config ./sshd_config
COPY ./host_keys/* /host_keys/

RUN chmod 600 /host_keys/ssh_host_*_key; \
    useradd -g sftpusers -m -d /upload -p ucStYVz9DqV7U -s /sbin/nologin mysftpuser; \
    mkdir -p /upload/.ssh

COPY ./keys/* /upload/.ssh/

RUN chmod 600 /upload/.ssh/id_rsa; \ 
    chmod 600 /upload/.ssh/authorized_keys; \ 
    chmod 644 /upload/.ssh/id_rsa.pub; \ 
    chown -R mysftpuser:sftpusers /upload/.ssh

RUN mkdir -p /data/mysftpuser/upload; \
    chown -R root:sftpusers /data/mysftpuser; \
    chown -R mysftpuser:sftpusers /data/mysftpuser/upload

EXPOSE 8080

CMD ["/usr/sbin/sshd", "-D", "-f", "sshd_config", "-e"]