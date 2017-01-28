PG_VERSION=9.4
PG_LOG=/var/log/postgresql/postgresql-$PG_VERSION-main.log

ldconfig

sed -i 's|^#checkpoint_timeout = 5min|checkpoint_timeout = 1h|;s|^#checkpoint_warning = 30s|checkpoint_warning = 0|' /etc/postgresql/$PG_VERSION/main/postgresql.conf

{ echo; echo "host all all 127.0.0.1/32 trust"; } >> "/etc/postgresql/$PG_VERSION/main/pg_hba.conf"

rm -f $PG_LOG

echo "<<< Starting postgresql..."
service postgresql start

until grep "database system is ready to accept connections" $PG_LOG
do 
	echo "<<< Waiting for PostgreSQL to start..."
	sleep 1
done

su - postgres -c "createuser -DRS root"
su - postgres -c "createdb -O root tasks"
su - postgres -c "psql tasks -c 'create role dba with superuser noinherit; grant dba to root; create extension \"uuid-ossp\";'"

# openvas-mkcert -f -q
# /usr/local/sbin/openvas-nvt-sync
# openvassd
# /usr/local/sbin/openvas-scapdata-sync
# /usr/local/sbin/openvas-certdata-sync
# openvas-mkcert-client -n -i
# echo "Starting openvasmd"
# #openvasmd
# echo "Rebuilding Openvasmd..."
# openvasmd --rebuild -v;
# echo "Creating Admin user..."
# openvasmd --create-user=admin --role=Admin
# echo "Setting Admin user password..."
# openvasmd --user=admin --new-password=openvas
# echo "Kill openvassd"
# ps aux | grep openvassd| awk '{print $2}' |xargs kill -9

echo "<<< Stopping postgresql..."
service postgresql stop

echo "Finished setup..."
