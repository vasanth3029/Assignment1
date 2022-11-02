------------- spam dataset creation------------------------------------------------------------------------
use cloud;
---- check spam words in subject
drop table if exists spam_data1;
create table spam_data1 as SELECT trim(t.sender) as sender,t.subject,t.message
FROM cleaned_emails t,spams1 s where lower(t.subject)
LIKE  CONCAT('%', s.spam_words, '%');

---- check spam words in email body
drop table if exists spam_data;
create table spam_data as SELECT trim(t.sender) as sender,t.subject,t.message 
FROM spam_data1 t,spams1 s where lower(t.message)
LIKE  CONCAT('%', s.spam_words, '%');


---- find the top 10 SPAM accounts
select sender, count(*) as spam_mails
from spam_data
group by sender order by spam_mails desc limit 10;

create table spam_tops as select t.sender as sender from (select sender, count(*) as spam_mails
from spam_data where sender not like " " 
group by sender order by spam_mails desc limit 10) t;

---- storing top 10 spam_data
drop table if exists top_spam_data;
create table top_spam_data as select t.sender,t.message from spam_data t, spam_tops h where t.sender like CONCAT(h.sender);

------ group all messages for a person
drop table if exists group_spam;

create table group_spam as SELECT sender,
concat_ws(' ' , collect_set(message)) as message
FROM top_spam_data
GROUP BY sender;

------------------- Ham dataset creation-----------------------------------------------------------------------------------
drop table if exists ham_data1;
create table ham_data1 as SELECT trim(t.sender) as sender,t.subject,REGEXP_REPLACE(t.message,"[^A-Za-z0-9\\s]","") as message
FROM cleaned_emails t,hams1 s where lower(t.subject)
LIKE  CONCAT('%', s.ham_words, '%');

drop table if exists ham_data;
create table ham_data as SELECT trim(t.sender) as sender,t.subject,lower(t.message) as message
FROM ham_data1 t,hams1 s where lower(t.message)
LIKE  CONCAT('%', s.ham_words, '%');

---- find the top 10 HAM accounts
select sender, count(*) as ham_mails
from ham_data where sender not like " " 
group by sender order by ham_mails desc limit 10


create table ham_tops as select t.sender as sender from (select sender, count(*) as ham_mails
from ham_data where sender not like " " 
group by sender order by ham_mails desc limit 10) t;

---- storing top 10 ham_data
drop table if exists top_ham_data;
create table top_ham_data as select t.sender,t.message from ham_data t, ham_tops h where t.sender like CONCAT(h.sender);

------ group all messages for a person
drop table if exists group_ham;

create table group_ham as SELECT sender,
concat_ws(' ' , collect_set(message)) as message
FROM top_ham_data
GROUP BY sender;


