import sys
prev_word = None
count = 1 
word = None
df={}
l1=[]
# input comes from STDIN
for in_line in sys.stdin:
    in_line = in_line.strip()
    word,z= in_line.split('\t', 1)
    file_n,wc_dc_count = z.split(' ',1)
    words_c,doc_count=wc_dc_count.split(' ',1)
    doc_count,map_count=doc_count.split(' ',1)
    #find the number of docs it is present in for each word
    if prev_word == word:
        count = count+int(map_count)
    else:
        if prev_word != None:
            wc_dc_c=words_c+' '+doc_count+' '+str(count)
            df[prev_word]=wc_dc_c
            j=prev_word+' '+file_n
            l1.append(j)
        count=1
        prev_word = word

       
wc_dc_c=words_c+' '+doc_count+' '+str(count)
df[prev_word]=wc_dc_c
j=prev_word+' '+file_n
l1.append(j)

for doc in l1:
   word,file_n=doc.split(' ',1)
   for d in df:
       if word == d:
          print '%s\t%s' % (doc,df[d])
