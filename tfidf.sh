## extract ham messages from hive to local directory as csv
hive -e 'set hive.cli.print.header=true; select sender,REGEXP_REPLACE(REGEXP_REPLACE(message,"[^A-Za-z\\s]",""),"\\t","\s") as message from cloud.group_ham' | sed 's/[\t]/,/g'  > ham_messages.csv
hive -e 'set hive.cli.print.header=true; select sender,REGEXP_REPLACE(REGEXP_REPLACE(message,"[^A-Za-z\\s]",""),"\\t","\s") as message from cloud.group_spam' | sed 's/[\t]/,/g'  > spam_messages.csv

python message_split.py
hdfs dfs -rm /user/vasanth3029/tfidf/ham/ham_input/*
hdfs dfs -put /home/vasanth3029/tfidf/ham_input/*  /user/vasanth3029/tfidf/ham/ham_input/

hdfs dfs -rm -r /user/vasanth3029/tfidf/ham/output1
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper1.py \
-mapper "python mapper1.py" \
-file /home/vasanth3029/tfidf/reducer1.py \
-reducer "python reducer1.py" \
-input /user/vasanth3029/tfidf/ham/ham_input/*.txt \
-output /user/vasanth3029/tfidf/ham/output1

hdfs dfs -cat /user/vasanth3029/tfidf/ham/output1/*>tfidf/ham_output1
hdfs dfs -put tfidf/ham_output1 /user/vasanth3029/tfidf/ham/output1/

##Command to execute second map-reduce job
hdfs dfs -rm -r /user/vasanth3029/tfidf/ham/output2
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper2.py \
-mapper "python mapper2.py" \
-file /home/vasanth3029/tfidf/reducer2.py \
-reducer "python reducer2.py" \
-input /user/vasanth3029/tfidf/ham/output1/ham_output1 \
-output /user/vasanth3029/tfidf/ham/output2
hdfs dfs -cat /user/vasanth3029/tfidf/ham/output2/*>tfidf/ham_output2
hdfs dfs -put tfidf/ham_output2 /user/vasanth3029/tfidf/ham/output2/

##Command to execute third map-reduce job
hdfs dfs -rm -r /user/vasanth3029/tfidf/ham/output3
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper3.py \
-mapper "python mapper3.py" \
-file /home/vasanth3029/tfidf/reducer3.py \
-reducer "python reducer3.py" \
-input /user/vasanth3029/tfidf/ham/output2/ham_output2 \
-output /user/vasanth3029/tfidf/ham/output3
hdfs dfs -cat /user/vasanth3029/tfidf/ham/output3/*>tfidf/ham_output3
hdfs dfs -put tfidf/ham_output3 /user/vasanth3029/tfidf/ham/output3/


hdfs dfs -rm -r /user/vasanth3029/tfidf/ham/output4
##Command to execute fourth map job

hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-numReduceTasks 0 \
-file /home/vasanth3029/tfidf/mapper4.py \
-mapper "python mapper4.py" \
-input /user/vasanth3029/tfidf/ham/output3/ham_output3 \
-output /user/vasanth3029/tfidf/ham/output4

hdfs dfs -cat /user/vasanth3029/tfidf/ham/output4/*>tfidf/ham_output4

########################################################################### SPAM #############################################

hive -e 'set hive.cli.print.header=true; select sender,REGEXP_REPLACE(REGEXP_REPLACE(message,"[^A-Za-z\\s]",""),"\\t","\s") as message from cloud.group_spam' | sed 's/[\t]/,/g'  > spam_messages.csv
python message_split_spam.py
hdfs dfs -rm /user/vasanth3029/tfidf/spam/spam_input/*
hdfs dfs -put /home/vasanth3029/tfidf/spam_input/*  /user/vasanth3029/tfidf/spam/spam_input/

hdfs dfs -rm -r /user/vasanth3029/tfidf/spam/output1
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper1.py \
-mapper "python mapper1.py" \
-file /home/vasanth3029/tfidf/reducer1.py \
-reducer "python reducer1.py" \
-input /user/vasanth3029/tfidf/spam/spam_input/*.txt \
-output /user/vasanth3029/tfidf/spam/output1

hdfs dfs -cat /user/vasanth3029/tfidf/spam/output1/*>tfidf/spam_output1
hdfs dfs -put tfidf/spam_output1 /user/vasanth3029/tfidf/spam/output1/

##Command to execute second map-reduce job
hdfs dfs -rm -r /user/vasanth3029/tfidf/spam/output2
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper2.py \
-mapper "python mapper2.py" \
-file /home/vasanth3029/tfidf/reducer2.py \
-reducer "python reducer2.py" \
-input /user/vasanth3029/tfidf/spam/output1/spam_output1 \
-output /user/vasanth3029/tfidf/spam/output2
hdfs dfs -cat /user/vasanth3029/tfidf/spam/output2/*>tfidf/spam_output2
hdfs dfs -put tfidf/spam_output2 /user/vasanth3029/tfidf/spam/output2/

##Command to execute third map-reduce job
hdfs dfs -rm -r /user/vasanth3029/tfidf/spam/output3
hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-file /home/vasanth3029/tfidf/mapper3.py \
-mapper "python mapper3.py" \
-file /home/vasanth3029/tfidf/reducer3.py \
-reducer "python reducer3.py" \
-input /user/vasanth3029/tfidf/spam/output2/spam_output2 \
-output /user/vasanth3029/tfidf/spam/output3
hdfs dfs -cat /user/vasanth3029/tfidf/spam/output3/*>tfidf/spam_output3
hdfs dfs -put tfidf/spam_output3 /user/vasanth3029/tfidf/spam/output3/


hdfs dfs -rm -r /user/vasanth3029/tfidf/spam/output4
##Command to execute fourth map job

hadoop jar $HADOOP_HOME/hadoop-streaming-3.2.3.jar \
-numReduceTasks 0 \
-file /home/vasanth3029/tfidf/mapper4.py \
-mapper "python mapper4.py" \
-input /user/vasanth3029/tfidf/spam/output3/spam_output3 \
-output /user/vasanth3029/tfidf/spam/output4

hdfs dfs -cat /user/vasanth3029/tfidf/spam/output4/*>tfidf/spam_output4
