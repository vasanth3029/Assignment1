-- create main data table
use cloud;

drop table if exists email;
CREATE TABLE IF NOT EXISTS email (
files String,
message string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ("escapeChar" = "\\n" ) STORED AS TEXTFILE;
LOAD DATA INPATH "gs://dataproc-staging-us-central1-116474219576-1zo2nt5h/data/data.csv" INTO TABLE email;

-- create spam data
drop table if exists spams;
CREATE TABLE IF NOT EXISTS spams (
spam_words String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ("escapeChar" = "\\n" ) STORED AS TEXTFILE;
LOAD DATA INPATH "gs://dataproc-staging-us-central1-116474219576-1zo2nt5h/data/spam_words.csv" INTO TABLE spams;

---- Create Ham data
drop table if exists hams;
CREATE TABLE IF NOT EXISTS hams (
ham_words String)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ("escapeChar" = "\\n" ) STORED AS TEXTFILE;
LOAD DATA INPATH "gs://dataproc-staging-us-central1-116474219576-1zo2nt5h/data/ham_words.csv" INTO TABLE hams;