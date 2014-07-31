#!/bin/sh
# Configure script for linux environment for the framework MDArte.
# Version - 0.01
# By Filipe Braida do Carmo
# URL: http://www.cos.ufrj.br/~filipebraida/

# Configuration Build Properties
build="build.properties"

if [ ! -f ~/$build ]
then
	echo "Create Build Properties? ( y/n ) : \c"
	read answer
	if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
	then
		printf "Creating Build Properties...\n"

		touch ~/$build
		echo "maven.repo.remote=http://jabot.cos.ufrj.br/repositorio" >> ~/$build

		echo "With Proxy? ( y/n ) : \c"
		read answer
		if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
		then
			echo "Proxy IP? : \c"
			read answer
			echo "maven.proxy.host = " ${answer} >> ~/$build

			echo "Port? : \c"
			read answer
			echo "maven.proxy.port = " ${answer} >> ~/$build
		fi
	fi
fi

# --------------------------------------------------------------------------------------
# Exporting Variables

if [ ! -f ~/.bashrc_mdarte ]
then
	echo "\nif [ -f ~/.bashrc_mdarte ]; then\n   . ~/.bashrc_mdarte\nfi\n" >> ~/.bashrc

	echo "Export Variables? ( y/n ) : \c"
	read answer
	if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
	then
		touch ~/.bashrc_mdarte
		echo "#MDArte Configurations\n" >> ~/.bashrc_mdarte
		echo "export MAVEN_OPTS=-Xmx1024m\n" >> ~/.bashrc_mdarte
		echo "export JAVA_HOME=/usr/lib/jvm/java-6-sun/\n" >> ~/.bashrc_mdarte

		echo "if [ -d ~/Work/programs/maven ] ; then\n  export MAVEN_HOME=~/Work/programs/maven\nfi\n" >> ~/.bashrc_mdarte
		echo "if [ -d ~/Work/programs/maven ] ; then\n export PATH=\$PATH:~/Work/programs/maven/bin\nfi\n" >> ~/.bashrc_mdarte
		echo "if [ -d ~/Work/programs/jboss ] ; then\n  export JBOSS_HOME=~/Work/programs/jboss\nfi\n" >> ~/.bashrc_mdarte
	fi
fi

# --------------------------------------------------------------------------------------
# Installing JBoss

if [ ! -d ~/Work/programs/jboss ]
then
	echo "Install JBoss? ( y/n ) : \c"
	read answer
	if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
	then
		if [ ! -d ~/Work ]
		then
			mkdir ~/Work
		fi

		if [ ! -d ~/Work/programs ]
		then
			mkdir ~/Work/programs
		fi

		tar -xfv programs/jboss.tar.gz -C  ~/Work/programs
		ln -s ~/Work/programs/jboss-4.2.3.GA ~/Work/programs/jboss
		mv programs/jboss-libs/* ~/Work/programs/jboss-4.2.3.GA/server/default/lib/
	
	fi
fi

# --------------------------------------------------------------------------------------
# Installing Maven

if [ ! -d ~/Work/programs/maven ]
then
	echo "Install Maven? ( y/n ) : \c"
	read answer
	if [ "$answer" = "Y" ] || [ "$answer" = "y" ]
	then
		if [ ! -d ~/Work ]
		then
			mkdir ~/Work
		fi

		if [ ! -d ~/Work/programs ]
		then
			mkdir ~/Work/programs
		fi

		tar -xfv programs/maven.tar.gz -C ~/Work/programs
		ln -s ~/Work/programs/maven-1.0.2 ~/Work/programs/maven
	
	fi
fi