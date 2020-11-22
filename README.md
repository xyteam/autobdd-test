# autobdd-test

#### purposes:
1. smoke test and demo the automagic power of xyteam/autobdd test framework;
2. serve as a template for setting up a new autobdd test project.

#### requirement:
1. docker,
2. docker-compose
3. git
4. vnc client/viewer

#### demo setup:
1. mkdir -p $HOME/Projects
2. git clone https://github.com/xyteam/autobdd-test.git $HOME/Projects/autobdd-test

#### test and report:
##### e2e test
```
docker-compose run --rm autobdd-test-run "make e2e-autorunner"
```
##### review e2e test report
use browser to open test-results/build-test/index.html
or
lauch a http server:
```
cd test-results
python -m http.server
```
then open browser to http://host-ip:8000
to review the report

#### performance test
###### k6 performance test
```
docker-compose run --rm autobdd-test-run "make k6-test"
```
#### unit test
###### js unit test
```
docker-compose run --rm autobdd-test-run "make js-test"
```
###### cypress unit test
```
docker-compose run --rm autobdd-test-run "make cy-test"
```
###### python3 unit test
```
docker-compose run --rm autobdd-test-run "make py3-test"
```
###### python2 unit test
```
docker-compose run --rm autobdd-test-run "make py2-test"
```
#### test development env
###### start dev container:
```
docker-compose up -d autobdd-test-dev
```
###### ssh access to dev container:
```
ssh -o StrictHostKeyChecking=no localhost -p 2224
or
ssh -o StrictHostKeyChecking=no $USER@ip.add.re.ss -p 2224
```
###### vnc viewer access to dev container:
```
vnc://ip.add.re.ss:5904
```
###### run single test from ssh shell:
```
cd e2e-test/test-something
arunner.sh features/test_image.feature
arunner.sh features/test_ocr.feature:7
```
Observe browser GUI from vnc viewer

#### set up new project
1. rm -rf autobdd-test/.git
2. rename autobdd-test to new-project-name
3. git init
