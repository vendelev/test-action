
.ONESHELL:
.PHONY: migrate

migrate-exec:
	${EXEC} php-actions bin/cake migrations migrate
	${EXEC} php-actions bin/cake migrations migrate -c test
	${EXEC} php-actions bin/cake migrations seed

migrate-add:
	${EXEC} php-actions bin/cake migrations create $(name)
	make perms

migrate-rollback:
	${EXEC} php-actions bin/cake migrations rollback

