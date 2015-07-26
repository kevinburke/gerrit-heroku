download:
	rm -rf bin/gerrit.war
	mkdir -p bin
	curl --location https://www.gerritcodereview.com/download/gerrit-2.11.2.war --output bin/gerrit.war

deploy:
	git push heroku master
