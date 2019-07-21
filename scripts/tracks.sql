GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'debezium' IDENTIFIED BY 'dbz';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE demo;
GRANT ALL PRIVILEGES ON demo.* TO 'mysqluser'@'%';

use demo;

create table delivery_orders (
	order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	destination POINT,
	email VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table tracks (
	track_id VARCHAR(60),
	brand VARCHAR(255),
	production_year INT,
	company VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

insert into delivery_orders(destination, email) values (POINT(53.72, -1.58), 'dskora@arden.ac.uk');

insert into tracks(track_id, brand, production_year, company) values ('trv313c', 'Mercedess', 2017, 'GD Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('trv0123', 'Ford', 2017, 'GD Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('crv0123', 'Ford', 2017, 'Red Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('jrv0123', 'Ford', 2012, 'Red Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('45u313c', 'Mercedess', 2017, 'GD Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('nr00123', 'Mercedess', 2016, 'GD Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('brv2123', 'Ford', 2016, 'GD Logistics LTD');
insert into tracks(track_id, brand, production_year, company) values ('1rv0123', 'Mercedess', 2017, 'Red Logistics LTD');
