import sys

current_word = None
prev_filename = None
word = None
doc_word_count=0
df={}
l1=[]


for in_line in sys.stdin:
    in_line = in_line.strip()
    l1.append(in_line)
    filename,wordcount = in_line.split('\t', 1)
    word,count = wordcount.split(' ', 1)
    count=int(count)
    #get the number of words in each document
    if prev_filename == filename:
        doc_word_count=doc_word_count+count
    else:
       if prev_filename != None:
            df[prev_filename]=doc_word_count
       doc_word_count=count
       prev_filename = filename
df[prev_filename]=doc_word_count

### using the count obtained above combine it with the respective word and document
for in_line in l1:
    filename,wordcount = in_line.split('\t', 1)
    word,count = wordcount.split(' ', 1) 
    for doc in df:
        if filename == doc:
           word_file=word+' '+filename
           word_doc_count=count+' '+str(df[doc])
           print '%s\t%s' % (word_file,word_doc_count)
    
