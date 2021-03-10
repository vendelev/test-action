INSTALL=clean ok vendor perms

.ONESHELL:
.PHONY: ok clean install vendor

ok: docker-compose-ok services-is-up

vendor:
	${EXEC} php-actions composer install
	make perms

clean:
	make rm:tmp
	make rm:vendor

install: up ok unless-prod vendor perms

reinstall: up ok unless-prod clean install

cs: ok
	@$(EXEC) php-actions ./vendor/bin/phpcs || exit 1
	echo "CodeSniffer: \033[30m \033[42m  OK  \033[0m"

psalm:
	@echo "Psalm: ..."
	$(EXEC) php-actions ./vendor/bin/psalm.phar

phpunit:
	@$(EXEC) php-actions ./vendor/bin/phpunit

app-ok: ok perms cs psalm phpunit
