FROM centos

RUN yum install openssh-server openssh-clients -y

RUN  mkdir -p /host_keys

COPY ./sshd_config ./sshd_config
COPY ./host_keys/* /host_keys/

RUN chmod 600 ./host_keys/ssh_host_*_key

RUN useradd -g root -m  -d /home/sftpd_user -p ucStYVz9DqV7U sftpd_user; \ 
    mkdir -p /home/sftpd_user/.ssh

COPY ./keys/* /home/sftpd_user/.ssh/

RUN chmod 600 home/sftpd_user/.ssh/id_rsa; \ 
    chmod 600 home/sftpd_user/.ssh/authorized_keys; \ 
    chmod 644 home/sftpd_user/.ssh/id_rsa.pub; \ 
    chown -R sftpd_user:root /home/sftpd_user/.ssh

EXPOSE 2222

CMD ["/usr/sbin/sshd", "-D", "-f", "sshd_config", "-e"]