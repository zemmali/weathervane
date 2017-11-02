FROM namespace/weathervane-centos7:version
MAINTAINER hrosenbe@vmware.com

COPY entrypoint.sh /entrypoint.sh
COPY dbLoader.jar /dbLoader.jar
COPY dbLoaderLibs /dbLoaderLibs
	
RUN yum install -y java-1.8.0-openjdk && \
	yum install -y java-1.8.0-openjdk-devel && \
    chmod +x /entrypoint.sh

ENV JVMOPTS="-Xmx500m -Xms500m -XX:+AlwaysPreTouch" LOADDATA=1 PREPDATA=0 MAXUSERS=1000 USERS=1000 MAXDURATION=7200
ENV NUMNOSQLSHARDS=1 NUMNOSQLREPLICAS=0 SPRINGPROFILESACTIVE="postgresql,ehcache,imagesInMongo,singleMongo,singleRabbit"
ENV MONGODBHOSTNAME=AuctionNosql1 MONGODBPORT=27017 MONGODBREPLICASET="AuctionNosql1:27017,AuctionNosql2:27017"
ENV DBHOSTNAME=AuctionDb1 DBPORT=5432

ENTRYPOINT ["/entrypoint.sh"]
