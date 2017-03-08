#!/bin/sh

DIRECTORY="/var/repos/static.git"

if [ ! -d "$DIRECTORY" ]; then
	cd /var
	mkdir repos
	cd repos
	mkdir static.git
	cd static.git
	git init --bare
	cd /var

	cd /var/repos/static.git/hooks

	touch post-receive
	chmod +x post-receive
	FILE=post-receive
	echo "#!/bin/sh" > $FILE
	echo "GIT_WORK_TREE=/var/www/html/static git checkout -f" >> $FILE

	cd /
fi