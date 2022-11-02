--- For our analysis we need only account name i.e sender of email, subject and the email body. EXTRACT message from email
use cloud;

drop table if exists temp;
create table temp as select trim(p.sender) as sender,trim(p.subject) as subject,trim(REGEXP_REPLACE(regexp_extract(p.message_clean, '\.nsf(.*)|\.pst(.*)',0),'.pst|.nsf',"")) AS message from (
SELECT substring(message, locate('X-FileName:', message) + length('X-FileName:'),locate('  ',message) - length('  ') - 2) as message_clean,
regexp_replace(regexp_extract(message,'From:(.*) To: ',1),'To:(.*)',"") as sender,
regexp_replace(regexp_extract(message,'Subject:(.*) Content-Type:'),'Content-Type:(.*)',"") as subject
from email)as p  where sender not like ' ' ;

----------- remove special characters and drop null sender rows
drop table if exists temp1;
create table temp1 as select trim(REGEXP_REPLACE(sender,'[^A-Za-z0-9@]',"")) as sender, REGEXP_REPLACE(subject,'[^A-Za-z0-9\\s@]',"") as subject, REGEXP_REPLACE(message,'[^A-Za-z0-9\\s]',"") as message from temp WHERE sender not in ("");

----------- remove stopwords
drop table if exists cleaned_emails;
create table cleaned_emails as select sender, subject,regexp_replace(lower(message),
' me |
 my |
 myself |
 we |
 our |
 ours |
 ourselves |
 you |
 your |
 yours |
 yourself |
 yourselves |
 he |
 him |
 his |
 himself |
 she |
 her |
 hers |
 herself |
 it |
 its |
 itself |
 they |
 them |
 their |
 theirs |
 themselves |
 what |
 which |
 who |
 whom |
 this |
 that |
 these |
 those |
 am |
 is |
 are |
 was |
 were |
 be |
 been |
 being |
 have |
 has |
 had |
 having |
 do |
 does |
 did |
 doing |
 an |
 the |
 and |
 but |
 if |
 or |
 because |
 as |
 until |
 while |
 of |
 at |
 by |
 for |
 with |
 about |
 against |
 between |
 into |
 through |
 during |
 before |
 after |
 above |
 below |
 to |
 from |
 up |
 down |
 in |
 out |
 on |
 off |
 over |
 under |
 again |
 further |
 then |
 once |
 here |
 there |
 when |
 where |
 why |
 how |
 all |
 any |
 both |
 each |
 few |
 more |
 most |
 other |
 some |
 such |
 no |
 nor |
 not |
 only |
 own |
 same |
 so |
 than |
 too |
 very |
 can |
 will |
 just |
 don |
 should |
 now '
,"") as message from temp1;





drop table if exists spams1;
CREATE TABLE IF NOT EXISTS spams1 as (select lower(spams.spam_words) as spam_words from spams);

drop table if exists hams1;
CREATE TABLE IF NOT EXISTS hams1 as (select lower(hams.ham_words) as ham_words from hams);

--drop table spams;
--drop table hams;

