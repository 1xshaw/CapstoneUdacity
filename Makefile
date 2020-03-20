install:
	# install awscli
	sudo apt-get install python3-pip &&\
	python3 -m pip install awscli &&\

	# install jenkins
	apt -y update
	apt -y upgrade
	apt -y install default-jdk
	wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
	sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
	apt -y update
	apt -y install jenkins



lint:
	pylint ./app/app.py