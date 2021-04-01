testSectionBegin="=======\nTest\n-------"
testSectionEnd="----------\nDone Test\n=========="

.PHONY: docker-run test-all test clean e2e-test cy-test js-test py3-test py2-test k6-test

docker-run:
	@echo make $@
	docker-compose run --rm autobdd-test-run "xvfb-runner.sh make ${jobs}"
docker-run-bash:
	@echo make $@
	docker-compose run --rm autobdd-test-run "/bin/bash"
docker-up:
	@echo make $@
	docker-compose up -d autobdd-test-dev
docker-logs:
	@echo make $@
	docker-compose logs autobdd-test-dev
docker-logs-f:
	@echo make $@
	docker-compose logs -f autobdd-test-dev
docker-down:
	@echo make $@
	docker-compose down
docker-ssh:
	ssh $$USER@localhost -p 2224 || exit $?

clean:
	@echo make $@
	@echo "cleaning autorunner-report folder...";
	rm -rf test-results/*;
	find . -type d -name "__pycache__" -o -name ".pytest_cache" | xargs rm -rf;
	find . -type f -name "*.pyc" | xargs rm -f;
	find e2e-test -type d -name logs | xargs rm -rf;
	find e2e-test -type d -name test-results -o -name arunner-report -o -name prunner-report -o -name autorunner-report | xargs rm -rf;
	find e2e-test -type f -name "test-*.json" | xargs rm -f;
	find e2e-test -type f -name "Passed_*.???" -o -name "Failed_*.???" -o -name "Recording_*.???" | xargs rm -f;

e2e-arunner:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running cucumber test with arunner.sh (single runner)...";
	cd e2e-test/test-1nit && SCREENSHOT=3 MOVIE=1 REPORTDIR=../../test-results/arunner-report arunner.sh || exit $$?;
	@echo ${testSectionEnd}

e2e-prunner:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running cucumber test with prunner.sh (parllel runner)...";
	cd e2e-test && SCREENSHOT=3 MOVIE=1 REPORTDIR=../test-results/prunner-report prunner.sh test-autobdd-libs || exit $$?;
	@echo ${testSectionEnd}

e2e-autorunner:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running cucumber test with autorunner (parallel runner with cucumber report)...";
	autorunner.py --project autobdd-test --reportpath autorunner-report --movie 1 -- --cucumberOpts.tags='not @Init and not @Report' || exit $$?;
	find test-results/autorunner-report -type f -name "*.run" | xargs cat || exit $$?;
	@echo ${testSectionEnd}

e2e-autoreport:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "checking cucumber report...";
	cd e2e-test/test-autobdd-reports && prunner.sh || exit $$?;
	@echo ${testSectionEnd}

e2e-test: e2e-arunner e2e-prunner e2e-autorunner e2e-autoreport
	@echo make $@

js-test:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running jest unit test...";
	cd js-test && npm install && \
	node_modules/.bin/jest --verbose . || exit $$?;
	@echo ${testSectionEnd}

py3-test:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running python3 unit test...";
	pip3 install -r py-test/requirement3.txt && \
	python3 -m pytest -r A py-test || exit $$?;
	@echo ${testSectionEnd}

py2-test:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running python2 unit test...";
	pip2 install -r py-test/requirement2.txt && \
	python2 -m pytest -r A py-test || exit $$?;
	@echo ${testSectionEnd}

cal-app-start:
	@echo make $@
	@echo "starting up cal-app...";
	cd cal-app && npm install && npm start
	
cal-app-stop:
	@echo make $@
	@echo "stopping cal-app...";
	cd cal-app && npm stop

cy-test: cal-app-start
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running cypress test...";
	cd cal-app && \
	node_modules/.bin/cypress install && \
	node_modules/.bin/cypress run || exit $$?;
	@echo ${testSectionEnd}

k6-test:
	@echo make $@
	@echo ${testSectionBegin};
	@echo "running k6 performance test...";
	cd k6-test && find . -type f -name "*-test.js" | xargs k6 run || exit $$?;
	@echo ${testSectionEnd}

test-all: clean e2e-test cy-test js-test py3-test k6-test
	@echo make $@

test-all2: clean e2e-test cy-test js-test py3-test py2-test k6-test
	@echo make $@
