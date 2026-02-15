FROM postgres:18

RUN apt-get update && apt-get install -y \
      curl \
      rclone \
      tzdata \
      bash \
      ca-certificates \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /backup

COPY backup.sh /backup/backup.sh
COPY restore.sh /backup/restore.sh
RUN chmod +x /backup/*.sh

ENTRYPOINT ["bash"]
CMD ["/backup/backup.sh"]