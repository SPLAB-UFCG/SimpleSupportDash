FROM httpd:latest
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh"]
CMD ["httpd-foreground"]
