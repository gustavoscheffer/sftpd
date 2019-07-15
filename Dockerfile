FROM centos

RUN yum install openssh-server openssh-clients -y

COPY ./sshd_config ./sshd_config
COPY ./keys ./
COPY ./host_keys ./

EXPOSE 2222

CMD ["/usr/sbin/sshd", "-D"]