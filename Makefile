.PHONY: lint phpcs phpcbf

test: lint phpcs

lint:
	find . -name '*.php' -type f -print0 | xargs -0 -n 1 -P 4 php -nl

phpcs:
	test -d /tmp/phpcs || git clone -b master --depth 1 https://github.com/squizlabs/PHP_CodeSniffer.git /tmp/phpcs
	test -d /tmp/wpcs || git clone -b master --depth 1 https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /tmp/wpcs
	/tmp/phpcs/scripts/phpcs --config-set installed_paths /tmp/wpcs
	/tmp/phpcs/scripts/phpcs -p . --standard=WordPress-VIP --extensions=php --warning-severity=8 --ignore=Rewrite-Rules-Inspector/*,amp-wp/*,batcache/*,http-concat/*,jetpack/*,media-explorer/*,writing-helper/*

phpcbf:
	test -d /tmp/phpcs || git clone -b master --depth 1 https://github.com/squizlabs/PHP_CodeSniffer.git /tmp/phpcs
	test -d /tmp/wpcs || git clone -b master --depth 1 https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /tmp/wpcs
	/tmp/phpcs/scripts/phpcs --config-set installed_paths /tmp/wpcs
	/tmp/phpcs/scripts/phpcbf -p . --standard=WordPress-VIP --extensions=php --ignore=Rewrite-Rules-Inspector/*,amp-wp/*,batcache/*,http-concat/*,jetpack/*,media-explorer/*,writing-helper/*
