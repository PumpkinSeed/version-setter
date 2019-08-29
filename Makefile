testit:
	VERSIONED_FILE=test.go BUILD_CMD="go build -o testcmd test.go" sh versionsetter.sh && ./testcmd

deploy:
	mv versionsetter.sh /usr/local/bin/versionsetter && chmod +x /usr/local/bin/versionsetter